#[cfg(test)]
mod test {
    use serial_test::serial;
    use tokio::runtime::Runtime;

    use crate::test::test_runner::TestRunner;

    const TEST_DIR: &str = "src/test/mysql_to_mysql";

    #[test]
    #[serial]
    fn snapshot_basic_test() {
        let src_ddl_file = format!("{}/snapshot_basic_test/src_ddl.sql", TEST_DIR);
        let dst_ddl_file = format!("{}/snapshot_basic_test/dst_ddl.sql", TEST_DIR);
        let src_dml_file = format!("{}/snapshot_basic_test/src_dml.sql", TEST_DIR);
        let task_config_file = format!("{}/snapshot_basic_test/task_config.ini", TEST_DIR);

        // compare src and dst data
        let src_tbs = TestRunner::get_default_tbs();
        let dst_tbs = TestRunner::get_default_tbs();
        let cols = TestRunner::get_default_tb_cols();
        let mut cols_list = Vec::new();
        for _ in 0..src_tbs.len() {
            cols_list.push(cols.clone());
        }

        let rt = Runtime::new().unwrap();
        let runner = rt.block_on(TestRunner::new(&task_config_file)).unwrap();
        rt.block_on(runner.run_snapshot_test(
            &src_ddl_file,
            &dst_ddl_file,
            &src_dml_file,
            &task_config_file,
            &src_tbs,
            &dst_tbs,
            &cols_list,
        ))
        .unwrap();
    }
}
