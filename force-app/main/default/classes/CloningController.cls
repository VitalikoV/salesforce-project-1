public with sharing class CloningController {
    
    @AuraEnabled
    public static Integer cloneObjectsWithDateOfEvent(id recordId, List<String> dates){


        // Sobject so = Schema.getGlobalDescribe().get('Opportunity').newSObject();

        // if(!so.getSObjectType().getDescribe().fields.getMap().containsKey('Date_Of_Event2__c')){
        // MetadataService.CustomField customDate = new MetadataService.CustomField();
        // customDate.fullName = 'Opportunity.Date_Of_Event2__c';
        // customDate.label = 'Date Of Event2';
        // customDate.type_x = 'Date';
        // MetadataService.AsyncResult[] results = service.create(new List<MetadataService.Metadata>{customDate});
        // }

        Opportunity oppToClone = [SELECT id, name, closedate FROM Opportunity WHERE id=:recordId].get(0);
        List<Opportunity> clonedOpps = new List<Opportunity>();
        for(String d : dates){
            Opportunity clonedOpp = oppToClone.clone(false, true, true, false);
            clonedOpp.StageName = 'Prospecting';
            clonedOpp.Date_Of_Event__c = Date.valueOf(d);
            clonedOpps.add(clonedOpp);
        }

        insert clonedOpps; 
        return clonedOpps.size();
    }
}