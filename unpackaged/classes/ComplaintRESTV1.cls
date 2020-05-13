@RestResource(urlMapping='/Complaint/V1/*')
global with sharing class ComplaintRESTV1 
{
    /*
        @HttpDelete
        global static void doDelete() 
        {
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
            Account account = [SELECT Id FROM Account WHERE Id = :accountId];
            delete account;
        }
    */
    @HttpGet
    global static ComplaintV1 DoGet() 
    {
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String complaintId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Complaints__c> complaints = [SELECT Id, Name, Spill__c,Refinery__c,Description__c,Previous_Organizations__c,Complaint_Location_Address__c,Complaint_Location_City__c,Complaint_Location_State__c,Complaint_Location_Zip_Code__c,Location_Description__c,Responsible_Party_Name__c,Responsible_Party_Company__c,Responsible_Party_Street__c,Responsible_Party_City__c,Responsible_Party_State__c,Responsible_Party_Zip_Code__c,Air__c,Air_Complaint_Source_Info__c,Complaint_Source__c,Water__c,Water_Cannabis_Marijuana__c,Drinking_Water__c,Water_Quality__c,Other_Water_Related_Concerns__c,Name_of_Affected_Water_Source__c,Watershed__c,Complaint_Location_Parcel_Number__c,Water_Rights__c,Water_Rights_Owner__c,Water_Rights_Description__c,Water_Right_Number__c,Toxic_Substances__c,How_did_you_become_aware_of_incident__c,Sensitive_Location__c,Toxics_Other_Location__c,Relationship_to_Responsible_Party__c,Other_Relationship__c,Pesticides__c,Nature_of_Pesticides_Report__c,Reported_to_CAC__c,Solid_Waste__c,Bottles_Cans_Recycling__c,Waste_Tires__c,Additional_Solid_Waste_Checkbox__c,Unknown_Date_of_Occurrence__c,Date_and_Time_of_Occurrence__c,On_going_Occurrence__c,Anonymous__c,complainant__r.Language__pc,complainant__r.FirstName,complainant__r.LastName,complainant__r.PersonMailingStreet,complainant__r.PersonMailingCity,complainant__r.PersonMailingState,complainant__r.PersonMailingPostalCode,complainant__r.PersonHomePhone,complainant__r.PersonMobilePhone,complainant__r.PersonEmail,complainant__r.PersonHasOptedOutOfEmail FROM Complaints__c WHERE Id=:complaintId];
        if(complaints.Size() == 1)
        {
            res.statusCode = 201;
            ComplaintV1 result = ConvertToComplaintV1(complaints[0]);
            return result;
        }
        else
        {
            res.statusCode = 404;
            return null;
        }
    }
  
    @HttpPost
    global static void DoPost() 
    {
        ComplaintV1 complaintV1 = ParseJSON(RestContext.request.requestBody.toString());
        try 
        {
            ValidateComplaintV1(complaintV1);            
            Complaints__c complaint = ConvertToComplaint(complaintV1);
            if(!complaint.Anonymous__c)
            {
                List<Account> accounts = [SELECT Id FROM Account WHERE PersonEmail =: complaintV1.ComplainantEmail];
                if(accounts.size() > 0)
                {
                    Account complainant = accounts[0];
                    complainant.Language__pc  = complaintV1.Language;
                    complainant.FirstName  = complaintV1.ComplainantFirstName;
                    complainant.LastName = complaintV1.ComplainantLastName;
                    complainant.PersonMailingStreet  = complaintV1.ComplainantStreetAddress;
                    complainant.PersonMailingCity  = complaintV1.ComplainantCity;
                    complainant.PersonMailingState  = complaintV1.ComplainantState;
                    complainant.PersonMailingPostalCode  = complaintV1.ComplainantZipCode;
                    complainant.PersonHomePhone  = complaintV1.ComplainantHomePhone;
                    complainant.PersonMobilePhone  = complaintV1.ComplainantMobilePhone;
                    complainant.PersonEmail  = complaintV1.ComplainantEmail;
                    complainant.PersonHasOptedOutOfEmail  = complaintV1.IsComplainantEmailOptOut;
                    update complainant;
                    complaint.Complainant__c = complainant.Id;
                }
                else 
                {
                    RecordType complainantRecordType = [SELECT Id FROM RecordType WHERE SobjectType='Account' AND Name='Complainant'];
                    Account complainant = new Account();
                    complainant.RecordTypeId = complainantRecordType.Id;
                    complainant.Language__pc = complaintV1.Language;
                    complainant.FirstName  = complaintV1.ComplainantFirstName;
                    complainant.LastName = complaintV1.ComplainantLastName;
                    complainant.PersonMailingStreet  = complaintV1.ComplainantStreetAddress;
                    complainant.PersonMailingCity  = complaintV1.ComplainantCity;
                    complainant.PersonMailingState  = complaintV1.ComplainantState;
                    complainant.PersonMailingPostalCode  = complaintV1.ComplainantZipCode;
                    complainant.PersonHomePhone  = complaintV1.ComplainantHomePhone;
                    complainant.PersonMobilePhone  = complaintV1.ComplainantMobilePhone;
                    complainant.PersonEmail  = complaintV1.ComplainantEmail;
                    complainant.PersonHasOptedOutOfEmail  = complaintV1.IsComplainantEmailOptOut;
                    insert complainant;
                    complaint.Complainant__c = complainant.Id;
                }
            }
            insert complaint;
            RestResponse res = RestContext.response; 
            ComplaintV1Response response = new ComplaintV1Response();
            response.Id = complaint.Id;
            response.Status = 'Success';
            response.Message = null;
            res.responseBody = Blob.valueOf(JSON.serialize(response));
            res.statusCode = 201;
        } 
        catch(Exception e) 
        { 
            RestResponse res = RestContext.response; 
            ComplaintV1Response response = new ComplaintV1Response();
            response.Id = null;
            response.Status = 'Failure';
            response.Message =  e.getMessage()  + ' ' + e.getLineNumber(); 
            res.responseBody = Blob.valueOf(JSON.serialize(response));
            res.statusCode = 400;
        }
    }
    
    private static void ValidateComplaintV1(ComplaintV1 complaintV1)
    {
        if(string.IsBlank(complaintV1.Description))
        {
            throw new ApplicationException('Description is Required');
        }
        if(!complaintV1.IsAnonymous)
        {
            if(string.IsBlank(complaintV1.ComplainantLastName))
            {
                throw new ApplicationException('Complainant Last Name is Required');
            }
        }
    }

    private static Complaints__c ConvertToComplaint(ComplaintV1 complaintV1)
    {
        Complaints__c complaint = new Complaints__c();
        complaint.Spill__c = complaintV1.IsSpill;
        complaint.Refinery__c = complaintV1.IsRefinery;
        complaint.Description__c = complaintV1.Description;
        complaint.Previous_Organizations__c = complaintV1.PreviousOrganizations;
        complaint.Complaint_Location_Address__c = complaintV1.ComplaintLocationStreetAddress;
        complaint.Complaint_Location_City__c = complaintV1.ComplaintLocationCity;
        complaint.Complaint_Location_State__c = complaintV1.ComplaintLocationState;
        complaint.Complaint_Location_Zip_Code__c = complaintV1.ComplaintLocationZipCode;
        complaint.Location_Description__c = complaintV1.ComplaintLocationDescription;
        complaint.Responsible_Party_Name__c = complaintV1.ResponsiblePartyName;
        complaint.Responsible_Party_Company__c = complaintV1.ResponsiblePartyCompany;
        complaint.Responsible_Party_Street__c = complaintV1.ResponsiblePartyStreetAddress;
        complaint.Responsible_Party_City__c = complaintV1.ResponsiblePartyCity;
        complaint.Responsible_Party_State__c = complaintV1.ResponsiblePartyState;
        complaint.Responsible_Party_Zip_Code__c = complaintV1.ResponsiblePartyZipCode;
        
        complaint.Air__c = complaintV1.IsAir;
        if(complaint.Air__c)
        {
            complaint.Air_Complaint_Source_Info__c = complaintV1.AirPollutionSourceVehicleOrStationary;
            complaint.Complaint_Source__c = complaintV1.AirPollutionSource;
        }
        
        complaint.Water__c = complaintV1.IsWater;
        if(complaint.Water__c)
        {
            complaint.Water_Cannabis_Marijuana__c = complaintV1.IsCannabisRelated;
            complaint.Drinking_Water__c = complaintV1.IsDrinkingWater;
            complaint.Water_Quality__c = complaintV1.IsWaterQuality;
            complaint.Other_Water_Related_Concerns__c = complaintV1.IsWaterOther;
            complaint.Name_of_Affected_Water_Source__c = complaintV1.AffectedWaterSource;
            complaint.Watershed__c = complaintV1.Watershed;
            complaint.Complaint_Location_Parcel_Number__c = complaintV1.ParcelNumber;
            complaint.Water_Rights__c = complaintV1.IsWaterRights;
            if(complaint.Water_Rights__c)
            {
                complaint.Water_Rights_Owner__c = complaintV1.WaterRightsOwner;
                complaint.Water_Rights_Description__c = complaintV1.WaterRightsDescription;
                complaint.Water_Right_Number__c = complaintV1.WaterRightsNumber;
            }
        }
        
        complaint.Toxic_Substances__c = complaintV1.IsToxicSubstances;
        if(complaint.Toxic_Substances__c)
        {
            complaint.How_did_you_become_aware_of_incident__c = complaintV1.HowDidYouBecomeAwareOfTheIncident;
            complaint.Sensitive_Location__c = complaintV1.SensitiveLocation;
            if(complaint.Sensitive_Location__c == 'Other')
            {
                complaint.Toxics_Other_Location__c = complaintV1.OtherSensitiveLocation;
            }
            complaint.Relationship_to_Responsible_Party__c = complaintV1.RelationshipToResponsibleParty;
            if(complaint.Relationship_to_Responsible_Party__c =='Other')
            {
                complaint.Other_Relationship__c = complaintV1.OtherRelationshipToResponsibleParty;
            }
        }
        complaint.Pesticides__c = complaintV1.IsPesticides;
        if(complaint.Pesticides__c)
        {
            complaint.Nature_of_Pesticides_Report__c = complaintV1.NatureOfPesticidesReport;
            complaint.Reported_to_CAC__c = complaintV1.AgriculturalCommissionerContacted;
        }
                
        complaint.Solid_Waste__c = complaintV1.IsSolidWaste;
        if(complaint.Solid_Waste__c)
        {
            complaint.Bottles_Cans_Recycling__c = complaintV1.IsBottlesAndCansRelated;
            complaint.Waste_Tires__c = complaintV1.IsWasteTireRelated;
            complaint.Additional_Solid_Waste_Checkbox__c = complaintV1.IsOtherSolidWaste;
        }
        
        
        complaint.Unknown_Date_of_Occurrence__c = complaintV1.Timeframe;
        if(complaint.Unknown_Date_of_Occurrence__c == 'Exact Date')
        {
           complaint.Date_and_Time_of_Occurrence__c = complaintV1.DateAndTimeOfOccurrence;
        }
        complaint.On_going_Occurrence__c = complaintV1.IsOngoingOccurrence;
        
        
        complaint.Anonymous__c = complaintV1.IsAnonymous;
        complaint.Complaint_Source__c = 'API';
        
        Id runningUserId = UserInfo.getUserId();
        User user = [SELECT Id, AccountId FROM User WHERE Id=:runningUserId];
        complaint.Referring_Account__c = user.AccountId;
        return complaint;
    }

    private static ComplaintV1 ConvertToComplaintV1(Complaints__c complaint)
    {
        ComplaintV1 complaintV1 = new ComplaintV1();
        complaintV1.Id=complaint.Id;
        complaintV1.IsSpill=complaint.Spill__c;
        complaintV1.IsRefinery=complaint.Refinery__c;
        complaintV1.Description=complaint.Description__c;
        complaintV1.PreviousOrganizations=complaint.Previous_Organizations__c;
        complaintV1.ComplaintLocationStreetAddress=complaint.Complaint_Location_Address__c;
        complaintV1.ComplaintLocationCity=complaint.Complaint_Location_City__c;
        complaintV1.ComplaintLocationState=complaint.Complaint_Location_State__c;
        complaintV1.ComplaintLocationZipCode=complaint.Complaint_Location_Zip_Code__c;
        complaintV1.ComplaintLocationDescription=complaint.Location_Description__c;
        complaintV1.ResponsiblePartyName=complaint.Responsible_Party_Name__c;
        complaintV1.ResponsiblePartyCompany=complaint.Responsible_Party_Company__c;
        complaintV1.ResponsiblePartyStreetAddress=complaint.Responsible_Party_Street__c;
        complaintV1.ResponsiblePartyCity=complaint.Responsible_Party_City__c;
        complaintV1.ResponsiblePartyState=complaint.Responsible_Party_State__c;
        complaintV1.ResponsiblePartyZipCode=complaint.Responsible_Party_Zip_Code__c;
        complaintV1.IsAir=complaint.Air__c;
        complaintV1.AirPollutionSourceVehicleOrStationary=complaint.Air_Complaint_Source_Info__c;
        complaintV1.AirPollutionSource=complaint.Complaint_Source__c;
        complaintV1.IsWater=complaint.Water__c;
        complaintV1.IsCannabisRelated=complaint.Water_Cannabis_Marijuana__c;
        complaintV1.IsDrinkingWater=complaint.Drinking_Water__c;
        complaintV1.IsWaterQuality        =complaint.Water_Quality__c;
        complaintV1.IsWaterOther=complaint.Other_Water_Related_Concerns__c;
        complaintV1.AffectedWaterSource=complaint.Name_of_Affected_Water_Source__c;
        complaintV1.Watershed=complaint.Watershed__c;
        complaintV1.ParcelNumber=complaint.Complaint_Location_Parcel_Number__c;
        complaintV1.IsWaterRights=complaint.Water_Rights__c;
        complaintV1.WaterRightsOwner=complaint.Water_Rights_Owner__c;
        complaintV1.WaterRightsDescription=complaint.Water_Rights_Description__c;
        complaintV1.WaterRightsNumber=complaint.Water_Right_Number__c;
        complaintV1.IsToxicSubstances=complaint.Toxic_Substances__c;
        complaintV1.HowDidYouBecomeAwareOfTheIncident=complaint.How_did_you_become_aware_of_incident__c;
        complaintV1.SensitiveLocation=complaint.Sensitive_Location__c;
        complaintV1.OtherSensitiveLocation=complaint.Toxics_Other_Location__c;
        complaintV1.RelationshipToResponsibleParty=complaint.Relationship_to_Responsible_Party__c;
        complaintV1.OtherRelationshipToResponsibleParty=complaint.Other_Relationship__c;
        complaintV1.IsPesticides=complaint.Pesticides__c;
        complaintV1.NatureOfPesticidesReport=complaint.Nature_of_Pesticides_Report__c;
        complaintV1.AgriculturalCommissionerContacted=complaint.Reported_to_CAC__c;
        complaintV1.IsSolidWaste=complaint.Solid_Waste__c;
        complaintV1.IsBottlesAndCansRelated=complaint.Bottles_Cans_Recycling__c;
        complaintV1.IsWasteTireRelated=complaint.Waste_Tires__c;
        complaintV1.IsOtherSolidWaste=complaint.Additional_Solid_Waste_Checkbox__c;
        complaintV1.Timeframe=complaint.Unknown_Date_of_Occurrence__c;
        if(complaint.Date_and_Time_of_Occurrence__c != null)
        {
            complaintV1.DateAndTimeOfOccurrence= complaint.Date_and_Time_of_Occurrence__c;
        }
        
        
        complaintV1.IsOngoingOccurrence=complaint.On_going_Occurrence__c;
        complaintV1.IsAnonymous=complaint.Anonymous__c;
        complaintV1.Language=complaint.complainant__r.Language__pc;
        complaintV1.ComplainantFirstName=complaint.complainant__r.FirstName;
        complaintV1.ComplainantLastName=complaint.complainant__r.LastName;
        complaintV1.ComplainantStreetAddress=complaint.complainant__r.PersonMailingStreet;
        complaintV1.ComplainantCity=complaint.complainant__r.PersonMailingCity;
        complaintV1.ComplainantState=complaint.complainant__r.PersonMailingState;
        complaintV1.ComplainantZipCode=complaint.complainant__r.PersonMailingPostalCode;
        complaintV1.ComplainantHomePhone=complaint.complainant__r.PersonHomePhone;
        complaintV1.ComplainantMobilePhone=complaint.complainant__r.PersonMobilePhone;
        complaintV1.ComplainantEmail=complaint.complainant__r.PersonEmail;
        complaintV1.IsComplainantEmailOptOut=complaint.complainant__r.PersonHasOptedOutOfEmail;
        return complaintV1;
    }

    private static ComplaintV1 ParseJSON(string jsonString)
    {
        ComplaintV1 complaintV1 = new ComplaintV1();
        JSONParser parser = JSON.createParser(jsonString);
        while(parser.nextToken()!= null) 
        {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME) 
            {
                parser.nextValue();
                switch on parser.getCurrentName() 
                {
                    when 'Id' { complaintv1.Id= parser.getText(); }
                    when 'Name' { complaintv1.Name= parser.getText(); }
                    when 'Language' { complaintv1.Language= parser.getText(); }
                    when 'IsAir' { complaintv1.IsAir= parser.getBooleanValue(); }
                    when 'IsWater' { complaintv1.IsWater= parser.getBooleanValue(); }
                    when 'IsToxicSubstances' { complaintv1.IsToxicSubstances= parser.getBooleanValue(); }
                    when 'IsPesticides' { complaintv1.IsPesticides= parser.getBooleanValue(); }
                    when 'IsSolidWaste' { complaintv1.IsSolidWaste= parser.getBooleanValue(); }
                    when 'IsSpill' { complaintv1.IsSpill= parser.getBooleanValue(); }
                    when 'IsRefinery' { complaintv1.IsRefinery= parser.getBooleanValue(); }
                    when 'Description' { complaintv1.Description= parser.getText(); }
                    when 'PreviousOrganizations' { complaintv1.PreviousOrganizations= parser.getText(); }
                    when 'ComplaintLocationStreetAddress' { complaintv1.ComplaintLocationStreetAddress= parser.getText(); }
                    when 'ComplaintLocationCity' { complaintv1.ComplaintLocationCity= parser.getText(); }
                    when 'ComplaintLocationState' { complaintv1.ComplaintLocationState= parser.getText(); }
                    when 'ComplaintLocationZipCode' { complaintv1.ComplaintLocationZipCode= parser.getText(); }
                    when 'ComplaintLocationDescription' { complaintv1.ComplaintLocationDescription= parser.getText(); }
                    when 'ResponsiblePartyName' { complaintv1.ResponsiblePartyName= parser.getText(); }
                    when 'ResponsiblePartyCompany' { complaintv1.ResponsiblePartyCompany= parser.getText(); }
                    when 'ResponsiblePartyStreetAddress' { complaintv1.ResponsiblePartyStreetAddress= parser.getText(); }
                    when 'ResponsiblePartyCity' { complaintv1.ResponsiblePartyCity= parser.getText(); }
                    when 'ResponsiblePartyState' { complaintv1.ResponsiblePartyState= parser.getText(); }
                    when 'ResponsiblePartyZipCode' { complaintv1.ResponsiblePartyZipCode= parser.getText(); }
                    when 'AirPollutionSourceVehicleOrStationary' { complaintv1.AirPollutionSourceVehicleOrStationary= parser.getText(); }
                    when 'AirPollutionSource' { complaintv1.AirPollutionSource= parser.getText(); }
                    when 'IsCannabisRelated' { complaintv1.IsCannabisRelated= parser.getBooleanValue(); }
                    when 'IsDrinkingWater' { complaintv1.IsDrinkingWater= parser.getBooleanValue(); }
                    when 'IsWaterQuality' { complaintv1.IsWaterQuality= parser.getBooleanValue(); }
                    when 'IsWaterRights' { complaintv1.IsWaterRights= parser.getBooleanValue(); }
                    when 'WaterRightsOwner' { complaintv1.WaterRightsOwner= parser.getText(); }
                    when 'WaterRightsDescription' { complaintv1.WaterRightsDescription= parser.getText(); }
                    when 'WaterRightsNumber' { complaintv1.WaterRightsNumber= parser.getText(); }
                    when 'IsWaterOther' { complaintv1.IsWaterOther= parser.getBooleanValue(); }
                    when 'AffectedWaterSource' { complaintv1.AffectedWaterSource= parser.getText(); }
                    when 'Watershed' { complaintv1.Watershed= parser.getText(); }
                    when 'ParcelNumber' { complaintv1.ParcelNumber= parser.getText(); }
                    when 'HowDidYouBecomeAwareOfTheIncident' { complaintv1.HowDidYouBecomeAwareOfTheIncident= parser.getText(); }
                    when 'SensitiveLocation' { complaintv1.SensitiveLocation= parser.getText(); }
                    when 'OtherSensitiveLocation' { complaintv1.OtherSensitiveLocation= parser.getText(); }
                    when 'RelationshipToResponsibleParty' { complaintv1.RelationshipToResponsibleParty= parser.getText(); }
                    when 'OtherRelationshipToResponsibleParty' { complaintv1.OtherRelationshipToResponsibleParty= parser.getText(); }
                    when 'NatureOfPesticidesReport' { complaintv1.NatureOfPesticidesReport= parser.getText(); }
                    when 'AgriculturalCommissionerContacted' { complaintv1.AgriculturalCommissionerContacted= parser.getText(); }
                    when 'IsBottlesAndCansRelated' { complaintv1.IsBottlesAndCansRelated= parser.getBooleanValue(); }
                    when 'IsWasteTireRelated' { complaintv1.IsWasteTireRelated= parser.getBooleanValue(); }
                    when 'IsOtherSolidWaste' { complaintv1.IsOtherSolidWaste= parser.getBooleanValue(); }
                    when 'Timeframe' { complaintv1.Timeframe= parser.getText(); }
                    when 'DateAndTimeOfOccurrence' { complaintv1.DateAndTimeOfOccurrence= parser.getDatetimeValue(); }
                    when 'IsOngoingOccurrence' { complaintv1.IsOngoingOccurrence= parser.getBooleanValue(); }
                    when 'IsAnonymous' { complaintv1.IsAnonymous= parser.getBooleanValue(); }
                    when 'ComplainantFirstName' { complaintv1.ComplainantFirstName= parser.getText(); }
                    when 'ComplainantLastName' { complaintv1.ComplainantLastName= parser.getText(); }
                    when 'ComplainantStreetAddress' { complaintv1.ComplainantStreetAddress= parser.getText(); }
                    when 'ComplainantCity' { complaintv1.ComplainantCity= parser.getText(); }
                    when 'ComplainantState' { complaintv1.ComplainantState= parser.getText(); }
                    when 'ComplainantZipCode' { complaintv1.ComplainantZipCode= parser.getText(); }
                    when 'ComplainantHomePhone' { complaintv1.ComplainantHomePhone= parser.getText(); }
                    when 'ComplainantMobilePhone' { complaintv1.ComplainantMobilePhone= parser.getText(); }
                    when 'ComplainantEmail' { complaintv1.ComplainantEmail= parser.getText(); }
                    when 'IsComplainantEmailOptOut' { complaintv1.IsComplainantEmailOptOut= parser.getBooleanValue(); }
                }
            }
        }
        return complaintV1;
    }
}