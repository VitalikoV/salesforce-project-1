@isTest
public with sharing class ProjectTriggerHandlerTest {
    @isTest static void testProjectNameWithLimit(){

        Profile profileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];

        User usr = new User(LastName = 'Testingashdvdfjkbnvdfkjvifvdljvndkjfbv',
                            FirstName='Userdfjnvklfnvieurnvfvjnsalijnvgiubisa',
                            Alias = 'tester',
                            Email = 'test.training@gmail.com',
                            Username = 'test.training@gmail.test',
                            ProfileId = profileId.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                            );
        insert usr;

        Account acc = new Account(Name = 'Buildings companyasfdgdffv');
        insert acc;

        Project__c project = new Project__c(Name = 't', User__c = usr.id, Account__c = acc.id);
        insert project;

        Project__c testProject = [SELECT Name From Project__c].get(0);
        String testProjectName = testProject.Name;

        System.assertEquals('Userdfjn. Testinga.  Building. companya.', testProjectName);

    }
}