public with sharing class OpportunityTriggerHandler extends TriggerHandler{

    public override void beforeInsert(){
        setDefaultFields();
    }

        
    public override void beforeUpdate(){
        setDefaultFields();
    }


    public void setDefaultFields(){
        List<Opportunity> opps = (List<Opportunity>) Trigger.new;
        List<User> users = [SELECT id, Name, Department, Team__c, UserRoleId, profileId FROM User];

        User ownerOfRecord = null;
        List<UserRole> roles = [SELECT id, Name, ParentRoleId FROM UserRole];
        // id parentRole = null;
        // User parentUser = null;
        // id departmentRole = null;
        // User departmentUser = null;
        id salesProfileId = '00e09000000MembAAC';

        id salesConsEu = '00E09000000HYz6EAG';
        id salesConsUs = '00E09000000HYzGEAW';
        id salesConsAs = '00E09000000HYyXEAW';
        id salesHardEu = '00E09000000HYzkEAG';
        id salesHardUs = '00E09000000HYzVEAW';
        id salesHardAs = '00E09000000HYzpEAG';

        id managConsEu = '00509000002daDtAAI';
        id managConsUs = '005090000036IeyAAE';
        id managConsAs = '00509000002dEJ6AAM';
        id managHardEu = '005090000036IfDAAU';
        id managHardUs = '00509000002eEQoAAM';
        id managHardAs = '00509000002eER3AAM';

        id depManagCons = '00509000002dGZPAA2';
        id depManagHard = '00509000002eERDAA2';


        for(Opportunity opp : opps){

            //set user that owns this record
            for(User us : users){
                if(opp.ownerId == us.id){
                    ownerOfRecord = us;

                    if(us.userRoleId == salesConsEu){
                        opp.Sales_Approver__c = managConsEu;
                        opp.Department_Approver__c = depManagCons;
                    }

                    if(us.userRoleId == salesConsUs){
                        opp.Sales_Approver__c = managConsUs;
                        opp.Department_Approver__c = depManagCons;
                    }

                    if(us.userRoleId == salesConsAs){
                        opp.Sales_Approver__c = managConsAs;
                        opp.Department_Approver__c = depManagCons;
                    }

                    if(us.userRoleId == salesHardEu){
                        opp.Sales_Approver__c = managHardEu;
                        opp.Department_Approver__c = depManagHard;
                    }

                    if(us.userRoleId == salesHardUs){
                        opp.Sales_Approver__c = managHardUs;
                        opp.Department_Approver__c = depManagHard;
                    }

                    if(us.userRoleId == salesHardAs){
                        opp.Sales_Approver__c = managHardAs;
                        opp.Department_Approver__c = depManagHard;
                    }
                }
            }

            opp.Department__c = ownerOfRecord.Department;
            opp.Team__c = ownerOfRecord.Team__c;


        //     //sales manager role
        //     for(UserRole role: roles){
        //         if (role.id == ownerOfRecord.userRoleId && ownerOfRecord.profileId == salesProfileId) {
        //             parentRole = role.ParentRoleId;
        //         }
        //     }

        //     //sales manager user that higher in the hierarchy 
        //     for(User us : users){
        //         if(parentRole == us.userRoleId && us.profileId == salesProfileId){
        //             parentUser = us;
        //         }
        //     }

        //     // //department manager role
        //     for(UserRole role: roles){
        //         if (role.id == parentUser.userRoleId && parentUser.profileId == salesProfileId) {
        //         departmentRole = role.ParentRoleId;
        //         }
        //     }

        //     // //Department manager user, that higher in the hierarchy from current sales
        //     for(User us : users){
        //         if(departmentRole == us.userRoleId && us.profileId == salesProfileId){
        //             departmentUser = us;
        //         }
        //     }

        //     opp.Department__c = ownerOfRecord.Department;
        //     opp.Team__c = ownerOfRecord.Team__c;
        //     if(parentUser.profileId == salesProfileId && departmentUser.profileId == salesProfileId){
        //     opp.Sales_Approver__c = parentUser.id;
        //     opp.Department_Approver__c = departmentUser.id;
        // }
        }
    }
}