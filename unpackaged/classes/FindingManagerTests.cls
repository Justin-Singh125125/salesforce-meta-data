@isTest
public class FindingManagerTests 
{
	@isTest static void TestRetrieveConfirmationEmails()
	{
		//Arrange
		integer expected = 1;

		Account testAccount = UnitTestHelper.CreateTestAccount();
		Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
		Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
		Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,testContact.Id);
		Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
		
		//Act
		List<Messaging.SingleEmailMessage> actualMessages = FindingManager.RetrieveConfirmationEmails(new Set<Id>{testFinding.Id});
		integer actual = actualMessages.Size();

		//Assert
		System.AssertEquals(expected , actual);

	}	
	@isTest static void TestRetrieveNotificaitonEmails()
	{
		//Arrange
		integer expected = 1;

		Account testAccount = UnitTestHelper.CreateTestAccount();
		Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
		Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
		Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
		Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
		
		//Act
		List<Messaging.SingleEmailMessage> actualMessages = FindingManager.RetrieveNotificaitonEmails(new Set<Id>{testFinding.Id});
		integer actual = actualMessages.Size();
		
		//Assert
		System.AssertEquals(expected , actual); 
	}
}