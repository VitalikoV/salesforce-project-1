@isTest
private class WeatherCalloutTest {
    
    @TestSetup static void createAccount(){
        Account acc = new Account(Name = 'Weather', BillingCity = 'London');
		insert acc;
    }
    
    @isTest static void testCallout(){
        getMock();
        Test.startTest();
        Id accId = getAccountId();
        HttpResponse result = WeatherCallout.getHttpData(accId);
        Test.stopTest();
        
        System.assertEquals(200,result.getStatusCode());
        System.assertEquals('application/json', result.getHeader('Content-Type'));
    }
    
    @isTest static void testWeatherParser(){
        getMock();
        Test.startTest();
        Id accId = getAccountId();
        Object result = WeatherCallout.getWeather(accId);
        Test.stopTest();

        Map<String, Object> expectedWeather = new Map<String, Object>();
        expectedWeather.put('id', 800);
        expectedWeather.put('main', 'Clear');
        expectedWeather.put('description', 'clear sky');
        expectedWeather.put('icon', '01d');
        
        System.assertEquals(expectedWeather, result);
    }
    
    @isTest static void testAllWeather(){
        getMock();
        Test.startTest();
		Id accId = getAccountId();
        Object result = WeatherCallout.getAllWeather(accId);
        Test.stopTest();
 
        Map<String, Object> expectedAll = new Map<String, Object>();
        expectedAll.put('temp', 282.55);
        expectedAll.put('feels_like', 281.86);
        expectedAll.put('temp_min', 280.37);
        expectedAll.put('temp_max', 284.26);
        expectedAll.put('pressure', 1023);
        expectedAll.put('humidity', 100);
        
        Map<String, Object> expectedWeather = new Map<String, Object>();
        expectedWeather.put('id', 800);
        expectedWeather.put('main', 'Clear');
        expectedWeather.put('description', 'clear sky');
        expectedWeather.put('icon', '01d');
        
        List<Object> expectedWeatherList = new List<Object>();
        expectedWeatherList.add(expectedWeather);
        
        Map<String, Object> expectedMap = new Map<String, Object>();
        expectedMap.put('main', expectedAll);
        expectedMap.put('weather', expectedWeatherList);
        
        System.assertEquals(expectedMap, result);
    }
    
    static void getMock(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, new WeatherHttpCalloutMock());
    }
    
    static Id getAccountId(){
        List<Account> accs = [SELECT BillingCity FROM Account Where Name='Weather' LIMIT 1];
        return accs.get(0).id;
    }
}