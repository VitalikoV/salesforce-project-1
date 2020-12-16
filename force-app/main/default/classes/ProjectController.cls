public class ProjectController {
    @AuraEnabled
    public static List<Contact> getRelatedContacts(id recordId, String pageSize, String pageNumber ){
        // Defining parameters, that helps to retreive correct number of records
        Integer size = Integer.valueOf(pageSize);
        Integer numberOfPage = Integer.valueOf(pageNumber)-1;
		Integer offsetRecord = (size*numberOfPage);
        
        List<Project__c> projs = [SELECT id, Account__c FROM Project__c WHERE id = :recordId];
        ID accId = projs.get(0).Account__c; 
        return [SELECT Name, Email, Phone FROM Contact WHERE accountId = :accId LIMIT :Integer.valueOf(size) OFFSET :offsetRecord];
    }
}