({
	doInit : function(component, event, helper) {
		helper.setColumns(component);
        helper.queryContacts(component);
    },
    
        //function invokes when user press Next button
     handleNext : function(component, event, helper) { 
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber+1);
        helper.queryContacts(component);
    },

    //function invokes when user press Prev button
    handlePrev : function(component, event, helper) {        
        var pageNumber = component.get("v.pageNumber");
        component.set("v.pageNumber", pageNumber-1);
        helper.queryContacts(component);
    }, 
    
    //retreive field, that required to sort and direction(asc, desc). Then invoke function that sorts data
    updateColumnSorting : function(component, event, helper){
        let fieldName = event.getParam('fieldName');
        let sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    }

})