public with sharing class CAMSNoteTriggerHandler extends TriggerHandler  
{
    protected override void afterDelete()
    {
        List<Id> assignmentIds = new List<Id>();
        List<CAMS_History__c> histories = new List<CAMS_History__c>();
        for(CAMS_Note__c Note: (List<CAMS_Note__c>)Trigger.Old) 
        {
            CAMS_History__c history = new CAMS_History__c();
            history.Action__c = 'Delete';
            history.Description__c = 'Deleted';
            history.Name_Id__c = Note.Name;
            history.User__c = UserInfo.GetUserId();
            history.Type__c = 'Note';
            history.Assignment__c = Note.CAMS_Assignment__c;
            histories.Add(history);            
        }
        insert histories;
    }
}