#[cfg(test)]
mod test {

    use serial_test::serial;

    use crate::test_runner::test_base::TestBase;

    #[tokio::test]
    #[serial]
    async fn cdc_basic_test() {
        TestBase::run_cdc_test("mysql_to_starrocks/cdc/3_1_5/basic_test", 3000, 1000).await;
    }
}
