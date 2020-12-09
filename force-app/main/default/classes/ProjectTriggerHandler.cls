public with sharing class ProjectTriggerHandler extends TriggerHandler{

    public override void afterInsert(){
        List<Project__c> changedProjects = new List<Project__c>();

        for(Project__c project : [SELECT User__r.Name, Account__r.Name From Project__c WHERE Id IN :Trigger.New]){
            String name = project.User__r.Name + ' - ' + project.Account__r.Name;
            if(name.length() < 80){
            project.Name = name;
            }else{
            project.Name = 'length is higher than 80 letters';
            }
            changedProjects.add(project);
        }
        update changedProjects;
    }
    
}
