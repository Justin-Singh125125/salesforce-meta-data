public class ContactEditTriggerHandler extends TriggerHandler 
{
	public ContactEditTriggerHandler() 
	{
	} 

	protected override void afterInsert()
    {
		Set<Id> newIds = new Set<Id>();
		for(ContactEdit__c contactEdit : (List<ContactEdit__c>)trigger.new)
		{
			newIds.Add(contactEdit.Contact__c);
		}
		Map<ID, Contact> contactMap = new Map<ID, Contact>([SELECT FirstName, LastName, Email, Phone, Title, IsRegistered__c FROM Contact Where Id in: newIds]);
		List<Contact> contactsToUpdate = new List<Contact>();
		List<Contact> contactsToInsert = new List<Contact>();
		for(ContactEdit__c contactEdit : (List<ContactEdit__c>)trigger.new)
		{
			if(contactEdit.Contact__c == null)
			{
				Contact contact = new Contact();
				//contact.Id = contactEdit.Contact__c;	
				if(contactEdit.First_Name_Updated__c == true)			
				{
					contact.FirstName = contactEdit.First_Name__c;
				}
				if(contactEdit.Last_Name_Updated__c == true)			
				{
					contact.LastName = contactEdit.Last_Name__c;
				}
				if(contactEdit.Email_Updated__c == true)			
				{					
					contact.Email = contactEdit.Email__c;
				}
				if(contactEdit.Phone_Updated__c == true)			
				{					
					contact.Phone = contactEdit.Phone__c;
				}
				if(contactEdit.Title_Updated__c == true)			
				{					
					contact.Title = contactEdit.Title__c;
				}
				if(contactEdit.Account_Updated__c == true)			
				{	
					Account account = [SELECT Id from Account Where Id=:contactEdit.Account__c];
					contact.AccountId = account.Id;
				}				
							
				if(contactEdit.Password_Hash_Updated__c == true)
				{
					contact.PasswordHash__c = contactEdit.PasswordHash__c;				
				}
				if(contactEdit.Is_Registered_Updated__c == true)
				{
					contact.IsRegistered__c = contactEdit.IsRegistered__c;				
				}
				if(contactEdit.Record_Type_Id_Updated__c == true)
				{
					contact.RecordTypeId = contactEdit.Record_Type_Id__c;
				}
				if(contactEdit.Inactive_Updated__c == true)
				{
					contact.Inactive__c = contactEdit.Inactive__c;
				}
				contactsToInsert.Add(contact);
			}
			else
			{
				Contact contact = contactMap.get(contactEdit.Contact__c);			
				contact.Id = contactEdit.Contact__c;
				if(contactEdit.First_Name_Updated__c == true)			
				{
					contact.FirstName = contactEdit.First_Name__c;
				}
				if(contactEdit.Last_Name_Updated__c == true)			
				{
					contact.LastName = contactEdit.Last_Name__c;
				}
				if(contactEdit.Email_Updated__c == true)			
				{					
					contact.Email = contactEdit.Email__c;
				}
				if(contactEdit.Phone_Updated__c == true)			
				{					
					contact.Phone = contactEdit.Phone__c;
				}
				if(contactEdit.Title_Updated__c == true)			
				{					
					contact.Title = contactEdit.Title__c;
				}
				if(contactEdit.Password_Hash_Updated__c == true)
				{
					contact.PasswordHash__c = contactEdit.PasswordHash__c;				
				}
				if(contactEdit.Is_Registered_Updated__c == true)
				{
					contact.IsRegistered__c = contactEdit.IsRegistered__c;				
				}
     			
				if(contactEdit.Reset_Code_Updated__c == true)
				{
					contact.Reset_Code__c = contactEdit.Reset_Code__c;		
				}
				if(contactEdit.Incorrect_Attempt_Count_Updated__c == true)
				{
					contact.Incorrect_Attempt_Count__c = contactEdit.Incorrect_Attempt_Count__c;				
				}
				if(contactEdit.Is_Locked_Out_Updated__c == true)
				{
					contact.Is_Locked_Out__c = contactEdit.Is_Locked_Out__c;				
				}
				if(contactEdit.Time_of_First_Failed_Attempt_Updated__c == true)
				{
					contact.Time_of_First_Failed_Attempt__c = contactEdit.Time_of_First_Failed_Attempt__c;				
				}
				if(contactEdit.Inactive_Updated__c == true)
				{
					contact.Inactive__c = contactEdit.Inactive__c;
				}
				contactsToUpdate.Add(contact);
			}
		}
		insert contactsToInsert;
		update contactsToUpdate;
	}
}