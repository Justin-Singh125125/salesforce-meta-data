public without Sharing class LightningLookupController 
{
	@AuraEnabled
    public static List <sObject> FetchLookUpValues(String searchKeyWord, String objectName, string additionalWhere) 
    {
        try 
		{
            System.Debug('searchKeyWord:  ' + searchKeyWord);
            System.Debug('objectName:  ' + objectName);
            System.Debug('additionalWhere:  ' + additionalWhere);
            List<sObject> returnList = new List<sObject>();
            string sQuery =  'select id, Name from ' ;
            sQuery = sQuery + objectName;
            sQuery = sQuery + ' where Name LIKE ';
            if(string.isBlank(searchKeyWord))
            {
                sQuery = sQuery + '\'%%\'';    
            }
            else
            {
                sQuery = sQuery + '\'';
            	sQuery = sQuery + searchKeyWord;
            	sQuery = sQuery + '%\'';    
            }
            if(!string.isBlank(additionalWhere))
            {
                sQuery = sQuery + ' AND ' + additionalWhere;
            }
            sQuery = sQuery + ' order by createdDate DESC limit 5';
            System.Debug('sQuery:  ' + sQuery);
            List <sObject> lstOfRecords = Database.query(sQuery);
            
            for (sObject obj: lstOfRecords) 
            {
                returnList.add(obj);
            }
            return returnList;
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