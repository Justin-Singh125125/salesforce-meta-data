public class ExecutiveDashboardStatisticsController 
{
    @AuraEnabled 
    public static integer GetTotalComplaints(string bdo, DateTime beginDate, DateTime endDate) 
	{
        try 
		{
            List<Complaints__c> complaints = new List<Complaints__c>();
            
            
            if(bdo == 'All')
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND CreatedDate >=: beginDate AND CreatedDate <=: endDate ];
            }
            else 
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND BDO_For_Report__c =: bdo AND CreatedDate >=: beginDate AND CreatedDate <=: endDate];
            }                
            return complaints.Size();
        }
        catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
	}
    
     @AuraEnabled 
    public static integer GetTotalEnforcementActions(string bdo, DateTime beginDate, DateTime endDate) 
	{
        try 
		{
            List<Finding__c> findings = new List<Finding__c>();        
            if(bdo == 'All')
            {
                findings = [SELECT Id FROM Finding__c WHERE Complaint__r.Original_Complaint_ID__c = null AND Complaint__r.CreatedDate >=: beginDate AND Complaint__r.CreatedDate <=: endDate AND Violations_or_Compliance_Issues__c = 'Yes' ];
                //findings = [SELECT Id FROM Finding__c WHERE Complaint__r.Original_Complaint_ID__c = null AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Violations_or_Compliance_Issues__c = 'Yes'];
            }
            else 
            {
                findings = [SELECT Id FROM Finding__c WHERE Complaint__r.Original_Complaint_ID__c = null AND Complaint__r.BDO_For_Report__c =: bdo AND Complaint__r.CreatedDate >=: beginDate AND Complaint__r.CreatedDate <=: endDate AND Violations_or_Compliance_Issues__c = 'Yes'];
                //findings = [SELECT Id FROM Finding__c WHERE Complaint__r.Original_Complaint_ID__c = null AND Complaint__r.BDO_For_Report__c =: bdo AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Violations_or_Compliance_Issues__c = 'Yes'];
            }                
            return findings.Size();
        }
        catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
    }

    @AuraEnabled 
    public static integer GetReferredComplaints(string bdo, DateTime beginDate, DateTime endDate) 
	{
        try 
		{
            List<Complaints__c> complaints = new List<Complaints__c>();
            
            
            if(bdo == 'All')
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c <> null ];
            }
            else 
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND BDO_For_Report__c =: bdo AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c <> null];
            }                
            return complaints.Size();
        }
        catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
	}

    @AuraEnabled 
    public static integer GetCalEPAOpenComplaints(string bdo, DateTime beginDate, DateTime endDate) 
	{
        try 
		{
            List<Complaints__c> complaints = new List<Complaints__c>();
            
            
            if(bdo == 'All')
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c <> 'Closed'];
            }
            else 
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND BDO_For_Report__c =: bdo AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c <> 'Closed' ];
            }                
            return complaints.Size();
        }
        catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
	}
    
    @AuraEnabled 
    public static integer GetCalEPAClosedComplaints(string bdo, DateTime beginDate, DateTime endDate) 
	{
        try 
		{
            List<Complaints__c> complaints = new List<Complaints__c>();
            
            
            if(bdo == 'All')
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c='Closed' ];
            }
            else 
            {
                complaints = [SELECT Id FROM Complaints__c WHERE Original_Complaint_ID__c = null AND BDO_For_Report__c =: bdo AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c='Closed'];
            }                
            return complaints.Size();
        }
        catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
	}
    
    @AuraEnabled 
    public static long GetAverageDaysOpen(string bdo, DateTime beginDate, DateTime endDate) 
    {
        try 
        {
            List<Complaints__c> complaints = new List<Complaints__c>();
            
            
            if(bdo == 'All')
            {
                complaints = [SELECT Id, CreatedDate,End_Of_Quarter__c,End_Of_Year__c FROM Complaints__c WHERE Original_Complaint_ID__c = null AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c <> 'Closed'];
            }
            else 
            {
                complaints = [SELECT Id, CreatedDate,End_Of_Quarter__c,End_Of_Year__c FROM Complaints__c WHERE Original_Complaint_ID__c = null AND BDO_For_Report__c =: bdo AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c <> 'Closed' ];
            }
            long totalDaysOpen = 0;
            for(Complaints__c c : complaints)
            {
                Date d = date.newinstance(c.CreatedDate.year(), c.CreatedDate.month(), c.CreatedDate.day());
                long daysOpen = 0;
                if(beginDate.Year() == 2016 && beginDate.Month() == 4 && beginDate.Day() == 1)//All Time
                {
                    daysOpen = d.DaysBetween(date.Today());        
                }
                else
                {
                    
                    if(beginDate.Month() == 1 && beginDate.Day() == 1 && endDate.Month() == 12 && endDate.Day() == 31)//Year
                    {
                        daysOpen = d.DaysBetween(c.End_Of_Year__c);
                    }
                    else//Quarter
                    {
                        daysOpen = d.DaysBetween(c.End_Of_Quarter__c);        
                    }
                }
                totalDaysOpen = totalDaysOpen + daysOpen;
            }
            return totalDaysOpen/complaints.Size();
        }
        catch (Exception e) 
        {
            System.Debug('e:  ' + e);
            throw new AuraHandledException(e.getMessage());    
        }
    }
    
    @AuraEnabled 
    public static long GetAverageDaysToClose(string bdo, DateTime beginDate, DateTime endDate) 
    {
        try 
		{
            List<Complaints__c> complaints = new List<Complaints__c>();
            
            
            if(bdo == 'All')
            {
                complaints = [SELECT Id, Closed_Date__c,CreatedDate FROM Complaints__c WHERE Original_Complaint_ID__c = null AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c='Closed' ];
            }
            else 
            {
                complaints = [SELECT Id, Closed_Date__c,CreatedDate FROM Complaints__c WHERE Original_Complaint_ID__c = null AND BDO_For_Report__c =: bdo AND CreatedDate >=: beginDate AND CreatedDate <=: endDate AND Date_Referred__c = null AND Status__c='Closed'];
            }    
            long totalDaysOpen = 0;
            for(Complaints__c c : complaints)
            {
                Date d = date.newinstance(c.CreatedDate.year(), c.CreatedDate.month(), c.CreatedDate.day());
                long daysOpen = d.DaysBetween(c.Closed_Date__c);
                totalDaysOpen = totalDaysOpen + daysOpen;

            }
            return totalDaysOpen/complaints.Size();
        }
        catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
    }

    @AuraEnabled
    public static string GetNewComplaintsReportUrl(string bdo, Date startDate, Date endDate)
    {
    	string url = '';
        string baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
        Report report = [SELECT Id,Name,FolderName FROM Report WHERE Name='New Complaints Report'];
        String template = '{0}/lightning/r/Report/{1}/view?fv0={2}&fv1={3}&fv2={4}';
        List<Object> parameters = new List<Object> {baseUrl, 
            report.Id,
            EncodingUtil.urlEncode(bdo, 'UTF-8'),            
            EncodingUtil.urlEncode(startDate.format(), 'UTF-8'),
            EncodingUtil.urlEncode(endDate.format(), 'UTF-8')};
        url = String.format(template, parameters);		
        return url;
    }
    
    @AuraEnabled
    public static string GetComplaintsWithViolationsReportUrl(string bdo, Date startDate, Date endDate)
    {
    	string url = '';
        string baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
        Report report = [SELECT Id,Name,FolderName FROM Report WHERE Name='Complaints With Violations Report'];
        String template = '{0}/lightning/r/Report/{1}/view?fv0={2}&fv1={3}&fv2={4}';
        List<Object> parameters = new List<Object> {baseUrl, 
            report.Id,
            EncodingUtil.urlEncode(bdo, 'UTF-8'),            
            EncodingUtil.urlEncode(startDate.format(), 'UTF-8'),
            EncodingUtil.urlEncode(endDate.format(), 'UTF-8')};
        url = String.format(template, parameters);		
        return url;
    }
    
    @AuraEnabled
    public static string GetReferredComplaintsReportUrl(string bdo, Date startDate, Date endDate)
    {
    	string url = '';
        string baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
        Report report = [SELECT Id,Name,FolderName FROM Report WHERE Name='Referred Complaints Report'];
        String template = '{0}/lightning/r/Report/{1}/view?fv0={2}&fv1={3}&fv2={4}';
        List<Object> parameters = new List<Object> {baseUrl, 
            report.Id,
            EncodingUtil.urlEncode(bdo, 'UTF-8'),            
            EncodingUtil.urlEncode(startDate.format(), 'UTF-8'),
            EncodingUtil.urlEncode(endDate.format(), 'UTF-8')};
        url = String.format(template, parameters);		
        return url;
    }
    
	@AuraEnabled
    public static string GetCalEPAHandledOpenComplaintsReportUrl(string bdo, Date startDate, Date endDate)
    {
    	string url = '';
        string baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
        Report report = [SELECT Id,Name,FolderName FROM Report WHERE Name='CalEPA Handled Open Complaints Report'];
        String template = '{0}/lightning/r/Report/{1}/view?fv0={2}&fv1={3}&fv2={4}';
        List<Object> parameters = new List<Object> {baseUrl, 
            report.Id,
            EncodingUtil.urlEncode(bdo, 'UTF-8'),            
            EncodingUtil.urlEncode(startDate.format(), 'UTF-8'),
            EncodingUtil.urlEncode(endDate.format(), 'UTF-8')};
        url = String.format(template, parameters);		
        return url;
    }
    
	@AuraEnabled
    public static string GetCalEPAHandledClosedComplaintsReportUrl(string bdo, Date startDate, Date endDate)
    {
    	string url = '';
        string baseUrl = System.Url.getSalesforceBaseUrl().toExternalForm();
        Report report = [SELECT Id,Name,FolderName FROM Report WHERE Name='CalEPA Handled Closed Complaints Report'];
        String template = '{0}/lightning/r/Report/{1}/view?fv0={2}&fv1={3}&fv2={4}';
        List<Object> parameters = new List<Object> {baseUrl, 
            report.Id,
            EncodingUtil.urlEncode(bdo, 'UTF-8'),            
            EncodingUtil.urlEncode(startDate.format(), 'UTF-8'),
            EncodingUtil.urlEncode(endDate.format(), 'UTF-8')};
        url = String.format(template, parameters);		
        return url;
    }    
}