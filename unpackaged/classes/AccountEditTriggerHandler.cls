public with sharing class AccountEditTriggerHandler extends TriggerHandler 
{
	public AccountEditTriggerHandler() 
	{
		
	}
	protected override void afterInsert()
    {

		Set<Id> newIds = new Set<Id>();
		
		for(AccountEdit__c AccountEdit : (List<AccountEdit__c>)trigger.new)
		{
			newIds.Add(AccountEdit.Account__c);
		}
		Map<ID, Account> accountMap = new Map<ID, Account>([SELECT Name FROM Account Where Id in: newIds]);
		List<Account> accountsToUpdate = new List<Account>();
		List<Account> accountsToInsert = new List<Account>();
		
		for(AccountEdit__c accountEdit : (List<AccountEdit__c>)trigger.new)
		{
			if(accountEdit.Account__c == null)
			{
				Account account = new Account();
				if(AccountEdit.Record_Type_Id_Updated__c == true)
				{
					account.RecordTypeId = accountEdit.Record_Type_Id__c;
				}
				if(accountEdit.Account_Name_Updated__c == true)
				{
					account.Name = accountEdit.AccountName__c;
				}
				accountsToInsert.Add(account);
			}
			else
			{
				Account account = accountMap.get(accountEdit.Account__c);			
				account.Id = accountEdit.Account__c;
				if(accountEdit.Account_Name_Updated__c == true)
				{
					account.Name = accountEdit.AccountName__c;
				}
				if(accountEdit.Phone_Updated__c == true)
				{
					account.Phone = accountEdit.Phone__c;
				}
				if(accountEdit.Fax_Updated__c == true)
				{
					account.Fax = accountEdit.Fax__c;
				}
				if(accountEdit.Street_Address_Updated__c == true)
				{
					account.ShippingStreet = accountEdit.Street_Address__c;
				}
				if(accountEdit.City_Updated__c == true)
				{
					account.ShippingCity = accountEdit.City__c;
				}
				if(accountEdit.Zip_Updated__c == true)
				{
					account.ShippingPostalCode = accountEdit.Zip__c;
				}
				if(accountEdit.Website_Updated__c == true)
				{
					account.Website = accountEdit.Website__c;
				}
				accountsToUpdate.Add(account);
			}
		}
		insert accountsToInsert;
		update accountsToUpdate;
	}
}