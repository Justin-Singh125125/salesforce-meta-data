public class DashboardAvgDaysOpenController 
{
    @AuraEnabled 
    public static long GetMaximumDaysOpen(string bdo) 
	{
        try 
		{
            if(bdo != 'All')
            {
                List<AggregateResult> result1 = [SELECT MAX(Days_Open__c)  FROM Complaints__c WHERE BDO_For_Report__c =: bdo];
                if(result1[0].get('expr0')==null)
                {
                    return 0;
                }
                string allStr = string.ValueOf(result1[0].get('expr0'));
                return long.valueOf(allStr);

            }
            else 
            {
                List<AggregateResult> result2 = [SELECT MAX(Days_Open__c)  FROM Complaints__c];
                if(result2[0].get('expr0')==null)
                {
                    return 0;
                }
                string bdoStr = string.ValueOf(result2[0].get('expr0'));
                return long.valueOf(bdoStr);
            } 
        }
		catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}               
	}

    @AuraEnabled 
    public static long GetAverageDaysOpen(string bdo) 
	{
        try 
		{
            if(bdo != 'All')
            {
                List<AggregateResult> result1 = [SELECT AVG(Days_Open__c)  FROM Complaints__c WHERE BDO_For_Report__c =: bdo];
                if(result1[0].get('expr0')==null)
                {
                    return 0;
                }
                string allStr = string.ValueOf(result1[0].get('expr0'));
                decimal d = decimal.valueOf(allStr);
                return d.Round();

            }
            else 
            {
                List<AggregateResult> result2 = [SELECT AVG(Days_Open__c)  FROM Complaints__c];
                if(result2[0].get('expr0')==null)
                {
                    return 0;
                }
                string bdoStr = string.ValueOf(result2[0].get('expr0'));
                decimal d = decimal.valueOf(bdoStr);
                return d.Round();
            }     
        }
		catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}               
	}
}