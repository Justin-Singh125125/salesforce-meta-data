public with sharing class CAMSFileTriggerHandler extends TriggerHandler  
{
    protected override void afterDelete()
    {
        List<Id> assignmentIds = new List<Id>();
        List<CAMS_History__c> histories = new List<CAMS_History__c>();
        for(File__c file: (List<File__c>)Trigger.Old) 
        {
            CAMS_History__c history = new CAMS_History__c();
            history.Action__c = 'Delete';
            history.Description__c = 'Deleted';
            history.Name_Id__c = file.Name;
            history.User__c = UserInfo.GetUserId();
            history.Type__c = 'File';
            history.Assignment__c = file.Assignment__c;
            histories.Add(history);            
        }
        insert histories;
    }
}