trigger ReferralTrigger on Referral__c (after insert, after update) 
{
    Id userId = UserInfo.GetUserId();
    boolean isDisabled = Disable_All_Triggers__c.getInstance(userId).Value__c;
    if(!isDisabled)
    {
        new ReferralTriggerHandler().execute();  
    }   
}