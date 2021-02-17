@isTest
public class DeleteClonedAttachmentsTest {

    public static String CRON_EXP = '0 0 0 15 3 ? 2022'; 
    //Account acc = new Account(Name = 'Test');
    // static testmethod void testScheduledJob(){
    //     List<Attachment> atts = new List<Attachment>();
    //     for(Integer i = 0; i <10; i++){
    //         Attachment att = new Attachment(Name = 'PDF Opps Attachment',  parentId = '00109000005uV2MAAU', body = Blob.valueOf('Unit Test Attachment Body'));
    //         atts.add(att);
    //     }
        
    //     insert atts;
        
    //     Map<id, Attachment> attMap = new Map<id, Attachment>(atts);
    //     List<id> attId = new List<Id>(attMap.keySet());
        
    //     Test.startTest();
    //     String jobId = System.schedule('Test schedule deleting', CRON_EXP, new DeleteClonedAttachments());
    //     Test.stopTest();
        
    //     List<Attachment> attsAfterSchedule = [SELECT id FROM Attachment WHERE id IN :attId];
    //     System.assertEquals(1, attsAfterSchedule.size());
        
    // }

    // static testmethod void testScheduledJob2(){
    //     Account acc1 = new Account(Name = 'Test1');
    //     Account acc2 = new Account(Name = 'Test2');
    //     Account acc3 = new Account(Name = 'Test3');

    //     List<Attachment> atts = new List<Attachment>();
    //     for(Integer i = 0; i <10; i++){
    //         Attachment att1 = new Attachment(Name = 'PDF Opps Attachment',  parentId = acc1.id, body = Blob.valueOf('Unit Test Attachment Body'));
    //         Attachment att2 = new Attachment(Name = 'PDF Opps Attachment',  parentId = acc2.id, body = Blob.valueOf('Unit Test Attachment Body'));
    //         Attachment att3 = new Attachment(Name = 'PDF Opps Attachment',  parentId = acc3.id, body = Blob.valueOf('Unit Test Attachment Body'));

    //         atts.add(att1);       
    //         atts.add(att2);
    //         atts.add(att3);

    //     }
        
    //     insert atts;
        
    //     Map<id, Attachment> attMap = new Map<id, Attachment>(atts);
    //     List<id> attId = new List<Id>(attMap.keySet());
        
    //     Test.startTest();
    //     String jobId = System.schedule('Test schedule deleting', CRON_EXP, new DeleteClonedAttachments());
    //     Test.stopTest();
        
    //     List<Attachment> attsAfterSchedule = [SELECT id FROM Attachment WHERE id IN :attId];
    //     System.assertEquals(3, attsAfterSchedule.size());
        
    // }

    static testmethod void testScheduledJob3(){
        Account acc = new Account(Name = 'Test');
        insert acc;
        Account acc1 = [SELECT id, name FROM Account WHERE Name = 'Test'].get(0);

        List<ContentVersion> conts = new List<ContentVersion>();
        List<ContentDocumentLink> cdls = new List<ContentDocumentLink>();

        for(integer i = 0; i<10; i++){
        ContentVersion cont = new ContentVersion();
        cont.Title = 'PDF Opps Table';
        cont.PathOnClient = 'file.pdf';
        cont.versionData = Blob.valueOf('Created PDF');
        conts.add(cont);


        }

        insert conts;
        


        Map<id, ContentVersion> contVerMap = new Map<id, ContentVersion>([SELECT id FROM ContentVersion]);
        List<id> contVersId = new List<Id>(contVerMap.keySet());

        for(integer i = 0; i<10; i++){
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId =  [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =:contVersId[i]].ContentDocumentId;
            cdl.LinkedEntityId = acc1.id;
            cdl.ShareType = 'V';
            cdls.add(cdl);
            }
        insert cdls;

        Map<id, ContentDocument> contMap = new Map<id, ContentDocument>([SELECT id FROM ContentDocument]);
        List<id> contsId = new List<Id>(contMap.keySet());


        Test.startTest();
        String jobId = System.schedule('Test schedule deleting', CRON_EXP, new DeleteClonedAttachments());
        Test.stopTest();
        
        List<ContentDocument> attsAfterSchedule = [SELECT id FROM ContentDocument WHERE id IN :contsId];
        System.assertEquals(1, attsAfterSchedule.size());
    }
}