public class AccountPDFController {
    @AuraEnabled
    public static String getHref(Id recordId){ 
        PageReference pdf = Page.OpportunitiesPDF;
        
        pdf.getParameters().put('id', recordId);
		Blob pdfData = pdf.getContent(); 
		//Blob pfgData = Blob.toPdf(pdf);
        return EncodingUtil.base64Encode(pdfData);
    }
}