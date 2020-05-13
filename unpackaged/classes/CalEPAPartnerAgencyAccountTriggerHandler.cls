public with sharing class CalEPAPartnerAgencyAccountTriggerHandler extends TriggerHandler 
{
    public CalEPAPartnerAgencyAccountTriggerHandler() 
    {
        
    }
    protected override void beforeDelete()
    {
        List<Id> accountIds = new List<Id>();
        for(Account account: (List<Account>)Trigger.Old) 
        {
            accountIds.Add(account.Id);
        }
        
        List<AccountEdit__c> accountEditsToDelete = [SELECT Id FROM AccountEdit__c WHERE Account__c in: accountIds];
        delete accountEditsToDelete;
    }
}