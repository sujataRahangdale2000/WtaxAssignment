@isTest
private class WeatherDetail_WrapperClassTest {

    @isTest
    static void testWrapperValues() {
        WeatherDetail_WrapperClass wrapper = new WeatherDetail_WrapperClass();
        wrapper.reqtime = '2026-05-31T00:00';
        wrapper.temperature = 28.5;
        System.assertEquals('2026-05-31T00:00',wrapper.reqtime);
        System.assertEquals(28.5,wrapper.temperature);
    }
}