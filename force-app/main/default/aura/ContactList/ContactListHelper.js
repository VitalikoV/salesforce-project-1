({
	setColumns : function(component) {
		    component.set('v.columns', [
            {label: 'Name', fieldName: 'linkName', type: 'url',
             typeAttributes: {label: { fieldName: 'Name' },value:{fieldName: 'linkName'}, target: '_blank'}
			},
            {label: 'Email', fieldName: 'Email', type: 'email'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'},
        ]);
	}, 
                
    queryContacts : function(component) {
        	var data = component.get("c.getRelatedContacts");
            data.setParams({
                recordId : component.get('v.recordId')
            });
            
            data.setCallback(this, function(response){
                let contacts = response.getReturnValue();
                let state = response.getState();
                if(state == "SUCCESS"){
                contacts.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                component.set("v.contacts", contacts);
                }
            });
            
            $A.enqueueAction(data);
    }
})