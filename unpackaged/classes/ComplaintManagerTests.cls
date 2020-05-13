@isTest
public class ComplaintManagerTests
{
    static Integer s_num = 1;
    
    static testMethod void StandardizeAddress_InsufficientDataProvided_ExpectedNoChangeToStreet()
    {
        //Arrange        
        string expected = '987 Elm Street';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm Street');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               


        
        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_Address__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_Address__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void StandardizeAddress_InsufficientDataProvided_ExpectedNoChangeToState()
    {
        //Arrange        
        string expected = 'MyState';
        Complaints__c complaint = new Complaints__c(Complaint_Location_State__c = 'MyState');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               


        
        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_State__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_State__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void StandardizeAddress_SufficientDataProvided_ExpectedStreetAddress()
    {
        //Arrange        
        string expected = '1600 Pennsylvania Avenue';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               



        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_Address__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_Address__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }

    static testMethod void StandardizeAddress_SufficientDataProvided_ExpectedCity()
    {
        //Arrange        
        string expected = 'AnyTown';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               



        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_City__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_City__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }

    static testMethod void StandardizeAddress_SufficientDataProvided_ExpectedState()
    {
        //Arrange        
        string expected = 'Florida';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               



        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_State__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_State__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void StandardizeAddress_SufficientDataProvided_ExpectedZipCode()
    {
        //Arrange        
        string expected = '90210';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               



        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_Zip_Code__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_Zip_Code__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void StandardizeAddress_SufficientDataProvided_ExpectedCounty()
    {
        //Arrange        
        string expected = 'Madison County';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               



        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_County__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_County__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void StandardizeAddress_SufficientDataProvided_ExpectedCensusTract()
    {
        //Arrange        
        string expected = '6019001500';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        TriggerHandler.bypass('ComplaintTriggerHandler');
        insert complaint;
        TriggerHandler.clearBypass('ComplaintTriggerHandler');

        //Act
        Test.startTest();

        ICallout2 callout = new Callout2();               



        
        
        ComplaintManager.StandardizeAddress(new Set<Id>{complaint.Id}, true, 'Region 1');
        
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Census_Tract_Number__c  FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Census_Tract_Number__c ;

        //Assert
        System.assertEquals(expected, actual);                          
    }

    private static string GetFakeId(Schema.SObjectType sot)
    {
      String result = String.valueOf(s_num++);
      return sot.getDescribe().getKeyPrefix() + '0'.repeat(12-result.length()) + result;
    }
}