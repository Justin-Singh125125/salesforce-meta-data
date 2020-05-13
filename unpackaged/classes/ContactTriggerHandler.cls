public without sharing class ContactTriggerHandler extends TriggerHandler 
{
    protected override void beforeInsert()
    {
        //Prevent Community Users from Owning Contacts
        Id userId = UserInfo.getUserId();
        User user = [SELECT Id, AccountId FROM User WHERE Id=:userId];
        if(user.AccountId != null)
        {
            Account a = [SELECT Id, OwnerId FROM Account WHERE Id=:user.AccountId];
            for(Contact c : (List<Contact>)trigger.new)
            {
                c.OwnerID = a.OwnerId;
            }
        }
    }
    
    protected override void afterInsert()
    {
        //Create a Person Account that Corresponds to the Constituent Contact
        List<Account> newPersonAccounts = new List<Account>();
        RecordType contactRecordType = [SELECT Id FROM RecordType WHERE DeveloperName='Constituent' AND SObjectType='Contact'];
        RecordType personAccountRecordType = [SELECT Id FROM RecordType WHERE DeveloperName='Constituent' AND SObjectType='Account'];
        for(Contact c : (List<Contact>)trigger.new)
        {
            if(c.RecordTypeId == contactRecordType .Id)
            {
                Account newPersonAccount = new Account();
                newPersonAccount.Salutation = c.Salutation;
                newPersonAccount.FirstName = c.FirstName;
                newPersonAccount.LastName = c.LastName;
                newPersonAccount.PersonHomePhone = c.HomePhone;
                newPersonAccount.PersonMobilePhone = c.MobilePhone;
                newPersonAccount.Phone = c.Phone;
                newPersonAccount.PersonOtherPhone = c.OtherPhone;
                newPersonAccount.Fax = c.Fax;
                newPersonAccount.PersonEmail = c.Email;
                newPersonAccount.PersonMailingCity = c.MailingCity;
                newPersonAccount.PersonMailingCountry = c.MailingCountry;
                newPersonAccount.PersonMailingPostalCode = c.MailingPostalCode;
                newPersonAccount.PersonMailingState = c.MailingState;
                newPersonAccount.PersonMailingStreet = c.MailingStreet;
                newPersonAccount.PersonOtherCity = c.MailingCity;
                newPersonAccount.PersonOtherCountry = c.OtherCountry;
                newPersonAccount.PersonOtherPostalCode = c.OtherPostalCode;
                newPersonAccount.PersonOtherState = c.OtherState;
                newPersonAccount.PersonOtherStreet = c.OtherStreet;
                newPersonAccount.Description = c.Description;
                newPersonAccount.RecordType = personAccountRecordType;
                newPersonAccounts.Add(newPersonAccount);
            }
        }
        insert newPersonAccounts;
    }
}