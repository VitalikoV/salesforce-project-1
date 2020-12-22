@isTest
private class WeatherCalloutTest {
    @isTest static void testCallout(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, new WeatherHttpCalloutMock());
        Test.startTest();
        Account acc = new Account(Name = 'Weather', BillingCity = 'London');
        insert acc;
        Id accId = acc.id;
        Object result = WeatherCallout.getWeather(accId);
        Test.stopTest();
        
        System.assertEquals(null, result);
    }
}