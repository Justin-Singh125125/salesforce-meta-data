public with sharing class FindingTriggerHandler  extends TriggerHandler 
{
	public FindingTriggerHandler() 
	{
		
	}

	protected override void beforeInsert()
    {

	}

	protected override void afterInsert()
    {
		Set<Id> newIds = new Set<Id>();
		Set<Id> referralIdsToUpdate = new Set<Id>();
		for(Finding__c finding : (List<Finding__c>)trigger.new)
		{
			newIds.Add(finding.Id);
			if(finding.Referral__c != null)
			{
				referralIdsToUpdate.Add(finding.Referral__c);
			}
		}
		List<Referral__c> referralsToUpdate = [SELECT Id, Status__c FROM Referral__c WHERE Id in: referralIdsToUpdate];
		for(Referral__c referral : referralsToUpdate)
		{
			referral.Status__c = 'Findings Received';
		}
		update referralsToUpdate;
		if(!Test.isRunningTest())
        {
			FindingManager.SendConfirmationEmail(newIds);
			FindingManager.SendNotificationEmail(newIds);
		}
		
	}

	protected override void beforeUpdate()
    {

	}

	protected override void afterUpdate()
    {
		Set<Id> referralIdsToUpdate = new Set<Id>();
		for(Finding__c finding : (List<Finding__c>)trigger.new)
		{
			if(finding.Referral__c != null)
			{
				referralIdsToUpdate.Add(finding.Referral__c);
			}
		}
		List<Referral__c> referralsToUpdate = [SELECT Id, Status__c FROM Referral__c WHERE Id in: referralIdsToUpdate];
		for(Referral__c referral : referralsToUpdate)
		{
			referral.Status__c = 'Findings Received';
		}
		update referralsToUpdate;
	}
}