public class ComplaintManager
{
    public ICallout2 CllOut { get; set; }
    
    public ComplaintManager(ICallout2 c)
    {
        CllOut = c;
    }
    
    @future(callout=true)
    public static void StandardizeAddress(Set<id> complaintIds, boolean updateContact, string region)
    {       
        IGeoLocationManager2 glm = null;
        CalEnviroScreen3Manager ces3m = null;
        RegionalBoardManager rbm = null;
        
        if(Test.isRunningTest())
        {
            glm = new MockGeoLocationManager2();
            ces3m = new CalEnviroScreen3Manager();
            rbm = new RegionalBoardManager();
        }
        else
        {
            ICallout2 callout = new Callout2();
            glm = new GeoLocationManager2(callout);
            ces3m = new CalEnviroScreen3Manager(callout);
            rbm = new RegionalBoardManager(callout);
        }        
        List<Complaints__c> complaints = [SELECT Id
                                                  , Complaint_Location_Address__c
                                                  , Complaint_Location_City__c
                                                  , Complaint_Location_State__c
                                                  , Complaint_Location_Zip_Code__c
                                                  , Complaint_Location_County__c
                                                  , Complaint_Location__Latitude__s
                                                  , Complaint_Location__Longitude__s
                                                  , Regional_Water_Board__c
                                                  , Water_Rights__c
                                                  , Drinking_Water__c
                                                  , Water_Quality__c
                                                  ,  Water__c
                                                  , Toxic_Substances__c
                                                  FROM Complaints__c WHERE Id in: complaintIds FOR UPDATE];
        List<QueueSobject> queues = [SELECT Id, QueueId FROM QueueSobject WHERE SobjectType = 'Complaints__c'];
        Set<Id> qIds = new Set<Id>();
        for(QueueSobject qs: queues)
        {           
            qIds.add(qs.QueueId);
        }
        
        List<Group> groups = [SELECT Id, Type, Name FROM Group WHERE Type = 'Queue' AND Id in: qIds ];
        
                                                           
        for(Complaints__c complaint : complaints)
        {            
            GeoLocation2 geoLocation = new GeoLocation2();  
            if((complaint.Complaint_Location_City__c != null || complaint.Complaint_Location_Zip_Code__c != null))
            {
                geoLocation.StreetAddress = complaint.Complaint_Location_Address__c;
                geoLocation.City = complaint.Complaint_Location_City__c;
                geoLocation.State = complaint.Complaint_Location_State__c;
                geoLocation.ZipCode = complaint.Complaint_Location_Zip_Code__c;

                geoLocation = glm.StandardizeAddress(geoLocation);
        
                if(geoLocation.City != null && geoLocation.City != '')
                {
                    complaint.Complaint_Location_Address__c = geoLocation.StreetAddress;
                    complaint.Complaint_Location_City__c = geoLocation.City;
                    complaint.Complaint_Location_State__c = geoLocation.State;            
                    complaint.Complaint_Location_Zip_Code__c = geoLocation.ZipCode;
                    complaint.Complaint_Location_County__c = geoLocation.County;
                    complaint.Complaint_Location__Latitude__s = geoLocation.Latitude;
                    complaint.Complaint_Location__Longitude__s = geoLocation.Longitude;
                    if(geoLocation.Latitude != null && geoLocation.Longitude != null)
                    {                    
                        CalEnviroScreen3Manager.CalEnviroScreen3Result calEnviroScreen3Result = ces3m.GetCalEnvroScreen3Result(geoLocation.Latitude, geoLocation.Longitude);
                        if(calEnviroScreen3Result != null)
                        {
                            if(calEnviroScreen3Result.Features != null)
                            {
                                if(calEnviroScreen3Result.Features.Size() > 0)
                                {
                                    if(calEnviroScreen3Result.Features[0].Attributes != null)
                                {
                                    complaint.Census_Tract_Number__c = calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_tract;
                                    complaint.CalEnviroScreen_Score__c = calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_CIscore;
                                    complaint.CalEnviroScreen_Score_Percentile_Rank__c =   String.valueOf(calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_PCTLrange);
                                    if(calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_CIscoreP> 75)
                                    {
                                        complaint.EJ_Complaint__c = true;
                                    }
                                }
                                }
                            }
                        }
                        string regionalBoard = rbm.GetRegionalBoard(geoLocation);            
                        complaint.Regional_Water_Board__c =  regionalBoard;
                        if(complaint.Water__c)
                        {
                            LaunchSetWaterContactAndNotifyFlow(complaint.Id,complaint.Regional_Water_Board__c);
                        }
                    }
                    if(complaint.Toxic_Substances__c)
                    {
                        LaunchUpdateToxicsRegionFlow(complaint.Id, complaint.Complaint_Location_County__c);
                    }            
                }
                else
                {
                    //Just in case the Geocoding didn't work.
                    if(complaint.Water__c)
                    {
                        LaunchSetWaterContactAndNotifyFlow(complaint.Id,null);
                    }
                    if(complaint.Toxic_Substances__c)
                    {
                        LaunchUpdateToxicsRegionFlow(complaint.Id, complaint.Complaint_Location_County__c);
                    }  
                }  
            }            
            TriggerHandler.bypass('ComplaintTriggerHandler');            
            update complaint;
            TriggerHandler.clearBypass('ComplaintTriggerHandler');                        
        }
    }
    
    public static void CreateToxicsAndWaterAssignments(Set<id> complaintIds)
    {
         List<Complaints__c> complaints = [SELECT Id, Complaint_Location_County__c, Regional_Water_Board__c, Water_Rights__c, Drinking_Water__c,  Water__c, Toxic_Substances__c FROM Complaints__c WHERE Id in: complaintIds FOR UPDATE];

        for(Complaints__c complaint : complaints)
        {
            if(complaint.Toxic_Substances__c)
            {
                LaunchUpdateToxicsRegionFlow(complaint.Id, complaint.Complaint_Location_County__c);
            }
            if(complaint.Water__c)
            {
                LaunchSetWaterContactAndNotifyFlow(complaint.Id,null);
            }
        } 
    }
    
    @future(callout=true)
    public static void CreateComplaintPDF(Set<id> complaintIds)
    {
        for(Id complaintId : complaintIds)
        {
            string complaintPDFUrl = OrgURLHelper.GetSiteUrl('ExternalPartnerPortal');
            complaintPdfUrl = complaintPdfUrl + 'complaintpdf?id=';
            complaintPdfUrl = complaintPdfUrl + complaintId;            
            PageReference pdf = new PageReference(complaintPdfUrl);
            system.debug('pdf:  ' + pdf.getUrl());
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.Title = 'ComplaintOriginalSubmission';
            contentVersion.PathOnClient = 'ComplaintOriginalSubmission.pdf';
            if(!Test.isRunningTest())
            {
                contentVersion.VersionData = pdf.getContentAsPDF();
            }
            else
            {
                Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
                contentVersion.VersionData=bodyBlob;
            }
            contentVersion.IsMajorVersion = true;
            insert contentVersion;
            contentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id LIMIT 1];
            ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
            contentDocumentLink.ContentDocumentId = contentVersion.ContentDocumentId;
            contentDocumentLink.LinkedEntityId = complaintId;
            contentDocumentLink.ShareType = 'I';
            contentDocumentLink.Visibility = 'AllUsers';
            insert contentDocumentLink;
        }
    }

    @TestVisible
    private static string LaunchUpdateToxicsRegionFlow(string complaintId, string complaintCounty)
    {
        system.debug('complaintId:  ' + complaintId);
        //Instance of the Flow
        Map<String, Object> myMap = new Map<String, Object>();
        myMap.put('ComplaintCounty', complaintCounty);
        myMap.put('ComplaintId', complaintId);
        Flow.Interview.Create_Toxic_Substances_Assignment myFlow = new Flow.Interview.Create_Toxic_Substances_Assignment(myMap);
        myFlow.start(); 
        string returnValue = (string)myFlow.getVariableValue('AssignmentId');
        system.debug('returnValue:  ' + returnValue);
        return returnValue;
    }
    
    @TestVisible
    private static void LaunchSetWaterContactAndNotifyFlow(string complaintId, string region)
    {
        //Instance of the Flow
        Map<String, Object> myMap = new Map<String, Object>();
        myMap.put('ComplaintId', complaintId);
        myMap.put('Region', region);
        Flow.Interview.Create_Water_Assignment myFlow = new Flow.Interview.Create_Water_Assignment(myMap);
        myFlow.start(); 
    }
}