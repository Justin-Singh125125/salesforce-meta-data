@IsTest(SeeAllData=true)
public class ComplaintRESTV1Tests 
{
    /*
    static testMethod void Test()
    {
        //Arrange        
        string expected = '';
        //Act
        Test.startTest();
        Test.stopTest();
        string actual = '';

        //Assert
        System.assertEquals(expected, actual);                          
    }
    */

    //Get Complaint Exists 
    static testMethod void TestGetWhenComplaintExists()
    {
        //Arrange        
        Complaints__c complaint = UnitTestHelper.CreateTestComplaint();
        string expected = complaint.Id;
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/DemoUrl/' + complaint.Id;  //Request URL
        req.httpMethod = 'Get';//HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        //Act
        Test.startTest();
        ComplaintV1 actualResult = ComplaintRESTV1.DoGet();
        Test.stopTest();
        string actual = actualResult.Id;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    //Get Complaint Doesn't Exist 
    static testMethod void TestGetWhenComplaintDoesNotExist()
    {
        //Arrange         
        string fakeId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);       
        integer expected = 404;
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/DemoUrl/' + fakeId;  //Request URL
        req.httpMethod = 'Get';//HTTP Request Type
        RestContext.request = req;
        RestContext.response= res;
        //Act
        Test.startTest();
        ComplaintV1 actualResult = ComplaintRESTV1.DoGet();
        System.Debug('res:  ' + res);
        Test.stopTest();
        integer actual = res.StatusCode;

        //Assert
        System.assertEquals(expected, actual);                           
    }
    
    //Post

    static testMethod void TestPost()
    {
        //Arrange        
        integer expected = 201;
        ComplaintV1 cv1 = new ComplaintV1();
        cv1.Language = 'English';
        cv1.IsAir = true;
        cv1.IsWater  = true;
        cv1.IsToxicSubstances  = true;
        cv1.IsPesticides  = true;
        cv1.IsSolidWaste  = true;
        cv1.IsSpill  = true;
        cv1.IsRefinery  = true;
        cv1.Description = 'Lorem Ipsum';
        cv1.PreviousOrganizations = 'Lorem Ipsum'; 
        cv1.ComplaintLocationStreetAddress = '1315 10th St';
        cv1.ComplaintLocationCity = 'Sacramento';
        cv1.ComplaintLocationState = 'California';
        cv1.ComplaintLocationZipCode = '95814';
        cv1.ComplaintLocationDescription = 'State Capitol Building';
        cv1.ResponsiblePartyName  = 'Lorem Ipsum';
        cv1.ResponsiblePartyCompany  = 'Lorem Ipsum Inc.';
        cv1.ResponsiblePartyStreetAddress = '123 Lorem Ipsum';
        cv1.ResponsiblePartyCity  = 'Lorem';
        cv1.ResponsiblePartyState  = 'California';
        cv1.ResponsiblePartyZipCode ='90210';
        cv1.AirPollutionSourceVehicleOrStationary = 'Vehicle';
        cv1.AirPollutionSource = 'Truck';
        cv1.IsCannabisRelated  = true;
        cv1.IsDrinkingWater  = true;
        cv1.IsWaterQuality  = true;
        cv1.IsWaterRights  = true;
        cv1.WaterRightsOwner  = 'Lorem Ipsum';
        cv1.WaterRightsDescription  = 'Lorem Ipsum';
        cv1.WaterRightsNumber  = '12345';
        cv1.IsWaterOther  = true;
        cv1.AffectedWaterSource  = 'Lorem Ipsum';
        cv1.Watershed  = 'Lorem Ipsum';
        cv1.ParcelNumber  = '54321';
        cv1.HowDidYouBecomeAwareOfTheIncident  = 'Lorem Ipsum';
        cv1.SensitiveLocation = 'Other';
        cv1.OtherSensitiveLocation = 'Public Place';
        cv1.RelationshipToResponsibleParty = 'Other';
        cv1.OtherRelationshipToResponsibleParty = 'Secret Admirer';
        cv1.NatureOfPesticidesReport = 'Pesticide Misuse';
        cv1.AgriculturalCommissionerContacted = 'Yes';
        cv1.IsBottlesAndCansRelated  = true;
        cv1.IsWasteTireRelated  = true;
        cv1.IsOtherSolidWaste  = true;
        cv1.Timeframe = 'Exact Date';
        cv1.DateAndTimeOfOccurrence = Datetime.newInstance(2019, 1, 1);
        cv1.IsOngoingOccurrence  = true;
        cv1.IsAnonymous = false;
        cv1.ComplainantFirstName = 'Lorem';
        cv1.ComplainantLastName = 'Ipsum';
        cv1.ComplainantStreetAddress = '1001 I Street';
        cv1.ComplainantCity = 'Sacramento';
        cv1.ComplainantState = 'California';
        cv1.ComplainantZipCode = '95814';
        cv1.ComplainantHomePhone = '9165551212';
        cv1.ComplainantMobilePhone = '9165551212';
        cv1.ComplainantEmail = 'test@test.com';
        cv1.IsComplainantEmailOptOut  = true;
        string jsonBody=JSON.serialize(cv1);
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/DemoUrl';  //Request URL
        req.httpMethod = 'POST';//HTTP Request Type
        req.requestBody = Blob.valueof(jsonBody);
        RestContext.request = req;
        RestContext.response= res;

        //Act
        Test.startTest();
        ComplaintRESTV1.DoPost();
        Test.stopTest();
        integer actual = res.StatusCode;

        //Assert
        System.assertEquals(expected, actual);                          
    }
}