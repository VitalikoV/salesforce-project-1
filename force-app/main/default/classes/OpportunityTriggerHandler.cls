public with sharing class OpportunityTriggerHandler extends TriggerHandler{

    public override void beforeInsert(){
        setDefaultFields();
    }

        
    public override void beforeUpdate(){
        setDefaultFields();
    }


    public void setDefaultFields(){
        List<Opportunity> opps = (List<Opportunity>) Trigger.new;
        List<User> users = [SELECT id, Name, Department, Team__c, UserRoleId FROM User];

        User crUser = null;
        List<UserRole> roles = [SELECT id, Name, ParentRoleId FROM UserRole];
        id parentRole = null;
        User parentUser = null;
        id departmentRole = null;
        User departmentUser = null;

        for(Opportunity opp : opps){

            for(User us : users){
                if(opp.ownerId == us.id){
                    crUser = us;
                }
            }

            for(UserRole role: roles){
                if (role.id == crUser.userRoleId) {
                    parentRole = role.ParentRoleId;
                }
            }

            for(User us : users){
                if(parentRole == us.userRoleId){
                    parentUser = us;
                }
            }

            for(UserRole role: roles){
                if (role.id == parentUser.userRoleId) {
                departmentRole = role.ParentRoleId;
                }
            }

            for(User us : users){
                if(departmentRole == us.userRoleId){
                    departmentUser = us;
                }
            }

            opp.Department__c = crUser.Department;
            opp.Team__c = crUser.Team__c;
            opp.Sales_Approver__c = parentUser.id;
            opp.Department_Approver__c = departmentUser.id;
        }
    }
}