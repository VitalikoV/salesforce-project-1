@isTest
public with sharing class CloningControllerTest {
    
    @IsTest
    static void testMeth1(){
        Opportunity opp = new Opportunity(Name = 'Test Opp', stageName = 'Prospecting', CloseDate = Date.today()+10);

        insert opp;
        List<String> dates = new List<String>{'2021-01-16', '2021-01-23'};
        
        Test.startTest();
        Integer quantity = CloningController.cloneObjectsWithDateOfEvent(opp.id, dates);
        Test.stopTest();

        System.assertEquals(2, quantity);
        
    }
}