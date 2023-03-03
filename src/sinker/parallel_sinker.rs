use std::sync::atomic::{AtomicBool, Ordering};

use concurrent_queue::ConcurrentQueue;
use futures::future::join_all;
use log::info;

use crate::{
    error::Error,
    meta::row_data::RowData,
    task::task_util::TaskUtil,
    traits::traits::{Partitioner, Sinker},
};

pub struct ParallelSinker<'a> {
    pub buffer: &'a ConcurrentQueue<RowData>,
    pub partitioner: Box<dyn Partitioner>,
    pub sub_sinkers: Vec<Box<dyn Sinker>>,
    pub shut_down: &'a AtomicBool,
}

const POSITION_FILE_LOGGER: &str = "position_file_logger";

impl ParallelSinker<'_> {
    pub async fn close(&mut self) -> Result<(), Error> {
        for sinker in self.sub_sinkers.iter_mut() {
            sinker.close().await.unwrap();
        }
        Ok(())
    }

    pub async fn sink(&mut self) -> Result<(), Error> {
        while !self.shut_down.load(Ordering::Acquire) || !self.buffer.is_empty() {
            // process all row_datas in buffer at a time
            let slice_count = self.sub_sinkers.len();
            let mut all_data = Vec::new();
            while let Ok(row_data) = self.buffer.pop() {
                // if the row_data can not be partitioned, sink the pushed data immediately
                if !self.partitioner.can_be_partitioned(&row_data).await? {
                    all_data.push(row_data);
                    break;
                } else {
                    all_data.push(row_data);
                }
            }

            // record the last row_data for logging position_info
            let mut last_row_data = Option::None;
            if !all_data.is_empty() {
                last_row_data = Some(all_data[all_data.len() - 1].clone());
            }

            // slice data
            let mut sub_datas = self.partitioner.partition(all_data, slice_count).await?;

            // start sub sinkers
            let mut futures = Vec::new();
            for sinker in self.sub_sinkers.iter_mut() {
                futures.push(sinker.sink(sub_datas.remove(0)));
            }

            // wait for sub sinkers to finish and unwrap errors if happen
            let result = join_all(futures).await;
            for res in result {
                res.unwrap();
            }

            // record position
            if let Some(row_data) = last_row_data {
                info!(target: POSITION_FILE_LOGGER, "{}", row_data.position);
            }

            // sleep 1 millis for data preparing
            TaskUtil::sleep_millis(1).await;
        }

        Ok(())
    }
}
