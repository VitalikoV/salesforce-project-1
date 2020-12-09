trigger ProjectTrigger on Project__c (after insert) {

    new ProjectTriggerHandler().run();
}