public with sharing class ComplaintDetailsViewModel 
    {
        public ComplaintDetailsViewModel() 
        {
            Attachments = new List<Attachment>();
            Referrals = new List<Referral__c>();
        }
        public string Id {get;set;}
        public string ComplaintNumber {get; set;}
        public string DateAndTimeOfOccurrence {get; set;}
        public string OnGoingOccurrence {get; set;}
        public string Spill {get; set;}
        public string Refinery {get; set;}
        public string EJComplaint {get; set;}
        public string TribalComplaint {get; set;}
        public boolean ReferredToCalEPA{get; set;}
        public string ReferringAgency {get; set;}
        public string ReferringName {get; set;}
        public string ReferringEmailAddress {get; set;}
        public boolean HasPreviousOrganizations {get; set;}
        public string PreviousOrganizations {get; set;}
        public boolean IsAnonymous  {get; set;}
        public string AnonymousSubmission  {get; set;}
        public string ComplainantFirstName {get; set;}
        public string ComplainantLastName {get; set;}	
        public string ComplainantStreet {get; set;}
        public string ComplainantCity {get; set;}
        public string ComplainantState {get; set;}
        public string ComplainantZipCode {get; set;}
        public string ComplainantPhone {get; set;}
        public string ComplainantMobile {get; set;}
        public string ComplainantEmail {get; set;}
        public string ComplaintLocationStreet {get; set;}
        public string ComplaintLocationCity {get; set;}
        public string ComplaintLocationCounty {get; set;}
        public string ComplaintLocationState {get; set;}	
        public string ComplaintLocationZipCode {get; set;}	
        public string Latitude {get; set;}
        public string Longitude {get; set;}
        public string LocationDescription 	 {get; set;}
        public string ResponsiblePartyName {get; set;}
        public string ResponsiblePartyCompany {get; set;}
        public string ResponsiblePartyPhone {get; set;}
        public string ResponsiblePartyAddress {get; set;}
        public string ResponsiblePartyCity {get; set;}
        public string ResponsiblePartyState {get; set;}
        public string ResponsiblePartyZipCode {get; set;}
        public string ComplaintDescription {get; set;}
        public string AreaOfConcernLabel {get; set;}	
        public boolean IsAir 	 {get; set;}
        public string VehicleOrStationary {get; set;}
        public string AirComplaintSourceInfo {get; set;}
        public boolean IsSolidWasteCalRecycle {get; set;}
        public string BottlesCansRecycling {get; set;}
        public string AdditionalSolidWaste {get; set;}
        public string WasteTires {get; set;}
        public boolean IsPesticides {get; set;}
        public string NatureOfPesticidesReport {get; set;}
        public string ReportedToCAC {get; set;}
        public boolean IsToxicSubstances {get; set;}
        public string  SensitiveLocation	 {get; set;}    
        public string  HowDidYouBecomeAwareOfTheIncident {get; set;}	
        public string  RelationshipToResponsibleParty	 {get; set;}
        public boolean IsWater {get; set;}
        public string Watershed {get; set;}
        public string NameOfAffectedWaterSource {get; set;}
        public string DrinkingWater {get; set;}
        public string WaterCannabisMarijuana {get; set;}
        public string WaterQuality {get; set;}
        public boolean IsWaterRights {get; set;}
        public string WaterRights {get; set;}
        public string WaterRightsNumber {get; set;}
        public string WaterRightsOwner {get; set;}
        public string WaterRightsDescription {get; set;}
        public string OtherWaterRelatedConcerns {get; set;}
        public List<Attachment> Attachments {get; set;}
        public List<Referral__c> Referrals {get; set;}
    }