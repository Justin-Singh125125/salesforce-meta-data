public with sharing class ReferralTriggerHandler extends TriggerHandler 
{
    protected override void afterInsert()
    {
        List<Id> referralIds = new List<Id>();
                List<ReferralContact__c> referralContactToInsert = new List<ReferralContact__c>();
        List<Referral__c> referralsToUpdate = new List<Referral__c>();
        for(Referral__c referral : (List<Referral__c>)trigger.new)
        {
            referralIds.Add(referral.Id);
            //Create Referral Contacts
            if(!string.IsBlank(referral.SelectedContacts__c))
            {
                List<string> referralContactIds = referral.SelectedContacts__c.Split(',');
                List<Contact> contacts = [SELECT Id, Email From Contact Where Id in: referralContactIds];
                for(Contact contact : contacts)
                {
                    ReferralContact__c referralContact = new ReferralContact__c(); 
                    referralContact.Contact__c = contact.Id;
                    referralContact.Referral__c = referral.Id;
                    referralContact.Message__c = referral.Message__c;
                    referralContactToInsert.Add(referralContact);                 
                }
                Referral__c newRef = new Referral__c(id = referral.Id);
                newRef.SelectedContacts__c = '';
                referralsToUpdate.Add(newRef);
            }
            //End Create Referral Contacts           
        }
        if(!Test.isRunningTest())
        {
            ReferralTriggerHandler.CreateReferralPDF(referralIds);
        }
        if(referralsToUpdate.size() > 0)
        {
            update referralsToUpdate;
        }
        if(referralContactToInsert.size() > 0)
        {
            insert referralContactToInsert;
        }
    }
    
    protected override void afterUpdate()
    {
        System.Debug('ReferralTriggerHandler.afterUpdate');
        List<Referral__c> referralsToUpdate = new List<Referral__c>();        
        List<ReferralContact__c> referralContactToInsert = new List<ReferralContact__c>();
        System.Debug('trigger.new:  ' + trigger.new);
        for(Referral__c referral : (List<Referral__c>)trigger.new)
        {
            system.debug('referral.SelectedContacts__c:  ' + referral.SelectedContacts__c);
            //Create Referral Contacts
            if(!string.IsBlank(referral.SelectedContacts__c))
            {
                List<string> referralContactIds = referral.SelectedContacts__c.Split(',');
                List<Contact> contacts = [SELECT Id, Email From Contact Where Id in: referralContactIds];
                for(Contact contact : contacts)
                {
                    ReferralContact__c referralContact = new ReferralContact__c(); 
                    referralContact.Contact__c = contact.Id;
                    referralContact.Referral__c = referral.Id;
                    referralContact.Message__c = referral.Message__c;
                    referralContactToInsert.Add(referralContact);                 
                }
                Referral__c newRef = new Referral__c(id = referral.Id);
                newRef.SelectedContacts__c = null;
                referralsToUpdate.Add(newRef); 
                System.Debug('referralsToUpdate:  ' + referralsToUpdate);
            }
            //End Create Referral Contacts
        }
        if(referralsToUpdate.size() > 0)
        {
            update referralsToUpdate;
        }
        if(referralContactToInsert.size() > 0)
        {
            insert referralContactToInsert;
        }
    }
    
    @future(callout=true)
    public static void CreateReferralPDF(List<id> referralIds)
    {
        List<Referral__c> referrals = [SELECT Id, Complaint__c,SelectedContacts__c,Message__c FROM Referral__c WHERE Id in: referralIds];
        for(Referral__c referral : referrals)
        {
            //Create Complaint PDF
            PageReference pdf = Page.ComplaintPDF;
            pdf.getParameters().put('id', referral.Complaint__c);
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.Title = 'ComplaintReport';
            contentVersion.PathOnClient = 'ComplaintReport.pdf';
            if(!Test.isRunningTest())
            {
                contentVersion.VersionData = pdf.getContentAsPDF();
            }
            else
            {
                Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
                contentVersion.VersionData=bodyBlob;
            }
            contentVersion.IsMajorVersion = true;
            insert contentVersion;
            //End Create Complaint PDF

            //Link PDF to Referral
            contentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id LIMIT 1];
            ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
            contentDocumentLink.ContentDocumentId = contentVersion.ContentDocumentId;
            contentDocumentLink.LinkedEntityId = referral.Id;
            contentDocumentLink.ShareType = 'I';
            contentDocumentLink.Visibility = 'AllUsers';
            insert contentDocumentLink;
            //End Link PDF to Referral

            
        }
    }
}