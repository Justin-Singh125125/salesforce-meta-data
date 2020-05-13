trigger CAMSAssignmentTrigger on CAMS_Assignment__c (before insert, after insert, before update,after update,before delete,after delete) 
{
    new CAMSAssignmentTriggerHandler().execute(); 
}