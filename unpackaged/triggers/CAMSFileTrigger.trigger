trigger CAMSFileTrigger on File__c (after delete) 
{
    new CAMSFileTriggerHandler().execute(); 
}