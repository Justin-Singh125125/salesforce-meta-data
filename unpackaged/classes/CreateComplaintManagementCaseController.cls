public class CreateComplaintManagementCaseController 
{
    @AuraEnabled 
    public static void Save(string subject, string description)
	{  
		try 
		{
			RecordType recordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Case' AND  Name = 'Complaint Management'];
            Case c = new Case();
            c.RecordTypeId = recordType.Id;
            c.Subject = subject;
            c.Description = description;
            c.Origin = 'Web';
            insert c;
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
}