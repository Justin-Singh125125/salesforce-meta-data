public class ComplaintManagementGrantAccessController
{
    @AuraEnabled 
    public static void GrantAccess(string caseId, string accountId)	 
	{  
		try 
		{
            RecordType recordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Contact' AND  Name = 'CalEPA Partner'];
			Case c = [SELECT Id, ContactId FROM Case WHERE Id=:caseId];
            
            
            Contact con = [SELECT Id, AccountId, RecordTypeId,Email,Name FROM Contact WHERE Id=:c.ContactId];
            con.AccountId = accountId;
            con.RecordTypeId = recordType.Id;
            string resetCode = GenerateRandomString(12);
            con.Reset_Code__c = resetCode;
            update con;
            
            
            c.AccountId = accountId;
            update c;

            if(!Test.isRunningTest())
            {
                List<Messaging.SingleEmailMessage> emails = SendRegistrationEmail(con.Id);
                try
                {
                    Messaging.SendEmailResult result = Messaging.sendEmail(emails)[0];
                }
                catch(emailexception e) 
                {

                }   
            }  
            //End
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
    
	private static string GenerateRandomString(Integer len) 
    {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) 
        {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
    
    private static List<Messaging.SingleEmailMessage>  SendRegistrationEmail(string contactId)
    {
        
        EmailTemplate template = [SELECT Id FROM EmailTemplate WHERE DeveloperName ='External_Partner_Portal_Access_Granted'];
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setTargetObjectId(contactId);
        message.setTemplateId(template.Id);
        message.setBccSender(false);
        message.setUseSignature(false);
        message.setReplyTo('complaints@calepa.ca.gov');
        message.setSenderDisplayName('CalEPA Complaints');
        message.setSaveAsActivity(true); 
        List<Messaging.SingleEmailMessage>  emails = new List<Messaging.SingleEmailMessage>();
        emails.Add(message);
        return emails;
    }
}