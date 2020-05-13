public with sharing class CAMSButtonsController
{ 
    @AuraEnabled
    public static void AssignTasks2(string aatParam ) 
    {
        //Retrieve Initial Tasks
        CAMS_Assignment__c assgnmnt = [select id, BDO__c, BDO_Suborganization__c, status__c from CAMS_Assignment__C where id = :aatParam];
        List<CAMS_Task__c> initialTasks = [SELECT Id, Status__c, BDO_Suborganization__c, BDO__c FROM CAMS_Task__c WHERE CAMS_Assignment__c =: aatParam AND Predecessor__c = NULL and related_to__r.Predecessor__c = Null and status__c = 'Pending'];
        for(CAMS_Task__c initialTask : initialTasks)
        {
            initialTask.Status__c = 'Delegated';
        }
        update initialTasks;
        string bdoPlusSuborganization = assgnmnt.BDO__c + '_' + assgnmnt.BDO_Suborganization__c.Replace(' ','_');
        assgnmnt.status__c = 'In Progress';
        update assgnmnt;
    }
}