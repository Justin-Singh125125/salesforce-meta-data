@isTest
public class FindingControllerTests 
{
	

	public FindingControllerTests() 
	{
		
	}
 
	@isTest 
	static void TestLoadSFDCCreateNewFinding()
	{
		//Arrange
		string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
		id idval = fakeComplaintId;
		fakeComplaintId = idval;                  
		ApexPages.currentPage().getParameters().put('lkid', fakeComplaintId); 
		PageReference expectedPageReference = null;
		Finding__c finding = new Finding__c();
		ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
		FindingController controller = new FindingController(standardController);
		string expectedFindingComplaintId = fakeComplaintId;

		//Act
		PageReference actualPageReference = controller.LoadSFDCCreateNewFinding();
		string actualFindingComplaintId = controller.SFDCCreateNewFindingViewModel.Finding.Complaint__c;
		
		//Assert
		PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
		System.AssertEquals(expectedFindingComplaintId, actualFindingComplaintId);

	}	

	@isTest static void TestSFDCCancelNewFinding()
	{
		//Arrange
		Account testAccount = UnitTestHelper.CreateTestAccount();
		Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
		Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
		Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
		Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
		PageReference expected = new PageReference('/' + testComplaint.Id);
		expected.setRedirect(true);
		Finding__c finding = new Finding__c();
		ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
		FindingController controller = new FindingController(standardController);
		controller.SFDCCreateNewFindingViewModel = new FindingController.SFDCCreateNewFindingViewModel();
		controller.SFDCCreateNewFindingViewModel.Finding = testFinding;

		//Act
		PageReference actual = controller.SFDCCancelNewFinding(); 
		
		//Assert
		PageReferenceTestHelper.Assert(expected, actual);

	}

	@isTest static void TestSFDCSaveNewFinding()
	{
		//Arrange
		Account testAccount = UnitTestHelper.CreateTestAccount();
		Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
		Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
		Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
		Finding__c testFinding = new Finding__c();
		testFinding.Complaint__c = testComplaint.Id;
		testFinding.Contact__c = testContact.Id;
		testFinding.Date_of_Referral__c = Date.valueOf('2017-01-01 00:00:00');
		testFinding.Date_of_Site_Visit__c = Date.valueOf('2017-01-01 00:00:00');		
		testFinding.Is_Enforcement_Complete__c = 'Yes';
		testFinding.On_Going_Enforcement__c = '';
		testFinding.Other_Reason_for_No_Site_Visit__c = '';
		testFinding.Reason_for_No_Site_Visit__c = '';
		testFinding.Referral_Agency__c = 'Lorem Ipsum';
		testFinding.Referral__c = testReferral.Id;
		testFinding.Secondary_Referral__c = 'Yes';
		testFinding.Site_Visit_Conducted__c = 'Yes';
		testFinding.Summary_of_Violations_and_enforcement__c = 'Lorem Ipsum';
		testFinding.Violations_or_Compliance_Issues__c = 'No';
		testFinding.Violations_Related_to_Complaint__c = null;
		PageReference expectedPageReference = new PageReference('/' + testComplaint.Id);
		expectedPageReference.setRedirect(true);
		Finding__c finding = new Finding__c();
		ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
		FindingController controller = new FindingController(standardController);
		controller.SFDCCreateNewFindingViewModel = new FindingController.SFDCCreateNewFindingViewModel();
		controller.SFDCCreateNewFindingViewModel.Finding = testFinding;
		string expectedComplaintId = testComplaint.Id;
		string expectedContactId = testContact.Id;
		Date expectedDateOfReferral = Date.valueOf('2017-01-01 00:00:00');
		Date expectedDateOfSiteVisit = Date.valueOf('2017-01-01 00:00:00');		
		string expectedIsEnforcementComplete = 'Yes';
		string expectedOnGoingEnforcement = '';
		string expectedOtherReasonForNoSiteVisit = '';
		string expectedReasonForNoSiteVisit = '';
		string expectedReferralAgency = 'Lorem Ipsum';
		string expectedReferralId = testReferral.Id;
		string expectedSecondaryReferral = 'Yes';
		string expectedSiteVisitConducted = 'Yes';
		string expectedSummaryOfViolationsAndEnforcement = 'Lorem Ipsum';
		string expectedViolationsOrComplianceIssues = 'No';
		string expectedViolationsRelatedToComplaint = null;
		//Act
		PageReference actualPageReference = controller.SFDCSaveNewFinding(); 
		string actualComplaintId = controller.SFDCCreateNewFindingViewModel.Finding.Complaint__c;
		string actualContactId = controller.SFDCCreateNewFindingViewModel.Finding.Contact__c;
		Date actualDateOfReferral = controller.SFDCCreateNewFindingViewModel.Finding.Date_of_Referral__c;
		Date actualDateOfSiteVisit = controller.SFDCCreateNewFindingViewModel.Finding.Date_of_Site_Visit__c;
		string actualIsEnforcementComplete = controller.SFDCCreateNewFindingViewModel.Finding.Is_Enforcement_Complete__c;
		string actualOnGoingEnforcement = controller.SFDCCreateNewFindingViewModel.Finding.On_Going_Enforcement__c;
		string actualOtherReasonForNoSiteVisit = controller.SFDCCreateNewFindingViewModel.Finding.Other_Reason_for_No_Site_Visit__c;
		string actualReasonForNoSiteVisit = controller.SFDCCreateNewFindingViewModel.Finding.Reason_for_No_Site_Visit__c;
		string actualReferralAgency = controller.SFDCCreateNewFindingViewModel.Finding.Referral_Agency__c;
		string actualReferralId = controller.SFDCCreateNewFindingViewModel.Finding.Referral__c;
		string actualSecondaryReferral = controller.SFDCCreateNewFindingViewModel.Finding.Secondary_Referral__c;
		string actualSiteVisitConducted = controller.SFDCCreateNewFindingViewModel.Finding.Site_Visit_Conducted__c;
		string actualSummaryOfViolationsAndEnforcement = controller.SFDCCreateNewFindingViewModel.Finding.Summary_of_Violations_and_enforcement__c;
		string actualViolationsOrComplianceIssues = controller.SFDCCreateNewFindingViewModel.Finding.Violations_or_Compliance_Issues__c;
		string actualViolationsRelatedToComplaint = controller.SFDCCreateNewFindingViewModel.Finding.Violations_Related_to_Complaint__c;
		
		//Assert
		PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
		System.AssertEquals(expectedComplaintId, actualComplaintId);
		System.AssertEquals(expectedContactId, actualContactId);
		System.AssertEquals(expectedDateOfReferral, actualDateOfReferral);
		System.AssertEquals(expectedDateOfSiteVisit, actualDateOfSiteVisit);
		System.AssertEquals(expectedIsEnforcementComplete, actualIsEnforcementComplete);
		System.AssertEquals(expectedOnGoingEnforcement, actualOnGoingEnforcement);
		System.AssertEquals(expectedOtherReasonForNoSiteVisit, actualOtherReasonForNoSiteVisit);
		System.AssertEquals(expectedReasonForNoSiteVisit, actualReasonForNoSiteVisit);
		System.AssertEquals(expectedReferralAgency, actualReferralAgency);
		System.AssertEquals(expectedReferralId, actualReferralId);
		System.AssertEquals(expectedSecondaryReferral, actualSecondaryReferral);
		System.AssertEquals(expectedSiteVisitConducted, actualSiteVisitConducted);
		System.AssertEquals(expectedSummaryOfViolationsAndEnforcement, actualSummaryOfViolationsAndEnforcement);
		System.AssertEquals(expectedViolationsOrComplianceIssues, actualViolationsOrComplianceIssues);
		System.AssertEquals(expectedViolationsRelatedToComplaint, actualViolationsRelatedToComplaint);

	}
	
	
}