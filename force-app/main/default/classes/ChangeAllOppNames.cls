public class ChangeAllOppNames {

    @AuraEnabled(cacheable = true)
    public static void changeNames(id UserId){
    	OpportunityNameChange batchChange = new OpportunityNameChange(userId);
        id batchId = Database.executeBatch(batchChange);

        // AsyncApexJob job = [SELECT id, Status, NumberOfErrors,
        // JobItemsProcessed, TotalJobItems FROM AsyncApexJob WHERE id =:batchid].get(0);
        // return job;
    }

    @AuraEnabled
    public static id changeNamesByOne(){
            OpportunityNameChange bChange = new OpportunityNameChange();
            id batchId = Database.executeBatch(bChange);
        return batchId;
    }

    @AuraEnabled
    public static AsyncApexJob getBatchJobStatus(Id jobID){
        AsyncApexJob jobInfo = [SELECT Status, NumberOfErrors,JobItemsProcessed,TotalJobItems FROM AsyncApexJob WHERE Id = :jobID];
        return jobInfo;
    }
}