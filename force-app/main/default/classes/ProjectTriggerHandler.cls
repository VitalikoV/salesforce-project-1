public with sharing class ProjectTriggerHandler extends TriggerHandler{

    public override void beforeInsert(){
        changeName();
    }

    public override void beforeUpdate(){
        changeName();
    }
    
    
    public void changeName(){
        Map<ID, Account> accMap = new Map<ID, Account>();
        Map<ID, User> usrMap = new Map<ID, User>();

        
        for(Project__c pr : (List<Project__c>) Trigger.New){
            accMap.put(pr.Account__c, null);
            usrMap.put(pr.User__c, null);
        }

        accMap = New Map<ID, Account>([SELECT Name FROM Account WHERE ID IN :accMap.keySet()]);
        usrMap = New Map<ID, User>([SELECT Name FROM User WHERE ID IN :usrMap.keySet()]);

        for(Project__c project : (List<Project__c>) Trigger.New){
            String userName = usrMap.get(project.User__c).Name;
            String accName = accMap.get(project.Account__c).Name;
            String name = userName + ' - ' + accName;
            if(name.length() < 80){
            project.Name = name;
            }else{
            project.Name = decreaseName(userName, accName);
            }
        }
    }
    
    public String decreaseName(String userName, String accName){
        String[] dividedUserName = userName.split(' ');
        String[] dividedAccName = accName.split(' ');
        String decreasedUserName = cutDividedName(dividedUserName);
        String decreasedAccName = cutDividedName(dividedAccName);
        return decreasedUserName + ' ' + decreasedAccName;
    }
    
    public String cutDividedName(String[] splittedName){
        return splittedName[0].substring(0, 8) + '. ' + splittedName[1].substring(0, 8) + '. ';
    }
}