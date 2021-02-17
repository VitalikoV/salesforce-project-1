({
    sendData : function(component, event, helper) {
        let quantityOfTimes = component.find("quantityOfTimes").get("v.value");
        // console.log(component.find("quantityOfTimes").get("v.value"));
        let segment = component.find("segment").get("v.value");
        // console.log(component.find("segment").get("v.value"));
        let days = component.get("v.selectedCheckboxes");
        // console.log(days);
        let endDate = component.find("endDate").get("v.value");
        //console.log(endDate);
        let dates = [];

        if(days.length <= 0){
            helper.fireAlertAboutUnselectedDays();
        }else if(endDate === "" || Date.parse(endDate) < Date.parse(new Date())){
            helper.fireAlertAboutUnselectedDate();
        }else{
        let firstTimeExecuted = 0;
        let currDate = new Date();

        if(segment === "Week"){
            while(Date.parse(currDate) <= Date.parse(endDate)){
                if(firstTimeExecuted === 0){
                firstTimeExecuted++;
                }else{
                    currDate.setDate(currDate.getDate() + Number.parseInt(7 * quantityOfTimes));    
                }
                for(let val of days){
                let day = currDate.getDay();
                let diff = currDate.getDate() - day + Number.parseInt(val);

                if(Date.parse(new Date(currDate.setDate(diff))) >= Date.parse(new Date()) &&
                Date.parse(new Date(currDate.setDate(diff))) <= Date.parse(endDate)){
                    dates.push(new Date(currDate.setDate(diff)));
                }else{
                    ///console.log("continue");
                    continue;
                }

                }
            }
        }else{
            while(Date.parse(currDate) < Date.parse(endDate)){
                if(firstTimeExecuted === 0){
                    firstTimeExecuted++;
                }else{
                    currDate.setMonth(currDate.getMonth() + Number.parseInt(quantityOfTimes));
                }
                for(let val of days){
                let day = currDate.getDay();
                let diff = currDate.getDate() - day + Number.parseInt(val);
                //console.log(new Date(currDate.setDate(diff)));
                if(Date.parse(new Date(currDate.setDate(diff))) >= Date.parse(new Date()) &&
                Date.parse(new Date(currDate.setDate(diff))) <= Date.parse(endDate)){
                dates.push(new Date(currDate.setDate(diff)));
                }else{
                    continue;
                }
                }
            }
        }

        console.log(dates);
        console.log("-----------");
        let correctFormatOfEvents = [];

        // change javascript format of time to apex
        correctFormatOfEvents = helper.changeFormatOfDates(dates);
        console.log(correctFormatOfEvents);


        let action = component.get("c.cloneObjectsWithDateOfEvent");

        action.setParams({
            recordId : component.get("v.recordId"),
            dates : correctFormatOfEvents
        });

        action.setCallback(this, function(response){
            let state = response.getState();
            let quantityOfRecords = response.getReturnValue();
            console.log(state);
            console.log(quantityOfRecords);
            if(state === "SUCCESS"){
                helper.fireSuccessAlert(quantityOfRecords);
            }else{
                console.log("error");
            }
            
        });

        $A.enqueueAction(action);
    }
    },

    setCheckbox: function(component, event, helper){
        let checkboxId = event.target.id;
        let checkboxValue = document.getElementById(checkboxId).value;
        
        let selectedCheckboxes = component.get("v.selectedCheckboxes");
        if(selectedCheckboxes.indexOf(checkboxValue) > -1){
            selectedCheckboxes.splice(selectedCheckboxes.indexOf(checkboxValue), 1);  
        }else{
            selectedCheckboxes.push(checkboxValue);
        }

        component.set("v.selectedCheckboxes", selectedCheckboxes);
        console.log(selectedCheckboxes);

    }
})
