trigger CalEPAPartnerAgencyAccountTrigger on Account (before delete) 
{
    Id userId = UserInfo.GetUserId();
    boolean isDisabled = Disable_All_Triggers__c.getInstance(userId).Value__c;
    if(!isDisabled)
    { 
        new CalEPAPartnerAgencyAccountTriggerHandler().execute();           
    }   
}