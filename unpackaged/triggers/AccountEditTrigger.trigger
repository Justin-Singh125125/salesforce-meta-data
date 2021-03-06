trigger AccountEditTrigger on AccountEdit__c (after insert) 
{
    Id userId = UserInfo.GetUserId();
    boolean isDisabled = Disable_All_Triggers__c.getInstance(userId).Value__c;
    if(!isDisabled)
    {
        new AccountEditTriggerHandler().execute();           
    }
}