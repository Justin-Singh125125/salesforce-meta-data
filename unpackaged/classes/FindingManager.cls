public with sharing class FindingManager 
{
    public FindingManager() 
    {
        
    }

    @future(callout=true)
    public static void SendConfirmationEmail(Set<Id> findingsIds)
    {
        List<Messaging.SingleEmailMessage> messages = RetrieveConfirmationEmails(findingsIds);
        try
        {
            Messaging.sendEmail(messages);
        }
        catch(emailexception e) 
        {
            System.debug(LoggingLevel.INFO,'e.getDmlType(0):  ' + e.getDmlType(0));
            if(e.getDmlType(0) == StatusCode.NO_MASS_MAIL_PERMISSION)
            {

            }
        }
    }

    @future(callout=true)
    public static void SendNotificationEmail(Set<Id> findingsIds)
    {
        List<Messaging.SingleEmailMessage> messages = RetrieveNotificaitonEmails(findingsIds);
        try
        {
            Messaging.sendEmail(messages);
        }
        catch(emailexception e) 
        {
            System.debug(LoggingLevel.INFO,'e.getDmlType(0):  ' + e.getDmlType(0));
            if(e.getDmlType(0) == StatusCode.NO_MASS_MAIL_PERMISSION)
            {

            }
        }   
    }

    @TestVisible 
    private static List<Messaging.SingleEmailMessage> RetrieveConfirmationEmails(Set<Id> findingsIds)
    {
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        List<Finding__c> findings = [SELECT Id, Contact__c, Contact__r.Name, Complaint__r.Owner.Name, Complaint__r.Owner.Email, CreatedById, Complaint__c FROM Finding__c WHERE Id in : findingsIds];
        User[] users = [SELECT Id, Name, Email from User];
        EmailTemplate emailTemplate = [SELECT Id, HtmlValue, Subject from EmailTemplate where DeveloperName = 'FindingConfirmationEmail'];
        for(Finding__c finding : findings)
        {
            Complaints__c complaint = [SELECT Id, Name from Complaints__c Where Id =: finding.Complaint__c];               

            string body = emailTemplate.HtmlValue;
            body = body.Replace('{!Finding__c.Contact__c}', finding.Contact__r.Name);
            body = body.Replace('{!Finding__c.Complaint__c}', complaint.Name);
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setSubject(emailTemplate.Subject);
            
            if(finding.Contact__c != null)
            {
                Contact[] contacts = [SELECT Id, Name, Email from Contact Where Id =: finding.Contact__c];
                if(contacts[0].Email != null)
                {
                    message.setToAddresses(new String[] {  contacts[0].Email});
                }
                else
                {
                    continue;
                }
            }
            else
            {
                //User[] users = [SELECT Id, Name, Email from User Where Id =: finding.CreatedById];
                User user = GetUserById(users, finding.CreatedById);
                message.setToAddresses(new String[] {user.Email});
            }
            message.setWhatId(finding.Complaint__c);
            message.setHtmlBody(body);
            message.setUseSignature(false);
            message.setSaveAsActivity(true);
            message.setSenderDisplayName('CalEPA Complaints');
            message.setReplyTo(finding.Complaint__r.Owner.Email);

            string findingPdfUrl = OrgURLHelper.GetSiteUrl('ExternalPartnerPortal');
            findingPdfUrl = findingPdfUrl + 'findingpdf?id=';
            findingPdfUrl = findingPdfUrl + finding.Id;
            PageReference pdf = new PageReference(findingPdfUrl);
            Attachment attach = new Attachment();
            attach.ParentId = finding.Id;
            attach.name = 'FindingReport.pdf';
            if(!Test.isRunningTest())
            {
                attach.body = pdf.getContentAsPDF();
            }
            else
            {
                Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
                attach.body=bodyBlob;
            }
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(attach.Name);
            efa.setBody(attach.Body);
            fileAttachments.add(efa);
            message.setFileAttachments(fileAttachments);                
            messages.Add(message);              
        }
        return messages;
    }
    private static User GetUserById(List<User> users, Id id)
    {
        for(User user : users)
        {
            if(user.Id == id)
            {
                return user;
            }
        }
        return null;
    }
    
    @TestVisible 
    private static List<Messaging.SingleEmailMessage> RetrieveNotificaitonEmails(Set<Id> findingsIds)
    {
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        List<Finding__c> findings = [SELECT Id, Contact__c, CreatedById, Complaint__c, Complaint__r.Name,Complaint__r.Owner.Email FROM Finding__c WHERE Id in : findingsIds];
        List<Id> complaintIds = new List<Id>();            
        for(Finding__c finding : findings)
        {
            complaintIds.Add(finding.Complaint__c);
        }
        List<Complaint_Assignment__c> assignments = [SELECT Id, Name, OwnerId, Owner.Email from Complaint_Assignment__c Where Complaint__c in: complaintIds];            
        EmailTemplate emailTemplate = [SELECT Id, HtmlValue, Subject from EmailTemplate where DeveloperName = 'FindingNotificationEmail'];
        for(Finding__c finding : findings)
        {
            string body = emailTemplate.HtmlValue;
            body = body.Replace('{!Finding__c.Complaint__c}', finding.Complaint__r.Name);
            body = body.Replace('{!Finding__c.Link}', System.URL.getSalesforceBaseUrl().toExternalForm() + '/' + finding.Id);
            List<string> emails = new List<string>();
            for(Complaint_Assignment__c assignment: assignments)
            {
                emails.Add(assignment.Owner.Email);
            }
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setSubject(emailTemplate.Subject);
            message.setToAddresses(emails);
            message.setWhatId(finding.Complaint__c);
            message.setHtmlBody(body);
            message.setUseSignature(false);
            message.setSaveAsActivity(true);
            message.setSenderDisplayName('CalEPA Complaints');
            message.setReplyTo(finding.Complaint__r.Owner.Email);
            messages.Add(message);
        }
        return messages;
    }
}