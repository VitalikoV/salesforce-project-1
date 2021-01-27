public with sharing class OpportunitySharing {

    @AuraEnabled
    public static List<User> getUsers(){
        return [SELECT id, Name, Email, Department, Team__c from User];
    }


    @AuraEnabled
    public static void shareRecordWithUser(List<User> users, id recordId){

        List<OpportunityShare> oppsShare = new List<OpportunityShare>();

        for(User user : users){
            OpportunityShare oppShare = new OpportunityShare();
            oppShare.OpportunityId = recordId;
            oppShare.UserOrGroupId = user.Id;
            oppShare.OpportunityAccessLevel = 'Read';
            oppsShare.add(oppShare);
        }

         insert oppsShare;
        //Database.SaveResult sr = Database.insert(oppsShare,false);
    }

    @AuraEnabled
    public static void deleteSharingRecordWithUser(List<User> users, id recordId){
        List<OpportunityShare> oppsShare = [SELECT id FROM OpportunityShare WHERE userOrGroupId IN :users AND opportunityId = :recordId];
         delete oppsShare;
    }

    @AuraEnabled
    public static List<User> getUsersWithSharedRecords(id recordId){
        List<OpportunityShare> sharedOpps = [SELECT id, UserOrGroupId FROM OpportunityShare WHERE OpportunityId = :recordId];
        List<User> users = new List<User>();

        for(User user : [SELECT id, Name, Email, Department, Team__c FROM User]){
            for(OpportunityShare opp : sharedOpps){
            if(user.Id == opp.userOrGroupId){
                users.add(user);
            }
            }
        }

        return users;

    }

}