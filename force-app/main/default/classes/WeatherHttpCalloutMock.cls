@isTest
global class WeatherHttpCalloutMock implements HttpCalloutMock{
    global HttpResponse respond(HTTPRequest request){
        Http http = new Http();
        //HttpRequest request = new HttpRequest();
        String endPoint = 'api.openweathermap.org/data/2.5/weather?q=London&appid=291b0417d11813fe3de86c6891e311c0';
        request.setEndpoint(endPoint);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug(response);
        return response;
    }
}