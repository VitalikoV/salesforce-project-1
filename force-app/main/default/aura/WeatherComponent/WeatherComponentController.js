({  
    doInit : function(component, event, helper) {
		let data = component.get('c.getAllWeather');
        data.setParams({
            recordId: component.get('v.recordId')
        });
        
        data.setCallback(this, function(response){
            let weather = response.getReturnValue();
            let state = response.getState();
            console.log(weather);
            if(state === 'SUCCESS'){
                component.set("v.main", weather.main);
                component.set("v.weather", weather.weather[0]);
                component.set("v.city", weather.name);
                component.set("v.icon", "http://openweathermap.org/img/w/" + weather.weather[0].icon + ".png");
            }
        });
        $A.enqueueAction(data);
	}
})