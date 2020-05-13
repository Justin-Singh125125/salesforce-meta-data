public class DashboardCompsWithEnforcementController 
{
    @AuraEnabled 
    public static string GetComplaintsWithEnforcementAction() 
	{
        List<Finding__c> findings = [SELECT Id, Complaint__c, Complaint__r.Name, CreatedDate FROM Finding__c WHERE Violations_or_Compliance_Issues__c = 'Yes' ORDER BY CreatedDate desc];
        List<DashboardCompsWithEnforcementWrapper> l = new List<DashboardCompsWithEnforcementWrapper>();
        for(Finding__c finding : findings)
        {
            DashboardCompsWithEnforcementWrapper d = new DashboardCompsWithEnforcementWrapper();
            d.Id = finding.Id;
            d.URL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + d.Id;
            d.ComplaintNumber = finding.Complaint__r.Name;
            d.CreatedDate = finding.CreatedDate.format('MM/dd/yyyy');
            l.add(d);
        }
        return System.json.serialize(l);
    }

    class DashboardCompsWithEnforcementWrapper
    {
       @AuraEnabled
       public String Id;
       @AuraEnabled
       public String URL;
       @AuraEnabled
       public String ComplaintNumber;
       @AuraEnabled
       public string CreatedDate;
    }

}