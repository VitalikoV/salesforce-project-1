({
    doInit : function(component, event, helper) {
        helper.setColumns(component);
        helper.getAllUsers(component);
        helper.getSharedUsers(component);
    },

    handleRemovingUsers : function(component, event, helper){
        helper.deleteSharing(component);
        helper.getSharedUsers(component);
    },

    handleSelectedRows: function(component, event, helper){
        helper.shareRecord(component);
        helper.getSharedUsers(component);
    },
})
