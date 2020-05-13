@isTest
private class FindingsTriggerTests
{
    @isTest
    static void TestCreateNewFindingWithReferral()
    {
        //Arrange
        string expected = 'Findings Received';
        //Create an External Partner Account
        Account testAccount = UnitTestHelper.CreateTestAccount();
        //Create an External Partner Contact
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        //Create a Complaint
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        //Create a Referral
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        //Create a Finding

        //Act
        Test.startTest();
        Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
        Test.stopTest();
        Referral__c actualReferral = [SELECT Id, Status__c FROM Referral__c WHERE Id =: testReferral.Id];
        string actual = actualReferral.Status__c;

        //Assert
        System.AssertEquals(expected, actual);
    }
    
    @isTest
    static void TestUpdateFindingWithReferral()
    {
    //Arrange
        string expected = 'Findings Received';
        //Create an External Partner Account
        Account testAccount = UnitTestHelper.CreateTestAccount();
        //Create an External Partner Contact
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        //Create a Complaint
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        //Create a Referral
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        //Create a Finding

        //Act
        Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, null, testContact.Id);
        testFinding.Referral__c = testReferral.Id;
        Test.startTest();
        update testFinding;
        Test.stopTest();

        Referral__c actualReferral = [SELECT Id, Status__c FROM Referral__c WHERE Id =: testReferral.Id];
        string actual = actualReferral.Status__c;

        //Assert
        System.AssertEquals(expected, actual);
    }
    
}