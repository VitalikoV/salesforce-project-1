({
    setColumns : function(component){
        component.set('v.columns',[
            {label:'Name', fieldName:'Name', type:'text'},
            {label:'Email', fieldName:'Email', type:'email'},
            {label:'Department', fieldName:'Department', type:'text'},
            {label:'Team', fieldName:'Team__c', type:'text'}
            ]);
    },

    getAllUsers : function(component){
        let data = component.get('c.getUsers');
        data.setCallback(this, function(response){
            let users = response.getReturnValue();
            let state = response.getState();
            if(state == "SUCCESS"){
                component.set("v.users", users);
            }
        });
        $A.enqueueAction(data);
    },

    getSharedUsers : function(component){
        let data = component.get('c.getUsersWithSharedRecords');
        data.setParams({
            recordId : component.get('v.recordId')
        });
        data.setCallback(this, function(response){
            let usersWithSharing = response.getReturnValue();
            let state = response.getState();
            console.log("users With sharing: " + JSON.stringify(usersWithSharing));
            if(state == 'SUCCESS'){
                component.set("v.usersWithSharing", usersWithSharing);
            }
        });
        $A.enqueueAction(data);
   },

   deleteSharing : function(component){
        let users = component.find('sharedUsersTable').getSelectedRows();
        console.log(JSON.stringify(users));
        let share = component.get('c.deleteSharingRecordWithUser');
        share.setParams({
            users: users,
            recordId : component.get('v.recordId') 
        });
        $A.enqueueAction(share);
   },

   shareRecord : function(component){
        let users = component.find('usersTable').getSelectedRows();
        console.log(JSON.stringify(users));
        let share = component.get('c.shareRecordWithUser');
        share.setParams({
            users: users,
            recordId : component.get('v.recordId') 
        });
        $A.enqueueAction(share);
   }
})
