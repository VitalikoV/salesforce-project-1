public with sharing class SaveAccountPDF {

    String recordId;
    //String userId;
    public SaveAccountPDF(ApexPages.StandardController controller){  
        // getting Contract record Id from page URL  
        // Account acc = (Account) controller.getRecord();
            //recordId = acc.Id;
           //userId = UserInfo.getUserId();
          //saveToAttachment(recordId, userId);
          //saveToFiles(recordId, userid);
    }


    // public void saveToAttachment() {
    //     Blob pdfData = getBlobOfVisualforcePage();
    //     Attachment attach = new Attachment();
    //     attach.contentType = 'application/pdf';
    //     attach.name = 'pdfFile.pdf';
    //     attach.parentId = userId;
    //     attach.body = pdfData;
    //     insert attach;
    // }

    // public void saveToFiles(){
    //     Blob pdfData = getBlobOfVisualforcePage();
    //     ContentVersion content = new ContentVersion();
    //    content.versionData = pdfData;
    //    content.title = 'generatedPdf';
    //    content.pathOnClient = 'generatedPdf.pdf';
    //    content.FirstPublishLocationId = userId;
    //    insert content;
    // }

    // public Blob getBlobOfVisualforcePage(){
    //     PageReference pdf = Page.OpportunitiesPDF;
    //     pdf.getParameters().put('id', recordId);
    //     return pdf.getContent();
    // }


    public void attachment(){
        recordId = ApexPages.currentPage().getParameters().get('id');
        PageReference attachment = Page.OpportunitiesPDF;
        attachment.getParameters().put('id',recordId);
    
        Attachment e = new Attachment();
    
        Blob body;
    
        try{
            body = attachment.getContentAsPDF();
        }catch(Exception t){
            body = Blob.valueOf('Cannot create PDF');
        }
    
        e.body = body;
        e.Name = 'Attachment - '+ system.Now();
        e.isPrivate = false;
        e.parentId = recordId;
        e.ContentType = 'application/pdf';
        insert e;
    }
    
}
