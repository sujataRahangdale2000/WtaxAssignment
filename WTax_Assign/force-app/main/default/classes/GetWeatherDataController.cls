/**
 * @description       :
 * @author            : Sujata Rahagdale
 * @group             :
 * @last modified on  : 05-31-2026
 * @last modified by  : Sujata Rahangdale
 **/
public class GetWeatherDataController {
    
    @AuraEnabled(cacheable=true)
    public static List<City__c> returnCities() {
        return [SELECT Id, Name FROM City__c ORDER BY Name ];
    }
    @AuraEnabled
    public static List<WeatherDetail_WrapperClass> getForecast(Id cityId, Date selectedDate){
        City__c city = [SELECT Name, Latitude__c, Longitude__c FROM City__c WHERE Id = :cityId LIMIT 1];
        
        String endpoint =
            'https://api.open-meteo.com/v1/forecast'
            + '?latitude=' + city.Latitude__c
            + '&longitude=' + city.Longitude__c
            + '&hourly=temperature_2m'
            + '&start_date=' + String.valueOf(selectedDate)
            + '&end_date=' + String.valueOf(selectedDate);
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
        String timezone = String.valueOf(result.get('timezone'));
        WeatherSearch__c searchLog = new WeatherSearch__c();
        searchLog.User_Name__c = UserInfo.getName();
        searchLog.Search_Date_Time__c = System.now();
        searchLog.Forecast_Date__c = selectedDate;
        searchLog.Location__c = city.Name;
        searchLog.Timezone__c = timezone;

        insert searchLog;
        System.debug('searchLog>>'+searchLog);
        Map<String,Object> hourly = (Map<String,Object>)result.get('hourly');
        List<Object> times = (List<Object>)hourly.get('time');
        List<Object> temps = (List<Object>)hourly.get('temperature_2m');
        List<WeatherDetail_WrapperClass> forecastdetail = new List<WeatherDetail_WrapperClass>();
        
        for(Integer i=0;i<times.size();i++) {
            WeatherDetail_WrapperClass w = new WeatherDetail_WrapperClass();
            w.reqtime = String.valueOf(times[i]);
            w.temperature =Decimal.valueOf(String.valueOf(temps[i]));
            forecastdetail.add(w);
        }
        return forecastdetail;
    }
}