public class ProjectController {
    @AuraEnabled
    public static List<Contact> getRelatedContacts(id recordId, String pageSize, String pageNumber, String sortName, String sortAction){
        // Defining parameters, that helps to retreive correct number of records
        Integer size = Integer.valueOf(pageSize);
        Integer numberOfPage = Integer.valueOf(pageNumber)-1;
		Integer offsetRecord = (size*numberOfPage);
        
        //Gain account id in order to get related contacts 
        ID accId = getRelatedId(recordId);

        //if you press name on the column, instead of 'Name' you receive 'linkName' because it's a href
        //Consequently, this method change linkName to Name
        if(sortName == 'linkName'){
            sortname = 'Name';
        }
        
        String querystr = 'SELECT Name, Email, Phone FROM Contact WHERE accountId =' + '\''+ accId + '\'' 
            + ' ORDER BY ' + sortName + ' ' + sortAction + ' LIMIT ' + Integer.valueOf(size) + ' OFFSET ' + offsetRecord; 
        List<Contact>contacts =(List<Contact>) database.query(querystr);
        return contacts;        
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getAllRelatedContacts(id recordId){
        ID accId = getRelatedId(recordId);
        return [SELECT  Name, Email, Phone
                FROM Contact WHERE accountId= :accId];
    }

    public static ID getRelatedId(id recordId){
        List<Project__c> projs = [SELECT id, Account__c FROM Project__c WHERE id = :recordId];
        return projs.get(0).Account__c; 
    }
}