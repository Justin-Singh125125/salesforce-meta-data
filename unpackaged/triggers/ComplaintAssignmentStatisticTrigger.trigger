trigger ComplaintAssignmentStatisticTrigger on Complaint_Assignment__c (Before Update)
{
    Id userId = UserInfo.GetUserId();
    boolean isDisabled = Disable_All_Triggers__c.getInstance(userId).Value__c;
    if(!isDisabled)
    {
        new CompAssignmentStatsTriggerHandler().execute();          
    }
}