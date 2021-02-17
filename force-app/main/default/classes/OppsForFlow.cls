public class OppsForFlow {

    @AuraEnabled
    public static List<Opportunity> getRelatedOpps(id accountId){
        return [SELECT id, Name, StageName, Amount FROM Opportunity WHERE accountId = :accountId];
    }
    
    @AuraEnabled
    public static List<Opportunity> markCheckedOpps(String[] ids){
        List<Opportunity> opps = [SELECT id, Name, Marked__c FROM Opportunity WHERE id IN :ids];
        for(Opportunity opp : opps){
            opp.Marked__c = true;
        }
        
        return opps;
    }
    
    @AuraEnabled
    public static List<Opportunity> unmarkCheckedOpps(String[] ids){
        List<Opportunity> opps = [SELECT id, Name, Marked__c FROM Opportunity WHERE id IN :ids];
        for(Opportunity opp : opps){
            opp.Marked__c = false;
        }
        
        return opps;
    }
}