public class CalEPAMatchingMergeController 
{
    @AuraEnabled 
    public static CalEPA_Matching__c GetMatchingRecord(id recordId)	 
	{ 
        CalEPA_Matching__c match = [SELECT Id, Record_1__c,Record_1_Name__c,Record_2__c,Record_2_Name__c,Object__c FROM CalEPA_Matching__c WHERE Id=:recordId Limit 1];
        return match;
    }

    @AuraEnabled 
    public static void MergeRecords(string objectType, id sourceId,id destinationId) 
	{
		try 
        {
            if(objectType == 'Account')
            {
                Account destinationAccount = [SELECT Id FROM Account WHERE Id=:destinationId];
                Account sourceAccount = [SELECT Id FROM Account WHERE Id=:sourceId];
    			merge destinationAccount sourceAccount;
            }
            else
            {
				if(objectType == 'Contact')
                {
                    Contact destinationContact = [SELECT Id FROM Contact WHERE Id=:destinationId];
                	Contact sourceContact = [SELECT Id FROM Contact WHERE Id=:sourceId];
    				merge destinationContact sourceContact;
                }                
            }
		} 
        catch (DMLException de) 
		{
			System.Debug('de:  ' + de);
			throw new AuraHandledException(de.getMessage());    
		} 
		catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
	}

}