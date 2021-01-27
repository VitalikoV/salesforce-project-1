public class OpportunitiesPDFController { 


    public List<Opportunity> relatedOpps{get; set;}
    public Double calculatedAmount{get;set;}
    

   public OpportunitiesPDFController(ApexPages.StandardController controller){  
     // getting Contract record Id from page URL  
     Account acc = (Account) controller.getRecord();
       String recordId = acc.Id;
       
       String usrId = UserInfo.getUserId();
     relatedOpps = [select id, Name, StageName, CloseDate, Amount from Opportunity
                    where accountId=:recordId AND ownerId = :usrId];    
		calculatedAmount = 0.00;
       for(Opportunity opp : relatedOpps){
           calculatedAmount += opp.Amount;
       }



   }
   
   

}