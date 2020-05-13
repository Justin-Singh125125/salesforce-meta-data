trigger ComplaintTrigger on Complaints__c (before insert, after insert, before update, after update,before delete) 
{
    Id userId = UserInfo.GetUserId();
    boolean isDisabled = Disable_All_Triggers__c.getInstance(userId).Value__c;
    if(!isDisabled)
    {
        if(Test.isRunningTest())
        {
            ICallout2 mockCallout = new MockCallout2();
            new ComplaintTriggerHandler(mockCallout).execute();  
        }
        else
        {
            ICallout2 callout = new Callout2();
            new ComplaintTriggerHandler(callout).execute();          
        }
    }
}