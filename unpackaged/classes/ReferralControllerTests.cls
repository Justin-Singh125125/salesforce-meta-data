@isTest
private class ReferralControllerTests 
{
    @isTest static void TestLoadCreateReferral_WithParameter_PageReferenceEqual() 
    {
        //Arrange
        PageReference expectedPageReference = null;
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        Id expectedComplaintId = fakeComplaintId;
        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        ApexPages.currentPage().getParameters().put('lkid', fakeComplaintId); 
        
        //Act
        PageReference actualPageReference = controller.LoadCreateReferral();
        Id actualComplaintId = controller.CreateReferralViewModel.Referral.Complaint__c;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedComplaintId, actualComplaintId);
    }

    @isTest static void TestLoadCreateReferral_WithoutParameter_ExpectError() 
    {
        //Arrange
        PageReference expectedPageReference = null;
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);                
        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        
        //Act
        try
        {
            PageReference actualPageReference = controller.LoadCreateReferral();
        }
        catch(Exception ex)
        {
            //Assert
            System.Assert(ex.GetMessage().StartsWith('Invalid id:'));
        }   
    }
    
    @isTest static void Test_GetContacts()
    {
        //Arrange
        integer expected = 3;
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact1@TestAccount.edu');
        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact2@TestAccount.edu');
        Contact testContact3 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact3@TestAccount.edu');

        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        controller.CreateReferralViewModel = new ReferralController.CreateReferralViewModel();
        controller.CreateReferralViewModel.Referral.External_Partner__c = testAccount.Id;

        //Act
        integer actual = controller.GetContacts().Size();
        
        //Assert
        System.AssertEquals(expected, actual);
    }

    @isTest static void Test_SaveHasContactsNewReferral_CheckPageReference()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = new PageReference('/' + testComplaint.Id);
        integer expectedReferralCount = 1;
        integer expectedActualReferralContactCount = 3;
        integer expectedAttachmentCount = 1;
        string expectedStatus = 'Referred';

        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact1@TestAccount.edu');
        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact2@TestAccount.edu');
        Contact testContact3 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact3@TestAccount.edu');

        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        controller.CreateReferralViewModel = new ReferralController.CreateReferralViewModel();
        controller.CreateReferralViewModel.SelectedContacts = testContact1.Id + ',' + testContact2.Id + ',' + testContact3.Id;
        controller.CreateReferralViewModel.Referral.Complaint__c = testComplaint.Id;
        controller.CreateReferralViewModel.Referral.External_Partner__c = testAccount.Id;

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.Save();
        List<Referral__c> actualReferrals = [SELECT Id FROM Referral__c WHERE Complaint__c =: testComplaint.Id AND External_Partner__c =: testAccount.Id AND DAY_ONLY(CreatedDate) =: System.Today()];
        Test.stopTest();

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedReferralCount, actualReferrals.Size());
        Referral__c actualReferral = actualReferrals[0];
        List<ReferralContact__c> actualReferralContacts = [Select Id from ReferralContact__c WHERE Referral__c =: actualReferral.Id];
        System.AssertEquals(expectedActualReferralContactCount, actualReferralContacts.Size());
        
        
        //check if the referral has an attachment called 'ComplaintReport.pdf'.  This won't work in the scratch org.  
        //List<Attachment> actualAttachments = [SELECT Id, Name FROM Attachment Where ParentId =: actualReferral.Id AND Name = 'ComplaintReport.pdf'];
        //System.AssertEquals(expectedAttachmentCount, actualAttachments.Size());


        //check if the complaint's status is Referred
        Complaints__c actualComplaint = [Select Id, Status__c FROM Complaints__c WHERE Id =: testComplaint.Id];
        System.AssertEquals(expectedStatus, actualComplaint.Status__c);
    }

    @isTest static void Test_SaveHasContactsReferralExists_CheckPageReference()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = new PageReference('/' + testComplaint.Id);
        integer expectedReferralCount = 1;
        integer expectedActualReferralContactCount = 4;
        integer expectedAttachmentCount = 1;
        string expectedStatus = 'Referred';

        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact1@TestAccount.edu');
        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact2@TestAccount.edu');
        Contact testContact3 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact3@TestAccount.edu');
        
        string contactIds = testContact1.Id + ',' + testContact2.Id + ',' + testContact3.Id;
        Test.startTest();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id, contactIds);
        
        Contact testContact4 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact4@TestAccount.edu');
        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        controller.CreateReferralViewModel = new ReferralController.CreateReferralViewModel();
        controller.CreateReferralViewModel.SelectedContacts = testContact4.Id;
        controller.CreateReferralViewModel.Referral.Complaint__c = testComplaint.Id;
        controller.CreateReferralViewModel.Referral.External_Partner__c = testAccount.Id;

        //Act
        PageReference actualPageReference = controller.Save();        
        Test.stopTest();
        
        List<Referral__c> actualReferrals = [SELECT Id FROM Referral__c WHERE Complaint__c =: testComplaint.Id AND External_Partner__c =: testAccount.Id AND DAY_ONLY(CreatedDate) =: System.Today()];
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedReferralCount, actualReferrals.Size());
        Referral__c actualReferral = actualReferrals[0];
        List<ReferralContact__c> actualReferralContacts = [Select Id from ReferralContact__c WHERE Referral__c =: actualReferral.Id];
        System.AssertEquals(expectedActualReferralContactCount, actualReferralContacts.Size());
        
        //check if the referral has an attachment called 'ComplaintReport.pdf'.  This won't work in the scratch org.  
        //List<Attachment> actualAttachments = [SELECT Id, Name FROM Attachment Where ParentId =: actualReferral.Id AND Name = 'ComplaintReport.pdf'];
        //System.AssertEquals(expectedAttachmentCount, actualAttachments.Size());

        //check if the complaint's status is Referred
        Complaints__c actualComplaint = [Select Id, Status__c FROM Complaints__c WHERE Id =: testComplaint.Id];
        System.AssertEquals(expectedStatus, actualComplaint.Status__c);
    }

    @isTest static void Test_SaveNoContacts_ExpectError()
    {
       //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = null;

        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        controller.CreateReferralViewModel = new ReferralController.CreateReferralViewModel();

        //Act
        PageReference actualPageReference = controller.Save();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg : msgs)
        {
            if (msg.getDetail().contains('You must select at least one contact') && msg.getSeverity() == ApexPages.Severity.ERROR) 
            {
                b = true;
            }
            system.assert(b);
        }
    }

    @isTest static void Test_SaveAndNewHasContacts_CheckPageReference()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = new PageReference('/apex/newReferral?complaint=' + testComplaint.Id);
        integer expectedReferralCount = 1;
        integer expectedActualReferralContactCount = 3;
        integer expectedAttachmentCount = 1;
        string expectedStatus = 'Referred';

        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact1@TestAccount.edu');
        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact2@TestAccount.edu');
        Contact testContact3 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact3@TestAccount.edu');

        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        controller.CreateReferralViewModel = new ReferralController.CreateReferralViewModel();
        controller.CreateReferralViewModel.SelectedContacts = testContact1.Id + ',' + testContact2.Id + ',' + testContact3.Id;
        controller.CreateReferralViewModel.Referral.Complaint__c = testComplaint.Id;
        controller.CreateReferralViewModel.Referral.External_Partner__c = testAccount.Id;

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.SaveAndNew();
        List<Referral__c> actualReferrals = [SELECT Id FROM Referral__c WHERE Complaint__c =: testComplaint.Id AND External_Partner__c =: testAccount.Id AND DAY_ONLY(CreatedDate) =: System.Today()];
        Test.stopTest();

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedReferralCount, actualReferrals.Size());
        Referral__c actualReferral = actualReferrals[0];
        List<ReferralContact__c> actualReferralContacts = [Select Id from ReferralContact__c WHERE Referral__c =: actualReferral.Id];
        System.AssertEquals(expectedActualReferralContactCount, actualReferralContacts.Size());
        //check if the referral has an attachment called 'ComplaintReport.pdf'.  This won't work in the scratch org.  
        //List<Attachment> actualAttachments = [SELECT Id, Name FROM Attachment Where ParentId =: actualReferral.Id AND Name = 'ComplaintReport.pdf'];
        //System.AssertEquals(expectedAttachmentCount, actualAttachments.Size());
        
        
        //check if the complaint's status is Referred
        Complaints__c actualComplaint = [Select Id, Status__c FROM Complaints__c WHERE Id =: testComplaint.Id];
        System.AssertEquals(expectedStatus, actualComplaint.Status__c);
    }

    @isTest static void Test_SaveAndNewNoContacts_ExpectError()
    {
       //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = null;

        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        controller.CreateReferralViewModel = new ReferralController.CreateReferralViewModel();

        //Act
        PageReference actualPageReference = controller.SaveAndNew();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg : msgs)
        {
            if (msg.getDetail().contains('You must select at least one contact') && msg.getSeverity() == ApexPages.Severity.ERROR) 
            {
                b = true;
            }
            system.assert(b);
        }
    }

    @isTest static void Test_Cancel_CheckPageReference()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = new PageReference('/' + testComplaint.Id);
        expectedPageReference.SetRedirect(true);
        Referral__c referral = new Referral__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(referral);
        ReferralController controller = new ReferralController(standardController);
        controller.CreateReferralViewModel = new ReferralController.CreateReferralViewModel();
        controller.CreateReferralViewModel.Referral.Complaint__c = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.Cancel();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }
 }