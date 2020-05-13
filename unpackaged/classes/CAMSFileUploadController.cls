public class CAMSFileUploadController 
{
    @AuraEnabled 
    public static boolean SaveCAMSFile(id recordId, string name, string description, id contentVersionId, string fin)	 
	{  
		try 
		{
            if(string.isBlank(fin))
            {
                fin='false';
            }
            System.Debug('fin:  ' + fin);
            ContentVersion contentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersionId LIMIT 1];
            Schema.SObjectType type = recordId.getsobjecttype();
            if(type.getDescribe().getName() == 'CAMS_Assignment__c')
            {
                CAMS_Assignment__c assignment = [SELECT Id, Name FROM CAMS_Assignment__c WHERE Id=: recordId];
                File__c newFile = new File__c();
                newFile.assignment__c = assignment.id;
                newFile.uploaded_to__c = assignment.name;
                newFile.Name = contentVersion.Title;
                newFile.Description__c = description;
                newFile.Doc_Id__c = contentVersion.ContentDocumentId;
                newFile.Final__c = Boolean.valueOf(fin);
                System.Debug('newFile.Final__c:  ' + newFile.Final__c);
                insert newFile;
            }
            else
            {
                if(type.getDescribe().getName() == 'CAMS_Task__c')
                {
                    CAMS_Task__c task = [SELECT Id, Name, CAMS_Assignment__c FROM CAMS_Task__c WHERE Id=: recordId];
                    File__c newFile = new File__c();
                    newFile.assignment__c = task.CAMS_Assignment__c;
                    newFile.uploaded_to__c = task.Name;
                    newFile.Name = contentVersion.Title;
                    newFile.Description__c = description;
                    newFile.Doc_Id__c = contentVersion.ContentDocumentId;
                    newFile.Final__c = Boolean.valueOf(fin);
                    System.Debug('newFile.Final__c:  ' + newFile.Final__c);
                    insert newFile;
                }
            }
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

    @AuraEnabled
    public static Id SaveTheFile(Id parentId, String fileName, String base64Data, String contentType) 
    { 
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        ContentVersion contentVersion = new ContentVersion(versionData = EncodingUtil.base64Decode(base64Data), IsMajorVersion=false, title = fileName, pathOnClient =  '/' + fileName, FirstPublishLocationId = parentId);
        insert contentVersion; 
        return contentVersion.Id;
    }

    @AuraEnabled
    public static Id SaveTheChunk(Id parentId, String fileName, String base64Data, String contentType, String fileId) 
    { 
        try 
		{
            if (fileId == '') 
            {
                fileId = SaveTheFile(parentId, fileName, base64Data, contentType);
            } 
            else 
            {
                AppendToFile(fileId, base64Data);
            }
            return Id.valueOf(fileId);
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

    private static void AppendToFile(Id fileId, String base64Data) 
    {
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        ContentVersion contentVersion = [SELECT Id, versionData FROM ContentVersion WHERE Id = :fileId];
        String existingBody = EncodingUtil.base64Encode(contentVersion.versionData);
        contentVersion.versionData = EncodingUtil.base64Decode(existingBody + base64Data); 
        update contentVersion;   
    }
}