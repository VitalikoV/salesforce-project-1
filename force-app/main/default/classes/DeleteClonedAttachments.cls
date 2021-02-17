global class DeleteClonedAttachments implements Schedulable{
    global void execute(SchedulableContext ctx){

        Set<id> cdMap = new Map<id, ContentDocument>([SELECT id, Title FROM ContentDocument]).keySet();
        List<ContentDocumentLink> cdl = [SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink WHERE ContentDocumentId IN :cdMap];

        Set<id> recordsId = new Set<id>();

        for(ContentDocumentLink link : cdl){
            recordsId.add(link.LinkedEntityId);
        }

        List<ContentDocument> filesToDelete = new List<ContentDocument>();
        List<id> idsToDeletePerRecord = new List<id>();
        List<ContentDocument> filesToDeletePerRecord = new List<ContentDocument>();

        Map<id, ContentDocument> tryMap = new Map<id, ContentDocument>([SELECT id FROM ContentDocument]);
        tryMap = new Map<id, ContentDocument>([SELECT id, Title, CreatedDate FROM ContentDocument WHERE id IN :tryMap.keySet() ORDER BY CreatedDate DESC]);
        String name;

        Set<String> set1 = new Set<String>();

        for(id recordId : recordsId){
            
            idsToDeletePerRecord = new List<id>();
            filesToDeletePerRecord = new List<ContentDocument>();
            set1 = new Set<String>();
            for(ContentDocumentLink cd : cdl){
                if(recordId == cd.LinkedEntityId && cd.LinkedEntityId != '00509000002baUaAAI'){
                    idsToDeletePerRecord.add(cd.ContentDocumentId);
                }
            }

            for(id cont : idsToDeletePerRecord){
                name = tryMap.get(cont).title;
                if(!set1.add(name)){
                    filesToDeletePerRecord.add(trymap.get(cont));
                }
            }

            filesToDelete.addAll(filesToDeletePerRecord);
        }
    delete filesToDelete;
    }

    public void deletionOfAttachments(){
        //Set<id> recordsId = (new Map<Id, Attachment>([SELECT parentId FROM Attachment])).keySet();

        String attName = 'PDF Opps Attachment';
        Set<Id> recordsId = new Set<id>();
        List<Attachment> attachments = [SELECT id, Name, CreatedDate, parentId FROM Attachment WHERE name =:attName ORDER BY CreatedDate DESC];
        
        for(Attachment att : attachments){
            recordsId.add(att.parentId);
        }
        
        List<Attachment> attachmentsToDelete = new List<Attachment>();
        
        for(id recordId : recordsId){
            List<Attachment> attsFromRecord = new List<Attachment>();
            for(Attachment att : attachments){
                if(att.parentId == recordId){
                    attsFromRecord.add(att);
                }
            }
            if(attsFromRecord.size() > 0){
                attsFromRecord.remove(0);
            }
            attachmentsToDelete.addAll(attsFromRecord);
        }
        delete attachmentsToDelete;
    }
}