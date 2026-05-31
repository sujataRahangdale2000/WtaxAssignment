@isTest
private class GetWeatherDataControllerTest {
    @testSetup
    static void createData() {
        City__c city = new City__c(
            Name = 'Pune',
            Latitude__c = 18.5204,
            Longitude__c = 73.8567
        );
        insert city;
    }
    
    @isTest
    static void testReturnCities() {
        
        Test.startTest();
        List<City__c> cities = GetWeatherDataController.returnCities();
        Test.stopTest();
        System.assertEquals(1, cities.size());
        System.assertEquals('Pune', cities[0].Name);
    }
    
    @isTest
    static void testGetForecast() {
        
        City__c city = [SELECT Id, Name FROM City__c LIMIT 1];
        Test.setMock(HttpCalloutMock.class,new WeatherDataAPIMock());
        
        Test.startTest();
        List<WeatherDetail_WrapperClass> result = GetWeatherDataController.getForecast(city.Id,Date.today());
        Test.stopTest();
        
        System.assertEquals(2, result.size());
        System.assertEquals('2026-05-31T00:00',result[0].reqtime);
        System.assertEquals(28.5,result[0].temperature);
        
        List<WeatherSearch__c> logs = [SELECT Id,User_Name__c,Forecast_Date__c,Location__c,Timezone__c FROM WeatherSearch__c];
        System.assertEquals(1, logs.size());
        System.assertEquals('Pune',logs[0].Location__c);
        System.assertEquals('Asia/Kolkata',logs[0].Timezone__c);
    }
}