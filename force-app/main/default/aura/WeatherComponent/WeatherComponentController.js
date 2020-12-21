({
	doInit : function(component, event, helper) {
		let data = component.get('c.getWeather');
        data.setParams({
            recordId: component.get('v.recordId')
        });
        
        data.setCallback(this, function(response){
            let weather = response.getReturnValue();
            let state = response.getState();
            console.log(weather);
            if(state === 'SUCCESS'){
                component.set("v.weather", weather);
                component.set("v.icon", "http://openweathermap.org/img/w/" + weather.icon + ".png")
            }
        });
        
        $A.enqueueAction(data);
	}
})