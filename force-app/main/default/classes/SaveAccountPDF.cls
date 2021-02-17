public with sharing class SaveAccountPDF {

    String recordId;
    //String userId;
    public SaveAccountPDF(ApexPages.StandardController controller){  
    }

    public void attachment(){
        recordId = ApexPages.currentPage().getParameters().get('id');
        PageReference attachment = Page.OpportunitiesPDF;
        attachment.getParameters().put('id',recordId);
    
        // Attachment e = new Attachment();
    
        Blob body;
    
        try{
            body = attachment.getContentAsPDF();
        }catch(Exception t){
            body = Blob.valueOf('Cannot create PDF');
        }

        ContentVersion cont = new ContentVersion();
        cont.Title = 'PDF Opps Table';
        cont.PathOnClient = 'file.pdf';
        cont.versionData = body;
        insert cont;



        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId =  [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cont.Id].ContentDocumentId;
        cdl.LinkedEntityId = recordId;
        cdl.ShareType = 'V';
        insert cdl;


        // e.body = body;
        // e.Name = 'PDF Opps Attachment';
        // e.isPrivate = false;
        // e.parentId = recordId;
        // e.ContentType = 'application/pdf';
        // insert e;



    }
    
}