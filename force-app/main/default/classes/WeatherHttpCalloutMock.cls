@isTest
global class WeatherHttpCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HttpRequest request){    
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        string jsonResBody = '{  "weather": ['+
            '{"id": 800, "main": "Clear","description": "clear sky","icon": "01d"}],'+
          '"main": {"temp": 282.55,"feels_like": 281.86,"temp_min": 280.37,"temp_max": 284.26,"pressure": 1023,"humidity": 100}}';
        res.setBody(jsonResBody);
        res.setStatusCode(200);
        return res;
    }
}