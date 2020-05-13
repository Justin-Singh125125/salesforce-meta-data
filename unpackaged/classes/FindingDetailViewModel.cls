public with sharing class FindingDetailViewModel 
    {
        public FindingDetailViewModel() 
        {
            Attachments = new List<Attachment>();
        }
        //public Finding__c Finding {get;set;}       
        public string FindingId {get;set;} 
        public string FindingName {get;set;}
        public string CompletedBy {get;set;}
        public string Title {get;set;}
        public string Email {get;set;}
        public string Phone {get;set;}
        public boolean IsSecondaryReferral {get;set;}
        public string SecondaryReferral {get;set;}
        public string ReferralAgency {get;set;}
        public string DateOfReferral {get;set;}
        public boolean IsSiteVisit {get;set;}
        public string SiteVisitConducted {get;set;}
        public string DateOfSiteVisit {get;set;}
        public string ReasonForNoSiteVisit {get;set;}        
        public string ViolationsOrComplianceIssues {get;set;}
        public boolean IsViolationsOrComplianceIssues {get;set;}
        public string SummaryOfViolationsAndEnforcement {get;set;}
        public string ViolationsRelatedToComplaint {get;set;}
        public boolean IsIsEnforcementComplete {get;set;}
        public string IsEnforcementComplete {get;set;}
        public string OnGoingEnforcement {get;set;}
        public List<Attachment> Attachments{get;set;}
    }