trigger CAMSTaskTrigger on CAMS_Task__c (before insert, after insert, before update, after update, before delete, after delete) 
{
    new CAMSTaskTriggerHandler().execute();   
}