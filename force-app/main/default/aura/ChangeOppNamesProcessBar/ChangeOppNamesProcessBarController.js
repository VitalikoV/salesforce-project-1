({
    executeBatch : function(component, event, helper) {
        //execute changing names
        let action = component.get("c.changeNamesByOne");
        action.setCallback(this, function(response) {
            let state = response.getState();

            console.log(state);
            console.log(response.getReturnValue());

            if (state === "SUCCESS") {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "success",
                    "title": "Success!",
                    "message": "The Job has been successfully initiated."
                });
                toastEvent.fire();

                if (state === "SUCCESS"){
                    let interval = setInterval($A.getCallback(function () {
                        //check every 0,1 second for changes
                        let jobStatus = component.get("c.getBatchJobStatus");
                        if(jobStatus != null){

                            jobStatus.setParams({ jobID : response.getReturnValue()});

                            jobStatus.setCallback(this, function(jobStatusResponse){
                                let state = jobStatus.getState();
                                if (state === "SUCCESS"){
                                    let job = jobStatusResponse.getReturnValue();

                                    component.set('v.apexJob',job);

                                    let processedPercent = 0;
                                    if(job.JobItemsProcessed != 0){
                                        processedPercent = (job.JobItemsProcessed / job.TotalJobItems) * 100;
                                    }
                                    let progress = component.get('v.progress');
                                    component.set('v.progress', progress === 100 ? interval :  processedPercent);
                                }
                            });
                            $A.enqueueAction(jobStatus);
                        }
                    }), 100);
                }
            }
            else if (state === "ERROR") {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "error",
                    "title": "Error!",
                    "message": "An Error has occured. Please try again or contact System Administrator."
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    }

})
