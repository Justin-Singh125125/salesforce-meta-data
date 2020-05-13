public class CAMSNoteCreateController 
{
    @AuraEnabled 
    public static boolean SaveCAMSNote(id recordId, string subject, string content)	 
	{  
		try 
		{
            CAMS_Note__c note = new CAMS_Note__c();
            note.Name = subject;
            note.Content__c = content;
            Schema.SObjectType type = recordId.getsobjecttype();
            if(type.getDescribe().getName() == 'CAMS_Assignment__c')
            {
                CAMS_Assignment__c assignment = [SELECT Id, Name FROM CAMS_Assignment__c WHERE Id=: recordId];
                note.CAMS_Assignment__c = assignment.Id;
                note.Uploaded_To__c = assignment.Name;
            }
            else
            {
                if(type.getDescribe().getName() == 'CAMS_Task__c')
                {
                    CAMS_Task__c task = [SELECT Id, Name, CAMS_Assignment__c FROM CAMS_Task__c WHERE Id=: recordId];
                    note.CAMS_Assignment__c = task.CAMS_Assignment__c;
                    note.CAMS_Task__c = task.Id;
                    note.Uploaded_To__c = task.Name;
                }
            }
            insert note;
            return true;
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