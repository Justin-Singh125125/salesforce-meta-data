public with sharing class CalEPAContentVersionTriggerHandler extends TriggerHandler
{
    protected override void beforeInsert()
    {
        set<String> notAllowed = new set<String>();
        List<Excluded_File_Type__c> excludedTypes = [SELECT Id, Extension__c FROM Excluded_File_Type__c];
        for(Excluded_File_Type__c excludedType : excludedTypes)
        {
            notAllowed.Add(excludedType.Extension__c);
        }
        for (ContentVersion f : (List<ContentVersion>)Trigger.new) 
        { 
            try
            { 
                String strFilename = f.PathOnClient.toLowerCase(); 
                List<String> parts = strFilename.splitByCharacterType(); 
                if(notAllowed.Contains(parts[parts.size()-1]))
                {	   
                    f.addError('File having this extension could not be attached,Please try some other extension.'); 
                }
            } 
            catch(exception e)
            {
	        } 
        } 
    }
}