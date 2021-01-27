public with sharing class UserTriggerHandler extends TriggerHandler{

    public override void beforeInsert(){
        List<User> users = (List<User>)Trigger.new;
        List<UserRole> roles = [SELECT id, Name, ParentRoleId FROM UserRole];
        String roleName = null;
        id salesProfileId = '00e09000000MembAAC';

        for(User user : users){
            for(UserRole role: roles){
                if (role.id == user.userRoleId && user.profileId == salesProfileId) {
                    roleName = (String) role.Name;

            if (roleName.contains('Consulting')) {
                user.Department = 'Consulting';
            }
            if (roleName.contains('Hardware')) {
                user.Department = 'Hardware';
            }

            if (roleName.contains('US')) {
                user.Team__c = 'US';
            }

            if (roleName.contains('EU')) {
                user.Team__c = 'EU';
            }

            if (roleName.contains('Asia')) {
                user.Team__c = 'Asia';
            }
                }

            }


        }
    }

    public override void beforeUpdate(){
        List<User> users = (List<User>)Trigger.new;
        List<UserRole> roles = [SELECT id, Name, ParentRoleId FROM UserRole];
        String roleName = null;


        for(User user : users){
            for(UserRole role: roles){
                if (role.id == user.userRoleId) {
                    roleName = (String) role.Name;
           

            if (roleName.contains('Consulting')) {
                user.Department = 'Consulting';
            }
            if (roleName.contains('Hardware')) {
                user.Department = 'Hardware';
            }

            if (roleName.contains('US')) {
                user.Team__c = 'US';
            }

            if (roleName.contains('EU')) {
                user.Team__c = 'EU';
            }

            if (roleName.contains('Asia')) {
                user.Team__c = 'Asia';
            }
                }
            }



        }}

}