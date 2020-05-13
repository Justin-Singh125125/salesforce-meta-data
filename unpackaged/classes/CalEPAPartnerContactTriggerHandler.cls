public with sharing class CalEPAPartnerContactTriggerHandler extends TriggerHandler 
{
    public CalEPAPartnerContactTriggerHandler() 
    {
        
    }
    protected override void beforeInsert()
    {
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        List<Contact> existingContacts = [SELECT Id, RecordTypeId, Email FROM Contact WHERE RecordTypeID =: calEPAPartnerContactRecordType.Id];
        for(Contact contact : (List<Contact>)Trigger.new) 
        {
            if(contact.RecordTypeId == calEPAPartnerContactRecordType.Id)
            {
                if(contact.Email != null && contact.Email != '')
                {
                    for(Contact existingContact : existingContacts)
                    {           
                        if(existingContact.Email == contact.Email && existingContact.RecordTypeId == calEPAPartnerContactRecordType.Id)
                        {
                            contact.AddError('Duplicate Email Address.  Instead of creating a new contact, please create a related contact record.  If you need assistance contact complaints@calepa.ca.gov.');
                        }
                    }
                }
            }
        }
    }
    protected override void afterInsert()
    {
        
    }
    protected override void beforeUpdate()
    {
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        List<Contact> existingContacts = [SELECT Id, RecordTypeId, Email FROM Contact WHERE RecordTypeID =: calEPAPartnerContactRecordType.ID];
        for(Contact contact : (List<Contact>)Trigger.new) 
        {
            if(contact.RecordTypeId == calEPAPartnerContactRecordType.Id)
            {
                if(contact.Email != null && contact.Email != '')
                {
                    for(Contact existingContact : existingContacts)
                    {
                        if(existingContact.Email == contact.Email && existingContact.Id != contact.Id)
                        {
                            contact.AddError('You cannot change this email address.  There is already a contact with this email.  If you need assistance contact complaints@calepa.ca.gov.');
                        }
                    }               
                }
            }
        }
    }
                            
    protected override void beforeDelete()
    {
        List<Id> contactIds = new List<Id>();
        for(Contact contact : (List<Contact>)Trigger.Old) 
        {
            contactIds.Add(contact.Id);
        }
        
        List<ContactEdit__c> contactEditsToDelete = [SELECT Id FROM ContactEdit__c WHERE Contact__c in: contactIds];
        delete contactEditsToDelete;
    }
}