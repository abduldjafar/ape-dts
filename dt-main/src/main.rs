use std::{env, process};

use dt_precheck::{config::task_config::PrecheckTaskConfig, do_precheck};
use dt_task::task_runner::TaskRunner;

#[tokio::main]
async fn main() {
    env::set_var("RUST_BACKTRACE", "1");

    if let Err(e) = run().await {
        eprintln!("Error: {}", e);
        eprintln!("Usage: dt-main <task_config>");
        eprintln!("Example: dt-main config.toml");
        process::exit(1);
    }
}

async fn run() -> Result<(), String> {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        return Err("No task_config provided in args.".to_string());
    }

    let task_config = args[1].clone();

    if PrecheckTaskConfig::new(&task_config).is_ok() {
        do_precheck(&task_config).await;
    } else {
        let runner = TaskRunner::new(&task_config)
            .map_err(|_| "Failed to create TaskRunner.".to_string())?;
        runner
            .start_task(true)
            .await
            .map_err(|_| "Failed to start task.".to_string())?;
    }

    Ok(())
}
