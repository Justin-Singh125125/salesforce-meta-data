public class ComplaintManagementMyCasesController 
{
    @AuraEnabled 
    public static string GetUserCases() 
	{
        id userId = UserInfo.getUserId();
        List<Case> cases = [SELECT Id, CaseNumber, Subject, Status FROM Case WHERE CreatedById =: userId];
        
        List<MyCasesWrapper> l = new List<MyCasesWrapper>();
        for(Case c : cases)
        {
            MyCasesWrapper w = new MyCasesWrapper();
            w.Id = c.Id;
            w.URL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + c.Id;
            w.CaseNumber = c.CaseNumber;
            w.Subject = c.Subject;
			w.Status = c.Status;
            l.add(w);
        }
        return System.json.serialize(l);	
    }

    class MyCasesWrapper
    {
       @AuraEnabled
       public String Id;
       @AuraEnabled
       public String URL;
       @AuraEnabled
       public String CaseNumber;
       @AuraEnabled
       public string Subject;
        @AuraEnabled
       public string Status;
    }
}