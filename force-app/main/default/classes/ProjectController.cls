public class ProjectController {
    @AuraEnabled
    public static List<Contact> getRelatedContacts(id recordId){
        List<Project__c> projs = [SELECT id, Account__r.id FROM Project__c WHERE id = :recordId];
        ID accId = projs.get(0).Account__r.id; 
        return [SELECT Name, Email, Phone FROM Contact WHERE accountId = :accId LIMIT 5];
    }
}