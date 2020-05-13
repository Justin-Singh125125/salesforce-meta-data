public with sharing class FindingPDFController {
	public FindingDetailViewModel FindingDetailViewModel {get;set;}    

	public FindingPDFController(ApexPages.StandardController controller) 
	{
	}
	
	public PageReference LoadFindingPDF() 
    {
		string findingId = '';
        if(ApexPages.currentPage().getParameters().get('id') != null)
        {
            findingId = ApexPages.currentPage().getParameters().get('id');
        }
        else
        {
            ApplicationException e = new ApplicationException();
            e.setMessage('Missing Finding Id.');
            throw e;
        }
        FindingDetailViewModel = new FindingDetailViewModel();
		Finding__c finding = [SELECT Complaint__c,Completed_By__c,Contact__c,CreatedById, Contact__r.Name, CreatedBy.Name, CreatedBy.Title, CreatedBy.Email, CreatedBy.Phone, CreatedDate, Date_of_Referral__c,Date_of_Site_Visit__c,External_Id__c,Id,IsDeleted,Is_Enforcement_Complete__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,On_Going_Enforcement__c,Other_Reason_for_No_Site_Visit__c,Reason_for_No_Site_Visit__c,Referral_Agency__c,Referral__c,Secondary_Referral__c,Site_Visit_Conducted__c,Summary_of_Violations_and_enforcement__c,Violations_or_Compliance_Issues__c,Violations_Related_to_Complaint__c,Complaint__r.Name,Contact__r.Email,Contact__r.Title,Contact__r.Phone FROM Finding__c WHERE Id =: findingId];
        FindingDetailViewModel.FindingId = finding.Id;
        FindingDetailViewModel.FindingName = finding.Name;
        
        if(finding.Contact__c != null)
        {
            FindingDetailViewModel.CompletedBy = finding.Contact__r.Name;            
            FindingDetailViewModel.Title = finding.Contact__r.Title;
            FindingDetailViewModel.Email = finding.Contact__r.Email;
            FindingDetailViewModel.Phone = finding.Contact__r.Phone;            
        }
        else
        {
            FindingDetailViewModel.CompletedBy = finding.CreatedBy.Name;            
            FindingDetailViewModel.Title = finding.CreatedBy.Title;
            FindingDetailViewModel.Email = finding.CreatedBy.Email;
            FindingDetailViewModel.Phone = finding.CreatedBy.Phone;
        }
        
        
        if(finding.Secondary_Referral__c == 'Yes')
        {
            FindingDetailViewModel.IsSecondaryReferral = true;
        }
        else
        {
            FindingDetailViewModel.IsSecondaryReferral = false;
        }
        FindingDetailViewModel.SecondaryReferral = finding.Secondary_Referral__c;
        FindingDetailViewModel.ReferralAgency  = finding.Referral_Agency__c;
        if(finding.Date_of_Referral__c != null)
        {
            FindingDetailViewModel.DateOfReferral  = DateTime.newInstance(finding.Date_of_Referral__c.year(),finding.Date_of_Referral__c.month(),finding.Date_of_Referral__c.day()).format('MM/dd/yyyy');
        }
        else
        {
            FindingDetailViewModel.DateOfReferral = '';
        }
        if(finding.Site_Visit_Conducted__c == 'Yes')
        {
            FindingDetailViewModel.IsSiteVisit = true;
        }
        else
        {
            FindingDetailViewModel.IsSiteVisit = false;
        }
        FindingDetailViewModel.SiteVisitConducted  = finding.Site_Visit_Conducted__c;
        if(finding.Date_of_Site_Visit__c != null)
        {
            FindingDetailViewModel.DateOfSiteVisit  = DateTime.newInstance(finding.Date_of_Site_Visit__c.year(),finding.Date_of_Site_Visit__c.month(),finding.Date_of_Site_Visit__c.day()).format('MM/dd/yyyy');
        }
        else
        {
            FindingDetailViewModel.DateOfSiteVisit = '';
        }
        if(finding.Reason_for_No_Site_Visit__c == 'Other')
        {
            FindingDetailViewModel.ReasonForNoSiteVisit  = finding.Other_Reason_for_No_Site_Visit__c;
        }
        else
        {
            FindingDetailViewModel.ReasonForNoSiteVisit  = finding.Reason_for_No_Site_Visit__c;
        }
        
        FindingDetailViewModel.ViolationsOrComplianceIssues  = finding.Violations_or_Compliance_Issues__c;
        if(finding.Violations_or_Compliance_Issues__c == 'Yes')
        {
            FindingDetailViewModel.IsViolationsOrComplianceIssues  = true;
        }
        else
        {
            FindingDetailViewModel.IsViolationsOrComplianceIssues  = false;
        }
        
        FindingDetailViewModel.SummaryOfViolationsAndEnforcement  = finding.Summary_of_Violations_and_enforcement__c;
        FindingDetailViewModel.ViolationsRelatedToComplaint  = finding.Violations_Related_to_Complaint__c;
        if(finding.Is_Enforcement_Complete__c == 'Yes')
        {
            FindingDetailViewModel.IsIsEnforcementComplete  = true;
        }
        else
        {
            FindingDetailViewModel.IsIsEnforcementComplete  = false;
        }
        FindingDetailViewModel.IsEnforcementComplete  = finding.Is_Enforcement_Complete__c;
        FindingDetailViewModel.OnGoingEnforcement  = finding.On_Going_Enforcement__c;

        List<Attachment> attachments = [SELECT Id, Name, BodyLength, ContentType FROM Attachment WHERE ParentID =: finding.Id];
        FindingDetailViewModel.Attachments = attachments;


        return null;
    }

	
}