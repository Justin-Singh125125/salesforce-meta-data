public with sharing class ComplaintPDFController 
{
    public ComplaintDetailsViewModel ComplaintDetailsViewModel {get;set;}    

    public ComplaintPDFController(ApexPages.StandardController controller)
    {
    }    

    public PageReference LoadComplaintPDF()
    {
        string complaintId = '';
        if(ApexPages.currentPage().getParameters().get('id') != null)
        {
            complaintId = ApexPages.currentPage().getParameters().get('id');
        }
        else
        {
            ApplicationException e = new ApplicationException();
            e.setMessage('Missing Finding Id.');
            throw e;
        }
        ComplaintDetailsViewModel viewModel = new ComplaintDetailsViewModel();        
        Complaints__c complaint = [SELECT   Id, 
                                            Name, 
                                            Date_and_Time_of_Occurrence__c, 
                                            On_going_Occurrence__c,
                                            Spill__c, 
                                            Refinery__c,
                                            EJ_Complaint__c,
                                            Tribal_Complaint__c,
                                            Referring__c,
                                            Referring_Agency__c,
                                            Referring_Name__c,
                                            Referring_Email_Address__c,
                                            Anonymous__c,
                                            Complainant__r.PersonContact.FirstName,
                                            Complainant__r.PersonContact.LastName,
                                            Complainant__r.PersonContact.MailingCity,
                                            Complainant__r.PersonContact.MailingState,
                                            Complainant__r.PersonContact.MailingStreet,
                                            Complainant__r.PersonContact.MailingPostalCode,
                                            Complainant__r.PersonContact.MobilePhone,
                                            Complainant__r.PersonContact.HomePhone,
                                            Complainant__r.PersonContact.HasOptedOutOfEmail,
                                            Complainant__r.PersonContact.Email,
                                            Previous_Organizations__c,
                                            Complaint_Location_Address__c,
                                            Complaint_Location_City__c,
                                            Complaint_Location_County__c,
                                            Complaint_Location_State__c,
                                            Complaint_Location_Zip_Code__c,
                                            Complaint_Location__Latitude__s,
                                            Complaint_Location__Longitude__s,
                                            Location_Description__c,
                                            Responsible_Party_City__c,
                                            Responsible_Party_Company__c,
                                            Responsible_Party_Name__c,
                                            Responsible_Party_Phone__c,
                                            Responsible_Party_State__c,
                                            Responsible_Party_Street__c,
                                            Responsible_Party_Zip_Code__c,
                                            Description__c,
                                            Number_of_BDOs__c,
                                            Air__c,
                                            Vehicle_or_Stationary__c,
                                            Air_Complaint_Source_Info__c,
                                            Solid_Waste__c,
                                            Bottles_Cans_Recycling__c,
                                            Additional_Solid_Waste_Checkbox__c,
                                            Waste_Tires__c,
                                            Pesticides__c,
                                            Nature_of_Pesticides_Report__c,
                                            Reported_to_CAC__c,
                                            Toxic_Substances__c,
                                            Sensitive_Location__c,
                                            How_did_you_become_aware_of_incident__c,
                                            Toxics_Other_Location__c,
                                            Relationship_to_Responsible_Party__c,
                                            Other_Relationship__c,
                                            Water__c,
                                            Drinking_Water__c,
                                            Water_Cannabis_Marijuana__c,
                                            Water_Quality__c,
                                            Water_Rights__c,
                                            Watershed__c,
                                            Name_of_Affected_Water_Source__c,
                                            Water_Right_Number__c,
                                            Water_Rights_Owner__c,
                                            Water_Rights_Description__c,
                                            Other_Water_Related_Concerns__c
                                            from Complaints__c WHERE Id =: complaintId];
        viewModel.ComplaintNumber  =   complaint.Name;
        if(complaint.Date_and_Time_of_Occurrence__c != null)
        {
            viewModel.DateAndTimeOfOccurrence  =  complaint.Date_and_Time_of_Occurrence__c.format('MM/dd/yyyy hh:mma', 'America/Los_Angeles');
        }
        viewModel.OnGoingOccurrence  = GetYesNo(complaint.On_going_Occurrence__c);

        viewModel.Spill  = GetYesNo(complaint.Spill__c);
        viewModel.Refinery  = GetYesNo(complaint.Refinery__c);
    
        viewModel.TribalComplaint  =  GetYesNo(complaint.Tribal_Complaint__c);
        viewModel.EJComplaint  =  GetYesNo(complaint.EJ_Complaint__c);

        viewModel.ReferredToCalEPA = complaint.Referring_Agency__c != null && complaint.Referring_Agency__c != '';
        viewModel.ReferringAgency  = complaint.Referring_Agency__c; 
        viewModel.ReferringName  = complaint.Referring_Name__c;
        viewModel.ReferringEmailAddress  = complaint.Referring_Email_Address__c;
        
        viewModel.HasPreviousOrganizations = complaint.Previous_Organizations__c != null && complaint.Previous_Organizations__c != '';
        viewModel.PreviousOrganizations = complaint.Previous_Organizations__c;

        viewModel.IsAnonymous = complaint.Anonymous__c;
        if(viewModel.IsAnonymous)
        {
            viewModel.AnonymousSubmission = GetYesNo(complaint.Anonymous__c);
        }
        else
        {
            viewModel.ComplainantFirstName  =   complaint.Complainant__r.PersonContact.FirstName ;
            viewModel.ComplainantLastName  =   complaint.Complainant__r.PersonContact.LastName ;            
            viewModel.ComplainantStreet  =    complaint.Complainant__r.PersonContact.MailingStreet;
            viewModel.ComplainantCity  =    complaint.Complainant__r.PersonContact.MailingCity;
            viewModel.ComplainantState  =    complaint.Complainant__r.PersonContact.MailingState;
            viewModel.ComplainantZipCode  =    complaint.Complainant__r.PersonContact.MailingPostalCode;
            viewModel.ComplainantPhone  =   complaint.Complainant__r.PersonContact.HomePhone ;
            viewModel.ComplainantMobile  =   complaint.Complainant__r.PersonContact.MobilePhone;
            if(complaint.Complainant__r.PersonContact.HasOptedOutOfEmail)
            {
                viewModel.ComplainantEmail  =   'Complainant Opted Out of Email';
            }
            else
            {
                viewModel.ComplainantEmail  =  complaint.Complainant__r.PersonContact.Email;
            }        
        }
        
                                            
        viewModel.ComplaintLocationStreet  =    complaint.Complaint_Location_Address__c;
        viewModel.ComplaintLocationCity  =  complaint.Complaint_Location_City__c  ;
        viewModel.ComplaintLocationCounty  = complaint.Complaint_Location_County__c   ;
        viewModel.ComplaintLocationZipCode  =  complaint.Complaint_Location_Zip_Code__c  ;
        viewModel.ComplaintLocationState = complaint.Complaint_Location_State__c;
        viewModel.Latitude =  String.valueOf(complaint.Complaint_Location__Latitude__s);
        viewModel.Longitude =  String.valueOf(complaint.Complaint_Location__Longitude__s);
        viewModel.LocationDescription     =    complaint.Location_Description__c;
                                            
        viewModel.ResponsiblePartyName  =  complaint.Responsible_Party_Name__c  ;
        viewModel.ResponsiblePartyCompany  =  complaint.Responsible_Party_Company__c  ;
        viewModel.ResponsiblePartyPhone  =    complaint.Responsible_Party_Phone__c;
        viewModel.ResponsiblePartyAddress  =   complaint.Responsible_Party_Street__c ;
        viewModel.ResponsiblePartyCity  =   complaint.Responsible_Party_City__c ;
        viewModel.ResponsiblePartyState  =   complaint.Responsible_Party_State__c ;
        viewModel.ResponsiblePartyZipCode  =   complaint.Responsible_Party_Zip_Code__c ;        
        viewModel.ComplaintDescription  =  complaint.Description__c;
        
        if(complaint.Number_of_BDOs__c > 1)
        {
            viewModel.AreaOfConcernLabel = 'Areas of Concern';
        }
        else
        {
            viewModel.AreaOfConcernLabel = 'Area of Concern';
        }
        viewModel.IsAir =  complaint.Air__c;
        viewModel.VehicleOrStationary  =    complaint.Vehicle_or_Stationary__c;
        viewModel.AirComplaintSourceInfo  =    complaint.Air_Complaint_Source_Info__c;
        viewModel.IsSolidWasteCalRecycle  =  complaint.Solid_Waste__c ;
        viewModel.BottlesCansRecycling  =    GetYesNo(complaint.Bottles_Cans_Recycling__c);
        viewModel.AdditionalSolidWaste  =    GetYesNo(complaint.Additional_Solid_Waste_Checkbox__c);
        viewModel.WasteTires  =    GetYesNo(complaint.Waste_Tires__c);
        viewModel.IsPesticides  =   complaint.Pesticides__c;
        viewModel.NatureOfPesticidesReport  =    complaint.Nature_of_Pesticides_Report__c;
        viewModel.ReportedToCAC  =    complaint.Reported_to_CAC__c;
        viewModel.IsToxicSubstances = complaint.Toxic_Substances__c;
        viewModel.SensitiveLocation  =   complaint.Sensitive_Location__c == 'Other' ? complaint.Toxics_Other_Location__c : complaint.Sensitive_Location__c;
        viewModel.HowDidYouBecomeAwareOfTheIncident  =   complaint.How_did_you_become_aware_of_incident__c;
        viewModel.RelationshipToResponsibleParty  =  complaint.Relationship_to_Responsible_Party__c == 'Other' ?  complaint.Other_Relationship__c : complaint.Relationship_to_Responsible_Party__c;
        viewModel.IsWater  =    complaint.Water__c;
        viewModel.DrinkingWater  =    GetYesNo(complaint.Drinking_Water__c);
        viewModel.WaterCannabisMarijuana  =    GetYesNo(complaint.Water_Cannabis_Marijuana__c);
        viewModel.WaterQuality  =    GetYesNo(complaint.Water_Quality__c);
        viewModel.IsWaterRights  =    complaint.Water_Rights__c;
        viewModel.WaterRights  =    GetYesNo(complaint.Water_Rights__c);
        viewModel.Watershed  =    complaint.Watershed__c;
        viewModel.NameOfAffectedWaterSource  =    complaint.Name_of_Affected_Water_Source__c;
        viewModel.WaterRightsNumber  =    complaint.Water_Right_Number__c;
        viewModel.WaterRightsOwner  =    complaint.Water_Rights_Owner__c;
        viewModel.WaterRightsDescription  =    complaint.Water_Rights_Description__c;
        viewModel.OtherWaterRelatedConcerns  =    GetYesNo(complaint.Other_Water_Related_Concerns__c);
        List<Attachment> attachments = [SELECT Id, Name, BodyLength, ContentType FROM Attachment WHERE ParentID =: complaint.Id];
        viewModel.Attachments = attachments;
        List<Referral__c> referrals = [SELECT Id, External_Partner__r.Name, CreatedDate, CreatedBy.BDO__c FROM Referral__c WHERE Complaint__c =: complaint.Id];
        viewModel.Referrals = referrals;
        ComplaintDetailsViewModel = viewModel;
        return null;
    }

    private string GetYesNo(boolean val)
    {
        if(val)
        {
            return 'Yes';
        }
        return 'No';
    }
}