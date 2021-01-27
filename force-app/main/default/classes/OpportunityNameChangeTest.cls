@isTest
public with sharing class OpportunityNameChangeTest {
    @TestSetup
    static void makeData(){
        List<Opportunity> opps = new List<Opportunity>();
        date mydate = date.parse('01/01/2011');

        for(Integer i=0; i < 10; i++){
            Opportunity opp = new Opportunity( name = 'integration '+i, stageName = 'Prospecting', closeDate = mydate);
            opps.add(opp);
        }

        upsert opps;
    }

    @isTest
    static void test(){
        
        Test.startTest();
        OpportunityNameChange oppNameChange = new OpportunityNameChange();
        Id batchId = Database.executeBatch(oppNameChange);
        Test.stopTest();

        date mydate = date.parse('01/01/2011');
        List<Opportunity> opps = [SELECT id, name, closeDate FROM Opportunity WHERE closeDate = :mydate];
        Integer quantity = 0;
        for(Opportunity opp : opps){
            if(opp.Name.contains('Test')){
                quantity++;
            }
        }

        System.assertEquals(10, quantity);

    }
}
