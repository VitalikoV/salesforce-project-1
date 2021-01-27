public class OpportunityNameChange implements Database.Batchable<sObject>{
	
    private id userId;
    
    public OpportunityNameChange(){}

    public OpportunityNameChange(id userId){
        this.userId = userId;
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator(
        'SELECT id, Name FROM Opportunity');
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> opps){
        Integer len = 0;
        for(Opportunity opp : opps){
            if(!opp.Name.contains('Test')){
            	opp.Name = 'Test ' + opp.Name;
            }else{
                len = opp.Name.length();
                opp.Name = opp.Name.substring(5, len);
            }
        }
        
        update opps;
    }
    
    public void finish(Database.BatchableContext bc){
        
    }
}