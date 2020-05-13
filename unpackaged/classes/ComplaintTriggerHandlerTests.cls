@isTest
public class ComplaintTriggerHandlerTests 
{
    /*static testMethod void beforeInsert_ParentComplaint_ExpectAgencyOwner()
    {
        system.debug('hello world');
        //Arrange
        string expected = 'Agency';
        Complaints__c complaint = new Complaints__c();

        //Act
        Test.startTest();        
        insert complaint;
        Test.stopTest();
        
        Complaints__c retrieved = [SELECT Id, OwnerId, RecordTypeId FROM Complaints__c WHERE Id =: complaint.Id];
        Group ownerQueue = new QueueManager().GetQueueById(retrieved.OwnerId);
        string actual = ownerQueue.Name;
        
        //Assert
        System.assertEquals(expected, actual); 
    }*/
    
    
    static testMethod void afterInsert_AddressProvided_ExpectedStreetAddress()
    {
        //Arrange
        string expected = '1600 Pennsylvania Avenue';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        

        //Act
        Test.startTest();        
        insert complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_Address__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_Address__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void afterInsert_AddressProvided_ExpectedCity()
    {
        //Arrange
        string expected = 'AnyTown';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        

        //Act
        Test.startTest();        
        insert complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_City__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_City__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void afterInsert_AddressProvided_ExpectedState()
    {
        //Arrange
        string expected = 'Florida';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        

        //Act
        Test.startTest();        
        insert complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_State__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_State__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }                                                     

    static testMethod void afterInsert_AddressProvided_ExpectedZipCode()
    {
        //Arrange
        string expected = '90210';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        

        //Act
        Test.startTest();        
        insert complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_Zip_Code__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_Zip_Code__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }                                                                         
    
    static testMethod void afterInsert_AddressProvided_ExpectedCounty()
    {
        //Arrange
        string expected = 'Madison County';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        

        //Act
        Test.startTest();        
        insert complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_County__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_County__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }                                                     

    static testMethod void afterInsert_AddressProvided_ExpectedCensusTract()
    {
        //Arrange
        string expected = '6019001500';
        Complaints__c complaint = new Complaints__c(Complaint_Location_Address__c = '987 Elm St', Complaint_Location_City__c = 'A City', Complaint_Location_State__c = 'A State', Complaint_Location_Zip_Code__c = '12345');
        

        //Act
        Test.startTest();        
        insert complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Census_Tract_Number__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Census_Tract_Number__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }

    
    static testMethod void afterUpdate_AddressChanged_ExpectUpdatedStreetAddress()
    {
        //Arrange
        string expected = '1600 Pennsylvania Avenue';
        Complaints__c complaint = new Complaints__c();
        

        //Act
        Test.startTest();        
        insert complaint;
        complaint.Complaint_Location_Address__c = '987 Elm St';
        complaint.Complaint_Location_City__c = 'A City';
        complaint.Complaint_Location_State__c = 'A State';
        complaint.Complaint_Location_Zip_Code__c = '12345';
        TriggerManager.RunAfterUpdate = true;
        update complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_Address__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_Address__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void afterUpdate_AddressChanged_ExpectUpdatedCity()
    {
        //Arrange
        string expected = 'AnyTown';
        Complaints__c complaint = new Complaints__c();
        

        //Act
        Test.startTest();        
        insert complaint;
        complaint.Complaint_Location_Address__c = '987 Elm St';
        complaint.Complaint_Location_City__c = 'A City';
        complaint.Complaint_Location_State__c = 'A State';
        complaint.Complaint_Location_Zip_Code__c = '12345';
        TriggerManager.RunAfterUpdate = true;
        update complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_City__c  FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_City__c ;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void afterUpdate_AddressChanged_ExpectUpdatedState()
    {
        //Arrange
        string expected = 'Florida';
        Complaints__c complaint = new Complaints__c();
        

        //Act
        Test.startTest();        
        insert complaint;
        complaint.Complaint_Location_Address__c = '987 Elm St';
        complaint.Complaint_Location_City__c = 'A City';
        complaint.Complaint_Location_State__c = 'A State';
        complaint.Complaint_Location_Zip_Code__c = '12345';
        TriggerManager.RunAfterUpdate = true;
        update complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_State__c  FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_State__c ;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void afterUpdate_AddressChanged_ExpectUpdatedZipCode()
    {
        //Arrange
        string expected = '90210';
        Complaints__c complaint = new Complaints__c();
        

        //Act
        Test.startTest();        
        insert complaint;
        complaint.Complaint_Location_Address__c = '987 Elm St';
        complaint.Complaint_Location_City__c = 'A City';
        complaint.Complaint_Location_State__c = 'A State';
        complaint.Complaint_Location_Zip_Code__c = '12345';
        TriggerManager.RunAfterUpdate = true;
        update complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_Zip_Code__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_Zip_Code__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
    static testMethod void afterUpdate_AddressChanged_ExpectUpdatedCounty()
    {
        //Arrange
        string expected = 'Madison County';
        Complaints__c complaint = new Complaints__c();
        

        //Act
        Test.startTest();        
        insert complaint;
        complaint.Complaint_Location_Address__c = '987 Elm St';
        complaint.Complaint_Location_City__c = 'A City';
        complaint.Complaint_Location_State__c = 'A State';
        complaint.Complaint_Location_Zip_Code__c = '12345';
        TriggerManager.RunAfterUpdate = true;
        update complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Complaint_Location_County__c FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Complaint_Location_County__c;

        //Assert
        System.assertEquals(expected, actual);                          
    }
   
    static testMethod void afterUpdate_AddressChanged_ExpectUpdatedCensusTract()
    {
        //Arrange
        string expected = '6019001500';
        Complaints__c complaint = new Complaints__c();
        

        //Act
        Test.startTest();        
        insert complaint;
        complaint.Complaint_Location_Address__c = '987 Elm St';
        complaint.Complaint_Location_City__c = 'A City';
        complaint.Complaint_Location_State__c = 'A State';
        complaint.Complaint_Location_Zip_Code__c = '12345';
        TriggerManager.RunAfterUpdate = true;
        update complaint;
        Test.stopTest();
        Complaints__c retrieved = [SELECT Id, Census_Tract_Number__c   FROM Complaints__c WHERE Id =: complaint.Id];
        string actual = retrieved.Census_Tract_Number__c  ;

        //Assert
        System.assertEquals(expected, actual);                          
    }
    
}