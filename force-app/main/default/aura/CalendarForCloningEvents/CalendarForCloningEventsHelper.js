({
    fireAlertAboutUnselectedDays : function() {
        let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "type" : "error",
                "title" : "error",
                "message" : "You have to choose one day at least"
            });
            toastEvent.fire();
    },

    fireAlertAboutUnselectedDate : function(){
        let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "type" : "error",
                "title" : "error",
                "message" : "You have to estimate end date that bigger than now"
            });
            toastEvent.fire();
    },

    fireSuccessAlert : function(quantity){
        let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type" : "success",
                    "title" : "success",
                    "message" : quantity + " records were created with estimated dates"
                });
                toastEvent.fire();
    },

    changeFormatOfDates : function(dates){
        console.log("here")
        let correctFormatOfEvents = [];
        let correctFormat = "";

        for(let date of dates){
            let correctFormatOfMonth = (date.getMonth().toString().length === 2 ? (date.getMonth() + 1) : "0" + (date.getMonth() + 1).toString());
            let correctFormatOfDate = (date.getDate().toString().length === 2 ? date.getDate() : "0" + date.getDate().toString());
            correctFormat = date.getFullYear() + "-" + correctFormatOfMonth + "-" + correctFormatOfDate;
            correctFormatOfEvents.push(correctFormat);
        }
        console.log(correctFormatOfEvents);
        return correctFormatOfEvents;

    }
})
