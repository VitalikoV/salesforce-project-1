({
    // columns for datatable
	setColumns : function(component) {
		    component.set('v.columns', [
                {label: 'Name', fieldName: 'linkName', type: 'url', sortable: "true",
             typeAttributes: {label: { fieldName: 'Name' },value:{fieldName: 'linkName'}, target: '_blank'}
			},
                {label: 'Email', fieldName: 'Email', type: 'email', sortable: "true"},
                {label: 'Phone', fieldName: 'Phone', type: 'phone', sortable: "true"},
        ]);
	}, 
                
    queryContacts : function(component, fieldName, sortDirection) {
        	let data = component.get("c.getRelatedContacts");
            let pageSize = component.get("v.pageSize").toString();
        	let pageNumber = component.get("v.pageNumber").toString(); 
            data.setParams({
                recordId : component.get('v.recordId'),
                'pageSize' : pageSize,
            	'pageNumber' : pageNumber,
                'sortName' : fieldName,
                'sortAction' : sortDirection
            });
                
            data.setCallback(this, function(response){
                let contacts = response.getReturnValue();
                let state = response.getState();
                if(state == "SUCCESS"){
                contacts.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                if(contacts.length < component.get("v.pageSize")){
                    component.set("v.isLastPage", true);
                } else{
                    component.set("v.isLastPage", false);
                }
				component.set("v.dataSize", contacts.length); 
                component.set("v.contacts", contacts);
                }
            });
            $A.enqueueAction(data);
    },
})