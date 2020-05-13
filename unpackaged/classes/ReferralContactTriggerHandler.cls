public with sharing class ReferralContactTriggerHandler extends TriggerHandler 
{
    protected override void afterInsert()
    {
        //Retrieve Email Template
        EmailTemplate emailTemplate = [SELECT Id, HtmlValue, Subject from EmailTemplate where DeveloperName = 'ReferralEmail'];
        //Filter out Referral Contacts that have already been sent
        List<ReferralContact__c> newReferralContacts = (List<ReferralContact__c>)trigger.new;
        List<ReferralContact__c> unsentReferralContacts = new List<ReferralContact__c>();
        for (ReferralContact__c newReferralContact : newReferralContacts) 
        {
            if(newReferralContact.Sent__c == false)
            {
                unsentReferralContacts.Add(newReferralContact);
            }
        }

        //Get a copy of Referral Contacts for Update
        List<Id> referralContactIds = new List<Id>();
        for (ReferralContact__c unsentReferralContact : unsentReferralContacts) 
        {
            if(!referralContactIds.Contains(unsentReferralContact.Id))
            {
                referralContactIds.Add(unsentReferralContact.Id);
            }
        }
        List<ReferralContact__c> tempReferralContacts = [SELECT Id, Sent__c from ReferralContact__c Where Id in: referralContactIds];
        Map<Id, ReferralContact__c> referralContactMap = new Map<Id, ReferralContact__c>(tempReferralContacts);
        
        //Get the (Created By) Users for the Unsent Referral Contacts
        List<Id> userIds = new List<Id>();
        for (ReferralContact__c unsentReferralContact : unsentReferralContacts) 
        {
            if(!userIds.Contains(unsentReferralContact.CreatedById))
            {
                userIds.Add(unsentReferralContact.CreatedById);
            }
        }
        List<User> users = [SELECT Id, Name, Email from User Where Id in: userIds];
        Map<Id, User> userMap = new Map<Id, User>(users);

        //Get the Contacts for the Unsent Referral Contacts
        List<Id> contactIds = new List<Id>();
        for (ReferralContact__c unsentReferralContact : unsentReferralContacts) 
        {
            if(!contactIds.Contains(unsentReferralContact.Contact__c))
            {
                contactIds.Add(unsentReferralContact.Contact__c);
            }
        }
        List<Contact> contacts = [SELECT Id, Name,Email from Contact Where Id in: contactIds];
        Map<Id, Contact> contactMap = new Map<Id, Contact>(contacts);
        
        //Get The Referrals for the Unsent Referral Contacts
        List<Id> referralIds = new List<Id>();
        for (ReferralContact__c unsentReferralContact : unsentReferralContacts) 
        {
            if(!referralIds.Contains(unsentReferralContact.Referral__c))
            {
                referralIds.Add(unsentReferralContact.Referral__c);
            }
        }
        List<Referral__c> referrals = [SELECT Id, Complaint__c, CreatedById FROM Referral__c WHERE Id in: referralIds];
        Map<Id, Referral__c> referralMap = new Map<Id, Referral__c>(referrals);
        
        //Get The Complaints for the Referrals
        List<Id> complaintIds = new List<Id>();
        for (Referral__c referral : referrals) 
        {
            if(!complaintIds.Contains(referral.Complaint__c))
            {
                complaintIds.Add(referral.Complaint__c);
            }
        }
        List<Complaints__c> complaints = [SELECT Id, Name from Complaints__c Where Id in: complaintIds];
        Map<Id, Complaints__c> complaintMap = new Map<Id, Complaints__c>(complaints);

        //Get the Attachments
        Map<Id, Blob> attachmentMap = new Map<Id, Blob>();
        List<ContentDocumentLink> contentDocumentLinks = [SELECT ContentDocumentId,LinkedEntityId  FROM ContentDocumentLink WHERE LinkedEntityId in: complaintIds];
        if(contentDocumentLinks.size() > 0)
        {
            List<ContentVersion> contentVersions = [SELECT Title,FileExtension,VersionData,ContentDocumentId FROM ContentVersion WHERE (ContentDocumentId =: contentDocumentLinks[0].ContentDocumentId) AND (IsLatest = true) AND (Title='ComplaintReport' OR Title='ComplaintOriginalSubmission')];
            for(ContentVersion contentVersion : contentVersions)
            {
                if(!attachmentMap.containsKey(contentDocumentLinks[0].LinkedEntityId))
                {                    
                    attachmentMap.put(contentDocumentLinks[0].LinkedEntityId, contentVersion.VersionData);
                }
            }
        }
        List<Attachment> attachments = [SELECT Id, Name, Body, CreatedDate, ParentId FROM Attachment WHERE ParentId in: complaintIds AND (Name ='ComplaintReport.pdf' OR Name LIKE '%Original Complaint Submission%') ORDER BY CreatedDate desc];
        for(Attachment attachment : attachments)
        {
            if(!attachmentMap.containsKey(attachment.ParentId))
            {
                attachmentMap.put(attachment.ParentId, attachment.Body);
            }
        }
              
        List<ReferralContact__c> referralContactsToUpdate = new List<ReferralContact__c>();

        //Loop through the Unsent Referral Contacts
        for (ReferralContact__c unsentReferralContact : unsentReferralContacts) 
        {
            //Get URLs to Put in the Email
            string externalUrl = '';
            string referralUrl = '';
            string url = OrgURLHelper.GetSiteUrl('ExternalPartnerPortal');
            externalUrl = url;
            referralUrl = url;
            referralUrl = referralUrl + 'ExternalPartnerRouting?referralId=';
            referralUrl = referralUrl + unsentReferralContact.Referral__c;

            //Generate the Email Messages for the (unsent) Referral Contacts for the Referral
            Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
            emailMessage.setSubject(emailTemplate.Subject);
            emailMessage.setToAddresses(new String[] {contactMap.get(unsentReferralContact.Contact__c).Email});
            emailMessage.setTargetObjectId(unsentReferralContact.Contact__c);
            emailMessage.setWhatId(unsentReferralContact.Referral__c);
            emailMessage.setSenderDisplayName('CalEPA Complaints');
            emailMessage.setReplyTo('complaints@calepa.ca.gov');
            string htmlBodyText = '';
            if(!Test.isRunningTest())
            {
                string body = emailTemplate.HtmlValue;
                body = body.Replace('{!ReferralEmailViewModel.ReferredToContactName}', contactMap.get(unsentReferralContact.Contact__c).Name);
                if(!String.isBlank(unsentReferralContact.Message__c))
                {
                    body = body.Replace('{!ReferralEmailViewModel.Message}', unsentReferralContact.Message__c);
                }
                else
                {
                    body = body.Replace('{!ReferralEmailViewModel.Message}', '');
                }
                body = body.Replace('{!ReferralEmailViewModel.ComplaintId}', referralMap.get(unsentReferralContact.Referral__c).Complaint__c);
                body = body.Replace('{!ReferralEmailViewModel.ReferralUrl}', referralUrl);
                body = body.Replace('{!ReferralEmailViewModel.ExternalPartnerPortalUrl}', externalUrl);
                body = body.Replace('{!ReferralEmailViewModel.ComplaintNumber}', complaintMap.get(referralMap.get(unsentReferralContact.Referral__c).Complaint__c).Name);
                body = body.Replace('{!ReferralEmailViewModel.FromName}', userMap.get(unsentReferralContact.CreatedById).Name);
                body = body.Replace('{!ReferralEmailViewModel.FromEmail}', userMap.get(unsentReferralContact.CreatedById).Email);
                htmlBodyText = body;
            }
            else
            {
                htmlBodyText = 'Unit Test Attachment Body';
            }
            emailMessage.setHtmlBody(htmlBodyText);
            emailMessage.setUseSignature(false);
            emailMessage.setSaveAsActivity(true);
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            
            Referral__c r = [SELECT Id, Complaint__c FROM Referral__c WHERE Id=:unsentReferralContact.Referral__c];
            string complaintId = r.Complaint__c;
            //unsentReferralContact.Referral__r.Complaint__c
            
            if(attachmentMap.containsKey(complaintId))
            {
                Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                efa.setFileName('Complaint Report.pdf');
                efa.setBody(attachmentMap.get(complaintId));
                fileAttachments.add(efa);
                emailMessage.setFileAttachments(fileAttachments);
            }         
            
            //Send Email Message
            Boolean emailResult = false;
            if(!Test.isRunningTest())
            {
                try
                {
                    Messaging.SendEmailResult result = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {emailMessage})[0];
                    emailResult = result.IsSuccess();
                }
                catch (System.EmailException ex)
                {
                    if(ex.getMessage().contains('NO_MASS_MAIL_PERMISSION'))
                    {
                        emailResult = true;
                    }
                    else
                    {    
                        throw ex;
                    }
                }
                
            }   
            if(emailResult)         
            {
                ReferralContact__c referralContactToUpdate = referralContactMap.get(unsentReferralContact.Id);
                referralContactToUpdate.Sent__c = true;
                referralContactsToUpdate.Add(referralContactToUpdate);
            }
        }
        update referralContactsToUpdate;
    }
}