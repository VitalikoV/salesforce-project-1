public class WeatherCallout {
    
    @AuraEnabled(cacheable=true)
    public static Object getWeather(Id recordId){
        HttpResponse response = getHttpData(recordId);
        Object weatherData;
        if(response.getStatusCode() == 200){
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> weatherResults = (List<Object>)(results.get('weather'));
        	weatherData = weatherResults.get(0);
        }
        return weatherData;
    }
    
    @AuraEnabled(cacheable=true)
    public static Object getAllWeather(Id recordId){
        HttpResponse response = getHttpData(recordId);
        Map<String, Object> results = new Map<String, Object>();
        if(response.getStatusCode() == 200){
             results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }
        return results;
    }
    
    public static HttpResponse getHttpData(id recordId){
        List<Account> accList = [SELECT BillingCity FROM Account WHERE id = :recordId];
        String bCity = accList.get(0).BillingCity;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String address = 'http://api.openweathermap.org/data/2.5/weather?';
        //For example "New York" -> "NewYork"
        bCity = bCity.replaceAll('\\s+', ''); 
        String city = 'q=' + bCity;
        //My generated key for current weather
        String generatedKey = '&appid=291b0417d11813fe3de86c6891e311c0';
        //Metric system
        String metric = '&units=metric';
        String endPoint = address + city + generatedKey + metric;
        request.setEndpoint(endPoint);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        return response;
    }
}