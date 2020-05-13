public class ComplaintCaseEmailAssociationController 
{
	@AuraEnabled 
    public static void Associate(string caseId, string complaintId)	 
	{  
		try 
		{
            AssociateCaseAndComplaint(caseId,complaintId);
            
        }
		catch (DMLException de) 
		{
			String message = de.getDmlMessage(0);
			throw new AuraHandledException(message);    
		} 
		catch (Exception e) 
		{
			throw new AuraHandledException(e.getMessage());    
		}
    	finally 
		{
        	// Something executed whether there was an error or not
    	}       
    }  
    
    @AuraEnabled 
    public static void AssociateAndClose(string caseId, string complaintId)	 
	{  
		try 
		{
            AssociateCaseAndComplaint(caseId,complaintId);
            CloseCase(caseId);
        }
		catch (DMLException de) 
		{
			String message = de.getDmlMessage(0);
			throw new AuraHandledException(message);    
		} 
		catch (Exception e) 
		{
			throw new AuraHandledException(e.getMessage());    
		}
    	finally 
		{
        	// Something executed whether there was an error or not
    	}       
    }  
    
    private static void AssociateCaseAndComplaint(string caseId, string complaintId)	 
	{  
        List<Complaint_Message__c> newComplaintMessages = new List<Complaint_Message__c>();
		List<EmailMessage> messages = [SELECT Id,CcAddress,FromName,FromAddress,HtmlBody,Subject,ToAddress,ContentDocumentIds FROM EmailMessage WHERE ParentId=:caseId];
        List<Id> emailMessageIds = new List<Id>();
        for(EmailMessage message : messages)
        {
            emailMessageIds.Add(message.Id);
            Complaint_Message__c complaintMessage = new Complaint_Message__c();
            complaintMessage.CC_Addresses__c = message.CcAddress;
            complaintMessage.Complaint__c = complaintId;
            complaintMessage.From__c = message.FromName;
            complaintMessage.From_Email__c = message.FromAddress;
            complaintMessage.Message__c = message.HtmlBody;
            complaintMessage.Subject__c = message.Subject;
            complaintMessage.To_Addresses__c = message.ToAddress;
            complaintMessage.EmailMessageId__c = message.Id;
            //Attachments
            newComplaintMessages.Add(complaintMessage);
        }
        insert newComplaintMessages;
        List<Attachment> attachments = [SELECT Id, Name, Body, ContentType, ParentId,OwnerId FROM Attachment WHERE ParentId in: emailMessageIds];
        for(EmailMessage message : messages)
        {
            for(Attachment attach : attachments)
            {                
                if(attach.ParentId == message.Id)
                {
                 	//Insert ContentVersion
                    ContentVersion cVersion = new ContentVersion();
                    cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
                    cVersion.PathOnClient = attach.Name;//File name with extention
                    cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
                    //cVersion.OwnerId = attach.OwnerId;//Owner of the file
                    cVersion.Title = attach.Name;//Name of the file
                    cVersion.VersionData = attach.Body;//File content
                    Insert cVersion;
                     
                    //After saved the Content Verison, get the ContentDocumentId
                    Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
                    for(Complaint_Message__c cm : newComplaintMessages)
        			{
                        if(cm.EmailMessageId__c==message.Id)
                        {
                            ContentDocumentLink cDocLink1 = new ContentDocumentLink();
                            cDocLink1.ContentDocumentId = conDocument;//Add ContentDocumentId
                            cDocLink1.LinkedEntityId = cm.Id;//Add attachment parentId
                            cDocLink1.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                            cDocLink1.Visibility = 'InternalUsers';//AllUsers, InternalUsers, SharedUsers
                            Insert cDocLink1;
                            
                            ContentDocumentLink cDocLink2 = new ContentDocumentLink();
                            cDocLink2.ContentDocumentId = conDocument;//Add ContentDocumentId
                            cDocLink2.LinkedEntityId = cm.Complaint__c;//Add attachment parentId
                            cDocLink2.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                            cDocLink2.Visibility = 'InternalUsers';//AllUsers, InternalUsers, SharedUsers
                            Insert cDocLink2;
                        }
                    }
                }
            }
        }
    }  
    
    private static void CloseCase(string caseId)	 
	{  
		Case c = [SELECT Id, Status FROM Case WHERE Id=:caseId];
        c.Status='Closed';
        c.CERS_Resolution_Type__c = 'Associated with Complaint';
        update c;
    }  
}