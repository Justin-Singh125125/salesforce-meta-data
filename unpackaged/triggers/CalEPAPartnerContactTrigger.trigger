trigger CalEPAPartnerContactTrigger on Contact  (before insert, after insert, before update, after update, before delete) 
{
    Id userId = UserInfo.GetUserId();
    boolean isDisabled = Disable_All_Triggers__c.getInstance(userId).Value__c;
    if(!isDisabled)
    { 
        new CalEPAPartnerContactTriggerHandler().execute();           
    }   
}