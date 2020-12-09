trigger ProjectTrigger on Project__c (after insert) {

    List<Project__c> projects = [SELECT User__r.Name, Account__r.Name From Project__c WHERE Id IN :Trigger.New];
    List<Project__c> changedProjects = new List<Project__c>();
    
    for(Project__c project : projects){
        project.Name = project.User__r.Name + ' - ' + project.Account__r.Name;
        changedProjects.add(project);
    }
    
    upsert changedProjects;
}