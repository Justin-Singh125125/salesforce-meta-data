trigger FindingTrigger on Finding__c (before insert, after insert, before update, after update) 
{
    Id userId = UserInfo.GetUserId();
    boolean isDisabled = Disable_All_Triggers__c.getInstance(userId).Value__c;
    if(!isDisabled)
    {
        new FindingTriggerHandler().execute();  
    }
}