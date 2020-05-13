trigger CAMSNoteTrigger on CAMS_Note__c (after delete)
{
    new CAMSNoteTriggerHandler().execute(); 
}