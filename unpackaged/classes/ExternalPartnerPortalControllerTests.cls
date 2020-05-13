@isTest
private class ExternalPartnerPortalControllerTests 
{
   
    @isTest static void TestCompleteExternalPartnerResetPassword_PasswordNull_ExpectPageErrorMessage() 
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = '';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Please Provide a Password.';
        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage);
    }

    @isTest static void TestCompleteExternalPartnerResetPassword_PasswordLessThan8Characters_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = '1234567';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least 8 Characters.';

        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;        

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage);
    }

    @isTest static void TestCompleteExternalPartnerResetPassword_PasswordMustHaveAtLeastOneUppercase_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = '12345678';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least One Uppercase Letter.';

        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }
    
    @isTest static void TestCompleteExternalPartnerResetPassword_PasswordMustHaveAtLeastOneLowercase_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = 'A2345678';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least One Lowercase Letter.';

        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    } 
    
    @isTest static void TestCompleteExternalPartnerResetPassword_PasswordMustHaveAtLeastOneNumeral_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = 'AbCDEFGH';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least One Numeral.';

        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestCompleteExternalPartnerResetPassword_PasswordMoreThan16Characters_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = 'AbCDEFGH901234567';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Can Be No More Than 16 Characters.';

        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestCompleteExternalPartnerResetPassword_PasswordsDoNotMatch_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = 'AbCDefgh10';
        controller.CompleteExternalPartnerResetPasswordViewModel.ConfirmPassword = 'AbCDefgh101';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Passwords Do Not Match';

        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
        
         
    }
    
    @isTest static void TestCompleteExternalPartnerResetPassword_ContactDoesntExist_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = 'AbCDefgh10';
        controller.CompleteExternalPartnerResetPasswordViewModel.ConfirmPassword = 'AbCDefgh10';
        controller.CompleteExternalPartnerResetPasswordViewModel.EmailAddress = 'emaildoesntexist@test.com';
        PageReference expected = null;
        string expectedPageErrorMessage = 'There was a problem resetting your password, please contact complaints@calepa.ca.gov for assistance.';

        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
        
         
    }
    
    @isTest static void TestCompleteExternalPartnerResetPassword_PageReferenceEqual() 
    {
        //Arrange
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = UnitTestHelper.CreateTestAccount();
        //Create a contact
        Contact testContact0 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu' );
        
        Finding__c finding = new Finding__c(); 
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CompleteExternalPartnerResetPasswordViewModel = new ExternalPartnerPortalController.CompleteExternalPartnerResetPasswordViewModel();
        controller.CompleteExternalPartnerResetPasswordViewModel.EmailAddress = 'TestContact@TestAccount.edu';
        controller.CompleteExternalPartnerResetPasswordViewModel.Password = 'AbCDefgh10';
        controller.CompleteExternalPartnerResetPasswordViewModel.ConfirmPassword = 'AbCDefgh10';
        PageReference expected = Page.ExternalPartnerLogin;
        expected.setRedirect(true);
        
        //Act
        PageReference actual = controller.CompleteExternalPartnerResetPassword();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestEnterFindingsWithoutLoggingIn_NotRefOrComp_NullPageReference() 
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        //controller.ExternalPartnerLoginViewModel.ComplaintId = 'ABCD';
        string fakeReferralId = UnitTestHelper.GetFakeId(Referral__c.SObjectType);
        controller.ExternalPartnerLoginViewModel.ComplaintId = fakeReferralId;
        PageReference expected = null;
        string expectedPageErrorMessage = 'The number and id do not match our records.';

        //Act
        PageReference actual = controller.EnterFindingsWithoutLoggingIn();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestEnterFindingsWithoutLoggingIn_Complaint_IdDoesNotExist() 
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        string fakeReferralId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        controller.ExternalPartnerLoginViewModel.ComplaintId = fakeReferralId;
        PageReference expected = null;
        string expectedPageErrorMessage = 'The number and id do not match our records.';

        //Act
        PageReference actual = controller.EnterFindingsWithoutLoggingIn();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestEnterFindingsWithoutLoggingIn_Complaint_IdAndNameDoNotMatch() 
    {
        //Arrange
        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c testComplaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint;

        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();     
        controller.ExternalPartnerLoginViewModel.ComplaintId = testComplaint.Id;
        controller.ExternalPartnerLoginViewModel.ComplaintNumber = '00000';
        PageReference expected = null;
        string expectedPageErrorMessage = 'The number and id do not match our records.';

        //Act
        PageReference actual = controller.EnterFindingsWithoutLoggingIn();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
    }

    @isTest static void TestEnterFindingsWithoutLoggingIn_Complaint_Success() 
    {
        //Arrange
        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c testComplaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint;

        Complaints__c retrievedComplaint = [SELECT Id, Name from Complaints__c WHERE Id =: testComplaint.Id];


        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.ComplaintId = retrievedComplaint.Id;
        controller.ExternalPartnerLoginViewModel.ComplaintNumber = retrievedComplaint.Name;//.Replace('COMP-','');
        PageReference expected = Page.FindingReferralSelector;
        expected.getParameters().put('complaintId',retrievedComplaint.Id);
        expected.setRedirect(true);
        //Act
        PageReference actual = controller.EnterFindingsWithoutLoggingIn();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestCreateAccount_Success()
    {
        //Arrange
        
        //Act
        Test.startTest();
        ExternalPartnerPortalController.CreateAccount('Test Account');
        Test.stopTest();
        List<Account> retrievedAccounts = [SELECT Id, Name FROM Account Where Name = 'Test Account'];

        //Assert
        system.Assert(retrievedAccounts.size() > 0);
    }

    @isTest static void TestCreateAccount_Exception()
    {
        //Arrange
        string expected = 'There was an error creating your agency.  Please contact complaints@calepa.ca.gov for assistance.';

        try
        {
            //Act
            ExternalPartnerPortalController.CreateAccount('');
        
        }
        catch(Exception ex)
        {
            string actual = ex.getMessage();
            //Assert

            system.assertEquals(expected, actual);
        }
    }

    @isTest static void TestExternalPartnerAccountProfile_PageReferenceEqual() 
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        PageReference expected = Page.ExternalPartnerAccountProfile;

        //Act
        PageReference actual = controller.ExternalPartnerAccountProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestExternalPartnerContactProfile_PageReferenceEqual() 
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        PageReference expected = Page.ExternalPartnerContactProfile;

        //Act
        PageReference actual = controller.ExternalPartnerContactProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestExternalPartnerLandingScreen_PageReferenceEqual() 
    {

        //Arrange
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        //Create a contact
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact@TestAccount.edu' );
        insert testContact;

        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        controller.Authentication.UserId = testContact.Id;
        controller.Authentication.IsLoggedIn = true;

        PageReference expected = Page.ExternalPartnerLandingScreen;
        expected.setRedirect(true);

        //Act
        PageReference actual = controller.ExternalPartnerLandingScreen();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestExternalPartnerLandingScreen_GoToLogin() 
    {

        //Arrange
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        //Create a contact
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact@TestAccount.edu' );
        insert testContact;

        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        controller.Authentication.UserId = UnitTestHelper.GetFakeId(Contact.SObjectType);

        PageReference expected = ExternalPartnerPortalControllerTests.GetGoToLoginPageReference();

        //Act
        PageReference actual = controller.ExternalPartnerLandingScreen();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestGenerateRandomString_Length() 
    {

        //Arrange
        integer expected = 10;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        //Act
        string randomString = controller.GenerateRandomString(10);
        integer actual = randomString.length();
        //Assert
        system.assertEquals(expected, actual);

    }

    @isTest static void TestGetAccountByName_Success()
    {
        //Arrange
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        string expected = testAccount.Id;
        //Act
        Account actualAccount = ExternalPartnerPortalController.GetAccountByName('Test Account');
        string actual = actualAccount.Id;
        //Assert
        system.assertEquals(expected, actual);

    }

    @isTest static void TestGetAccountByName_NameNotFound()
    {
        //Arrange
        string expected = 'There was an error creating your agency.  Please contact complaints@calepa.ca.gov for assistance.';
        try
        {
            //Act
            Account actualAccount = ExternalPartnerPortalController.GetAccountByName('Test Account');           
        }
        catch(Exception ex)
        {
            string actual = ex.getMessage();
            //Assert
            system.assertEquals(expected, actual);
        }
        
    }

    @isTest static void TestGetAccounts_LetterFilter()
    {
        //Arrange
        integer expectedAccountsCount = 4;
        integer expectedTotalCount = 4;
        integer expectedTotalPages = 1;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        List<Account> testAccounts = new List<Account>();
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z4'));
        insert testAccounts;
        string letterFilter = 'A';
        integer pageNumber = 0;
        string textFilter = '';
        string type = '';

        //Act
        ExternalPartnerPortalController.ExternalPartnerAccountListViewModel retrievedExternalPartnerAccountListViewModel = ExternalPartnerPortalController.GetAccounts(letterFilter, pageNumber, textFilter, type);
        integer actualAccountsCount = retrievedExternalPartnerAccountListViewModel.Accounts.size();
        integer actualTotalCount = retrievedExternalPartnerAccountListViewModel.Count;
        integer actualTotalPages = retrievedExternalPartnerAccountListViewModel.TotalPages;

        //Assert
        system.assertEquals(expectedAccountsCount, actualAccountsCount, 'Account Count');
        system.assertEquals(expectedTotalCount, actualTotalCount, 'Total Records');
        system.assertEquals(expectedTotalPages, actualTotalPages, 'Pages');
        
    }

    @isTest static void TestGetAccounts_TextFilter()
    {
        //Arrange
        integer expectedAccountsCount = 2;
        integer expectedTotalCount = 2;
        integer expectedTotalPages = 1;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        List<Account> testAccounts = new List<Account>();
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'AA1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'AA2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z4'));
        insert testAccounts;
        string letterFilter = '';
        integer pageNumber = 0;
        string textFilter = 'AA';
        string type = '';

        //Act
        ExternalPartnerPortalController.ExternalPartnerAccountListViewModel retrievedExternalPartnerAccountListViewModel = ExternalPartnerPortalController.GetAccounts(letterFilter, pageNumber, textFilter, type);
        integer actualAccountsCount = retrievedExternalPartnerAccountListViewModel.Accounts.size();
        integer actualTotalCount = retrievedExternalPartnerAccountListViewModel.Count;
        integer actualTotalPages = retrievedExternalPartnerAccountListViewModel.TotalPages;

        //Assert
        system.assertEquals(expectedAccountsCount, actualAccountsCount, 'Account Count');
        system.assertEquals(expectedTotalCount, actualTotalCount, 'Total Records');
        system.assertEquals(expectedTotalPages, actualTotalPages, 'Pages');
        
    }

    @isTest static void TestGetAccounts_PageNumber()
    {
        //Arrange
        string expected = 'F1';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        List<Account> testAccounts = new List<Account>();
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'E4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'F4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'G4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'H4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'I4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'J4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'K4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'L4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'M4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'N4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'O4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'P4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Q4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'R4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'S4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'T4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'U4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'V4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'W4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'X4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Y4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Z4'));
        insert testAccounts;
        string letterFilter = '';
        integer pageNumber = 2;
        string textFilter = '';
        string type = '';

        //Act
        ExternalPartnerPortalController.ExternalPartnerAccountListViewModel retrievedExternalPartnerAccountListViewModel = ExternalPartnerPortalController.GetAccounts(letterFilter, pageNumber, textFilter, type);
        string actual = retrievedExternalPartnerAccountListViewModel.Accounts[0].Name;

        //Assert
        system.assertEquals(expected, actual);
    }
    
    @isTest static void TestGetAccounts_TypeFilter()
    {
        //Arrange
        integer expectedAccountsCount = 10;
        integer expectedTotalCount = 11;
        integer expectedTotalPages = 2;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        List<Account> testAccounts = new List<Account>();
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'A1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'B1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'C1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'D1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'A2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'B2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'C2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'D2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'A3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'B3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Multi_Type__c='Air District;', Name = 'C3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A16'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B16'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B18'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C18'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D18'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A20'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B20'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C20'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D20'));

        insert testAccounts;
        string letterFilter = '';
        integer pageNumber = 0;
        string textFilter = '';
        string type = 'Air District';

        //Act
        ExternalPartnerPortalController.ExternalPartnerAccountListViewModel retrievedExternalPartnerAccountListViewModel = ExternalPartnerPortalController.GetAccounts(letterFilter, pageNumber, textFilter, type);
        integer actualAccountsCount = retrievedExternalPartnerAccountListViewModel.Accounts.size();
        integer actualTotalCount = retrievedExternalPartnerAccountListViewModel.Count;
        integer actualTotalPages = retrievedExternalPartnerAccountListViewModel.TotalPages;

        //Assert
        system.assertEquals(expectedAccountsCount, actualAccountsCount, 'Account Count');
        system.assertEquals(expectedTotalCount, actualTotalCount, 'Total Records');
        system.assertEquals(expectedTotalPages, actualTotalPages, 'Pages');
        
    }

    @isTest static void TestGetAccounts_LetterFilterMultipleOfTen()
    {
        //Arrange
        integer expectedAccountsCount = 10;
        integer expectedTotalCount = 20;
        integer expectedTotalPages = 2;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        List<Account> testAccounts = new List<Account>();
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'A1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'B1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'C1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'D1'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'A2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'B2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'C2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'D2'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'A3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'B3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'C3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D3'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D4'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D5'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D6'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D7'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D8'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D9'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D10'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D11'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D12'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D13'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D14'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D15'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A16'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B16'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C16'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D16'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A17'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B18'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C18'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D18'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D19'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'A20'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'B20'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'C20'));
        testAccounts.Add(new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'D20'));
        insert testAccounts;
        string letterFilter = 'D';
        integer pageNumber = 0;
        string textFilter = '';
        string type = '';

        //Act
        ExternalPartnerPortalController.ExternalPartnerAccountListViewModel retrievedExternalPartnerAccountListViewModel = ExternalPartnerPortalController.GetAccounts(letterFilter, pageNumber, textFilter, type);
        integer actualAccountsCount = retrievedExternalPartnerAccountListViewModel.Accounts.size();
        integer actualTotalCount = retrievedExternalPartnerAccountListViewModel.Count;
        integer actualTotalPages = retrievedExternalPartnerAccountListViewModel.TotalPages;

        //Assert
        system.assertEquals(expectedAccountsCount, actualAccountsCount, 'Account Count');
        system.assertEquals(expectedTotalCount, actualTotalCount, 'Total Records');
        system.assertEquals(expectedTotalPages, actualTotalPages, 'Pages');
        
    }

    @isTest static void TestGetAuthenticationCookie()
    {
        //Arrange
        boolean expectedIsLoggedIn = true;
        integer expectedAccountCount = 1;
        string expectedExternalPartnerName = 'Lorem';
        string expectedExternalPartnerId = 'Ipsum';
        string expectedUsersName = 'dolor';
        string expectedUserId = 'consectetur';
        
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, type='Air District', Name = 'A1');
        insert testAccount;
        
        ExternalPartnerPortalController.AuthenticationModel authenticationModel = new ExternalPartnerPortalController.AuthenticationModel();
        authenticationModel.IsLoggedIn = true;
        authenticationModel.ExternalPartners = new Map<Id, String>(); 
        authenticationModel.ExternalPartners.Put(testAccount.Id, testAccount.Name);
        authenticationModel.ExternalPartnerName = 'Lorem';
        authenticationModel.ExternalPartnerId = 'Ipsum';
        authenticationModel.UsersName = 'dolor';
        authenticationModel.UserId = 'consectetur';
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authenticationModel),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie});         
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        //Act
        controller.GetAuthenticationCookie();
        boolean actualIsLoggedIn = controller.Authentication.IsLoggedIn;
        integer actualAccountCount = controller.Authentication.ExternalPartners.size();
        string actualExternalPartnerName = controller.Authentication.ExternalPartnerName;
        string actualExternalPartnerId = controller.Authentication.ExternalPartnerId;
        string actualUsersName = controller.Authentication.UsersName;
        string actualUserId = controller.Authentication.UserId;
        //Assert
        system.assertEquals(expectedIsLoggedIn,actualIsLoggedIn);
        system.assertEquals(expectedAccountCount,actualAccountCount);
        system.assertEquals(expectedExternalPartnerName,actualExternalPartnerName);
        system.assertEquals(expectedExternalPartnerId,actualExternalPartnerId);
        system.assertEquals(expectedUsersName,actualUsersName);
        system.assertEquals(expectedUserId,actualUserId);
    }
 
    @isTest static void TestGetContactsByAccount_AccountDoesntExist_ExpectError()
    {
        //Arrange
        string expected = 'There was an issue retrieving contact information.  Please contact complaints@calepa.ca.gov for assistance.';
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        try
        {
            //Act
            List<ExternalPartnerPortalController.ContactDataTableRowViewModel> contactDataTableRowViewModels = ExternalPartnerPortalController.GetContactsByAccount(fakeAccountId);
        }
        catch(Exception ex)
        {
            string actual = ex.GetMessage();
            
            //Assert
            system.assertEquals(expected, actual);
        }

    }

    @isTest static void TestGetContactsByAccount_AccountWithNoContacts_ExpectError()
    {
        //Arrange
        string expected = 'There was an issue retrieving contact information.  Please contact complaints@calepa.ca.gov for assistance.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        try
        {
            //Act
            List<ExternalPartnerPortalController.ContactDataTableRowViewModel> contactDataTableRowViewModels = ExternalPartnerPortalController.GetContactsByAccount(testAccount.Id);
        }
        catch(Exception ex)
        {
            string actual = ex.GetMessage();
            
            //Assert
            system.assertEquals(expected, actual);
        }

    }
 
    @isTest static void TestGetContactsByAccount_TitleIsNull_TitleEqualsEmptyString()
    {
        //Arrange
        string expected = '';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, AccountId = testAccount.Id, FirstName = 'Lorem', LastName = 'Ipsum', Phone = '(555) 111-2222',  Email = 'TestContact@TestAccount.edu', Inactive__c = false );
        insert testContact;

        //Act
        List<ExternalPartnerPortalController.ContactDataTableRowViewModel> retrievedList = ExternalPartnerPortalController.GetContactsByAccount(testAccount.Id);
        string actual = retrievedList[0].Title;

        //Assert
        system.AssertEquals(expected, actual);

    }

    @isTest static void TestGetContactsByAccount_PhoneIsNull_PhoneEqualsEmptyString()
    {
        //Arrange
        string expected = '';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, AccountId = testAccount.Id, FirstName = 'Lorem', LastName = 'Ipsum', Title = 'Lorem Ipsum',  Email = 'TestContact@TestAccount.edu', Inactive__c = false );
        insert testContact;

        //Act
        List<ExternalPartnerPortalController.ContactDataTableRowViewModel> retrievedList = ExternalPartnerPortalController.GetContactsByAccount(testAccount.Id);
        string actual = retrievedList[0].Phone;

        //Assert
        system.AssertEquals(expected, actual);

    }

    @isTest static void TestGetContactsByAccount_EmailIsNull_EmailEqualsEmptyString()
    {
        //Arrange
        string expected = '';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, AccountId = testAccount.Id, FirstName = 'Lorem', LastName = 'Ipsum', Title = 'Lorem Ipsum', Phone = '(555) 111-2222',  Inactive__c = false );
        insert testContact;

        //Act
        List<ExternalPartnerPortalController.ContactDataTableRowViewModel> retrievedList = ExternalPartnerPortalController.GetContactsByAccount(testAccount.Id);
        string actual = retrievedList[0].Email;

        //Assert
        system.AssertEquals(expected, actual);

    }

    @isTest static void TestGetContactsByAccount_InactiveIsNull_InactiveEqualsNo()
    {
        //Arrange
        string expected = 'No';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, AccountId = testAccount.Id, FirstName = 'Lorem', LastName = 'Ipsum', Title = 'Lorem Ipsum', Phone = '(555) 111-2222',  Email = 'TestContact@TestAccount.edu');
        insert testContact;

        //Act
        List<ExternalPartnerPortalController.ContactDataTableRowViewModel> retrievedList = ExternalPartnerPortalController.GetContactsByAccount(testAccount.Id);
        string actual = retrievedList[0].Inactive;

        //Assert
        system.AssertEquals(expected, actual);

    }

    @isTest static void TestGetContactsByAccount_Success()
    {
        //Arrange
        integer expected = 1;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, AccountId = testAccount.Id, FirstName = 'Lorem', LastName = 'Ipsum', Title = 'Lorem Ipsum', Phone = '(555) 111-2222',  Email = 'TestContact@TestAccount.edu', Inactive__c = true);
        insert testContact;

        //Act
        List<ExternalPartnerPortalController.ContactDataTableRowViewModel> retrievedList = ExternalPartnerPortalController.GetContactsByAccount(testAccount.Id);
        integer actual = retrievedList.size();

        //Assert
        system.AssertEquals(expected, actual);

    }

    @isTest static void TestGetFindings()
    {
        //Arrange
        integer expected = 2;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        
        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c testComplaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint;
        
        Referral__c referral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');


        Finding__c finding1 = new Finding__c(Referral__c = referral.Id, Complaint__c = testComplaint.Id, Secondary_Referral__c = 'No', Site_Visit_Conducted__c = 'No', Reason_for_No_Site_Visit__c = 'Complaint is outside agency jurisdiction', Violations_or_Compliance_Issues__c = 'No', Is_Enforcement_Complete__c = 'Yes');    
        insert finding1;

        Finding__c finding2 = new Finding__c(Referral__c = referral.Id, Complaint__c = testComplaint.Id, Secondary_Referral__c = 'No', Site_Visit_Conducted__c = 'No', Reason_for_No_Site_Visit__c = 'Complaint is outside agency jurisdiction', Violations_or_Compliance_Issues__c = 'No', Is_Enforcement_Complete__c = 'Yes');    
        insert finding2;
        
        //Act
        List<Finding__c> retrievedFindings = ExternalPartnerPortalController.GetFindings(testAccount.Id);
        integer actual = retrievedFIndings.Size();
        
        //Assert
        system.assertEquals(expected, actual);
    }

    @isTest static void TestGetReferralsAll()
    {
        //Arrange
        integer expected = 2;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact1 = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account1', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact1@TestAccount.edu' );
        insert testContact1;
        Contact testContact2 = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account2', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact2@TestAccount.edu' );
        insert testContact2;
        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c testComplaint1 = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint1;
        Complaints__c testComplaint2 = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint2;
        Referral__c testReferral1 = new Referral__c(Complaint__c = testComplaint1.Id, External_Partner__c = testAccount.Id);
        insert testReferral1;
        ReferralContact__c testReferralContact1 = new ReferralContact__c(Referral__c = testReferral1.Id, Contact__c = testContact1.Id);
        insert testReferralContact1;
        Referral__c testReferral2 = new Referral__c(Complaint__c = testComplaint2.Id, External_Partner__c = testAccount.Id);
        insert testReferral2;
        ReferralContact__c testReferralContact2 = new ReferralContact__c(Referral__c = testReferral2.Id, Contact__c = testContact2.Id);
        insert testReferralContact2;    
        //Act
        List<ExternalPartnerPortalController.ExternalPartnerLandingScreenViewModel> retrievedReferralDataTableViewModels = ExternalPartnerPortalController.GetReferrals(testAccount.Id, '');
        integer actual = retrievedReferralDataTableViewModels.Size();
        //Assert
        system.assertEquals(expected, actual);
    }

    @isTest static void TestGetReferralsAwaitingFindings()
    {
        //Arrange
        integer expected = 2;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact1 = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account1', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact1@TestAccount.edu' );
        insert testContact1;
        Contact testContact2 = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account2', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact2@TestAccount.edu' );
        insert testContact2;
        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c testComplaint1 = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint1;
        Complaints__c testComplaint2 = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint2;
        Referral__c testReferral1 = new Referral__c(Complaint__c = testComplaint1.Id, External_Partner__c = testAccount.Id);
        insert testReferral1;
        ReferralContact__c testReferralContact1 = new ReferralContact__c(Referral__c = testReferral1.Id, Contact__c = testContact1.Id);
        insert testReferralContact1;
        Referral__c testReferral2 = new Referral__c(Complaint__c = testComplaint2.Id, External_Partner__c = testAccount.Id);
        insert testReferral2;
        ReferralContact__c testReferralContact2 = new ReferralContact__c(Referral__c = testReferral2.Id, Contact__c = testContact2.Id);
        insert testReferralContact2;    
        //Act
        List<ExternalPartnerPortalController.ExternalPartnerLandingScreenViewModel> retrievedReferralDataTableViewModels = ExternalPartnerPortalController.GetReferrals(testAccount.Id, 'Awaiting Findings');
        integer actual = retrievedReferralDataTableViewModels.Size();
        //Assert
        system.assertEquals(expected, actual);
    }

    @isTest static void TestGetReferralsFindingsReceived()
    {
        //Arrange
        integer expected = 1;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact1 = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account1', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact1@TestAccount.edu' );
        insert testContact1;
        Contact testContact2 = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account2', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact2@TestAccount.edu' );
        insert testContact2;
        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c testComplaint1 = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint1;
        Complaints__c testComplaint2 = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint2;
        Referral__c testReferral1 = new Referral__c(Complaint__c = testComplaint1.Id, External_Partner__c = testAccount.Id);
        insert testReferral1;
        ReferralContact__c testReferralContact1 = new ReferralContact__c(Referral__c = testReferral1.Id, Contact__c = testContact1.Id);
        insert testReferralContact1;
        Referral__c testReferral2 = new Referral__c(Complaint__c = testComplaint2.Id, External_Partner__c = testAccount.Id);
        insert testReferral2;
        ReferralContact__c testReferralContact2 = new ReferralContact__c(Referral__c = testReferral2.Id, Contact__c = testContact2.Id);
        insert testReferralContact2;    
        testReferral2.Status__c = 'Findings Received';
        update testReferral2;
        //Act
        List<ExternalPartnerPortalController.ExternalPartnerLandingScreenViewModel> retrievedReferralDataTableViewModels = ExternalPartnerPortalController.GetReferrals(testAccount.Id, 'Findings Received');
        integer actual = retrievedReferralDataTableViewModels.Size();
        //Assert
        system.assertEquals(expected, actual);
    }

    @isTest static void TestGetResetEmailBody()
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        string retrieved = controller.GetResetEmailBody('TestName', 'TestURL');
        
        //Assert
        system.Assert(retrieved.Contains('TestName'), 'Name Not Found');
        system.Assert(retrieved.Contains('TestURL'), 'URL Not Found');
    }

    @isTest static void TestGotoLogin()
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        PageReference expected = Page.ExternalPartnerLogin;
        expected.setRedirect(true);
        //expected.getParameters().put('e','f');

        //Act
        PageReference actual = controller.GotoLogin();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestLogin_ContactDoesntExist_ExpectError()
    {
        //Arrange
        string expected = 'There was an error with your Email/Password combination.  Please Try Again.';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'test@test.com';        
        controller.ExternalPartnerLoginViewModel.Password = 'testpassword';
        try
        {
            //Act
            controller.Login();

        }
        catch(Exception ex)
        {
            string actual = ex.GetMessage();
            //Assert
            system.assertEquals(expected, actual);
        }
    }

    @isTest static void TestLogin_ContactLockedOut_ExpectError()
    {
        //Arrange
        string expected = 'Your account is locked out. Please reset your password to continue.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Account', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = 'jdklfjaklsf', Email = 'TestContact@TestAccount.edu', Is_Locked_Out__c = true );
        insert testContact;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'testpassword';
        try
        {
            //Act
            controller.Login();

        }
        catch(Exception ex)
        {
            string actual = ex.GetMessage();
            //Assert
            system.assertEquals(expected, actual);
        }
    }

    @isTest static void TestLogin_SuccessSingleAccount_VerifyCookieAndPageReference()
    {
        //Arrange
        boolean expectedIsLoggedIn = true;
        string expectedUsersName = 'Test Contact';
        integer expectedExternalPartnerCount = 1;
        string expectedExternalPartnerName = 'Test Account';
        PageReference expectedPageReference = Page.ExternalPartnerLandingScreen;
        expectedPageReference.setRedirect(true);

        boolean expectedCookieExists = true;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        string expectedExternalPartnerId = testAccount.Id;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact@TestAccount.edu' );
        insert testContact;
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'testpassword';

        //Act
        PageReference actualPageReference = controller.Login();
        boolean actualIsLoggedIn = controller.Authentication.IsLoggedIn;
        string actualUsersName = controller.Authentication.UsersName;
        string actualUserId = controller.Authentication.UserId;
        integer actualExternalPartnerCount = controller.Authentication.ExternalPartners.size();
        string actualExternalPartnerName = controller.Authentication.ExternalPartnerName;
        string actualExternalPartnerId = controller.Authentication.ExternalPartnerId;
        boolean actualCookieExists =  ApexPages.currentPage().getCookies().get('AuthenticationModel') != null;
        //Assert
        system.assertEquals(expectedIsLoggedIn, actualIsLoggedIn);
        system.assertEquals(expectedUsersName, actualUsersName);
        system.assertEquals(expectedUserId, actualUserId);
        system.assertEquals(expectedExternalPartnerCount, actualExternalPartnerCount);
        system.assertEquals(expectedExternalPartnerName, actualExternalPartnerName);
        system.assertEquals(expectedExternalPartnerId, actualExternalPartnerId);
        system.assertEquals(expectedCookieExists, actualCookieExists);
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestLogin_SuccessMultipleAccount_VerifyCookieAndPageReference()
    {
        //Arrange
        boolean expectedIsLoggedIn = true;
        string expectedUsersName = 'Test Contact';
        PageReference expectedPageReference = Page.ExternalPartnerAccountSelector;
        expectedPageReference.setRedirect(true);

        boolean expectedCookieExists = true;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount1 = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account1');
        insert testAccount1;
        Account testAccount2 = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account2');
        insert testAccount2;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact1 = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount1.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact1@TestAccount.edu' );
        insert testContact1;

        AccountContactRelation accountContactRelation = new AccountContactRelation();
        accountContactRelation.ContactId = testContact1.Id;
        accountContactRelation.AccountId = testAccount2.Id;
        insert accountContactRelation;

        
        
        string expectedUserId = testContact1.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact1@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'testpassword';

        //Act
        PageReference actualPageReference = controller.Login();
        boolean actualIsLoggedIn = controller.Authentication.IsLoggedIn;
        string actualUsersName = controller.Authentication.UsersName;
        string actualUserId = controller.Authentication.UserId;
        boolean actualCookieExists =  ApexPages.currentPage().getCookies().get('AuthenticationModel') != null;
        //Assert
        system.assertEquals(expectedIsLoggedIn, actualIsLoggedIn);
        system.assertEquals(expectedUsersName, actualUsersName);
        system.assertEquals(expectedUserId, actualUserId);
        system.assertEquals(expectedCookieExists, actualCookieExists);
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestLogin_IncorrectCredentialsFirstAttempt()
    {
        //Arrange
        decimal expectedIncorrectAttemptCount = 1;
        boolean expectedIsLockedOut = false;
        DateTime expectedTimeOfFirstFailedAttempt = Date.valueOf('2017-01-01 00:00:00');
        PageReference expectedPageReference = null;
        string expectedLoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact@TestAccount.edu' );
        insert testContact;
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController, Date.valueOf('2017-01-01 00:00:00'));
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'dfafdasfdasfdsf';

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.Login();
        Test.stopTest();
        Contact retrievedContact = [SELECT Incorrect_Attempt_Count__c, Time_of_First_Failed_Attempt__c, Is_Locked_Out__c FROM Contact Where Id =: testContact.Id];
        decimal actualIncorrectAttemptCount = retrievedContact.Incorrect_Attempt_Count__c;
        boolean actualIsLockedOut = retrievedContact.Is_Locked_Out__c;
        DateTime actualTimeOfFirstFailedAttempt = retrievedContact.Time_of_First_Failed_Attempt__c;
        string actualLoginError = controller.ExternalPartnerLoginViewModel.LoginError;
        //Assert
        system.assertEquals(expectedIncorrectAttemptCount, actualIncorrectAttemptCount);
        system.assertEquals(expectedIsLockedOut, actualIsLockedOut);
        system.assertEquals(expectedTimeOfFirstFailedAttempt, actualTimeOfFirstFailedAttempt);      
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedLoginError, actualLoginError);
    }

    @isTest static void TestLogin_IncorrectCredentialsSecondAttempt()
    {
        //Arrange
        decimal expectedIncorrectAttemptCount = 2;
        boolean expectedIsLockedOut = false;
        DateTime expectedTimeOfFirstFailedAttempt = Date.valueOf('2017-01-01 00:00:00');
        PageReference expectedPageReference = null;
        string expectedLoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact@TestAccount.edu' );
        insert testContact;
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController, Date.valueOf('2017-01-01 00:00:00'));
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'dfafdasfdasfdsf';

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        Test.stopTest();
        Contact retrievedContact = [SELECT Incorrect_Attempt_Count__c, Time_of_First_Failed_Attempt__c, Is_Locked_Out__c FROM Contact Where Id =: testContact.Id];
        decimal actualIncorrectAttemptCount = retrievedContact.Incorrect_Attempt_Count__c;
        boolean actualIsLockedOut = retrievedContact.Is_Locked_Out__c;
        DateTime actualTimeOfFirstFailedAttempt = retrievedContact.Time_of_First_Failed_Attempt__c;
        string actualLoginError = controller.ExternalPartnerLoginViewModel.LoginError;

        //Assert
        system.assertEquals(expectedIncorrectAttemptCount, actualIncorrectAttemptCount);
        system.assertEquals(expectedIsLockedOut, actualIsLockedOut);
        system.assertEquals(expectedTimeOfFirstFailedAttempt, actualTimeOfFirstFailedAttempt);
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedLoginError, actualLoginError);
    }

    @isTest static void TestLogin_IncorrectCredentialsThirdAttempt()
    {
        //Arrange
        decimal expectedIncorrectAttemptCount = 3;
        boolean expectedIsLockedOut = false;
        DateTime expectedTimeOfFirstFailedAttempt = Date.valueOf('2017-01-01 00:00:00');
        PageReference expectedPageReference = null;
        string expectedLoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact@TestAccount.edu' );
        insert testContact;
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController, Date.valueOf('2017-01-01 00:00:00'));
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'dfafdasfdasfdsf';

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        Test.stopTest();
        Contact retrievedContact = [SELECT Incorrect_Attempt_Count__c, Time_of_First_Failed_Attempt__c, Is_Locked_Out__c FROM Contact Where Id =: testContact.Id];
        decimal actualIncorrectAttemptCount = retrievedContact.Incorrect_Attempt_Count__c;
        boolean actualIsLockedOut = retrievedContact.Is_Locked_Out__c;
        DateTime actualTimeOfFirstFailedAttempt = retrievedContact.Time_of_First_Failed_Attempt__c;
        string actualLoginError = controller.ExternalPartnerLoginViewModel.LoginError;

        //Assert
        system.assertEquals(expectedIncorrectAttemptCount, actualIncorrectAttemptCount);
        system.assertEquals(expectedIsLockedOut, actualIsLockedOut);
        system.assertEquals(expectedTimeOfFirstFailedAttempt, actualTimeOfFirstFailedAttempt);
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedLoginError, actualLoginError);
    }

    @isTest static void TestLogin_IncorrectCredentialsFourthAttempt()
    {
        //Arrange
        decimal expectedIncorrectAttemptCount = 4;
        boolean expectedIsLockedOut = false;
        DateTime expectedTimeOfFirstFailedAttempt = Date.valueOf('2017-01-01 00:00:00');
        PageReference expectedPageReference = null;
        string expectedLoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact@TestAccount.edu' );
        insert testContact;
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController, Date.valueOf('2017-01-01 00:00:00'));
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'dfafdasfdasfdsf';

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        Test.stopTest();
        Contact retrievedContact = [SELECT Incorrect_Attempt_Count__c, Time_of_First_Failed_Attempt__c, Is_Locked_Out__c FROM Contact Where Id =: testContact.Id];
        decimal actualIncorrectAttemptCount = retrievedContact.Incorrect_Attempt_Count__c;
        boolean actualIsLockedOut = retrievedContact.Is_Locked_Out__c;
        DateTime actualTimeOfFirstFailedAttempt = retrievedContact.Time_of_First_Failed_Attempt__c;
        string actualLoginError = controller.ExternalPartnerLoginViewModel.LoginError;

        //Assert
        system.assertEquals(expectedIncorrectAttemptCount, actualIncorrectAttemptCount);
        system.assertEquals(expectedIsLockedOut, actualIsLockedOut);
        system.assertEquals(expectedTimeOfFirstFailedAttempt, actualTimeOfFirstFailedAttempt);
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedLoginError, actualLoginError);
    }

    @isTest static void TestLogin_IncorrectCredentialsFifthAttempt()
    {
        //Arrange
        decimal expectedIncorrectAttemptCount = 0;
        boolean expectedIsLockedOut = true;
        DateTime expectedTimeOfFirstFailedAttempt = Date.valueOf('2016-01-01 00:00:00');
        PageReference expectedPageReference = null;
        string expectedLoginError = 'Your account has been locked out. Please wait 20 minutes and try again or reset your password.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact@TestAccount.edu' );
        insert testContact;
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController, Date.valueOf('2017-01-01 00:00:00'));
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'dfafdasfdasfdsf';

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        actualPageReference = controller.Login();
        
        Test.stopTest();
        Contact retrievedContact = [SELECT Incorrect_Attempt_Count__c, Time_of_First_Failed_Attempt__c, Is_Locked_Out__c FROM Contact Where Id =: testContact.Id];
        decimal actualIncorrectAttemptCount = retrievedContact.Incorrect_Attempt_Count__c;
        boolean actualIsLockedOut = retrievedContact.Is_Locked_Out__c;
        DateTime actualTimeOfFirstFailedAttempt = retrievedContact.Time_of_First_Failed_Attempt__c;
        string actualLoginError = controller.ExternalPartnerLoginViewModel.LoginError;

        //Assert
        system.assertEquals(expectedIncorrectAttemptCount, actualIncorrectAttemptCount);
        system.assertEquals(expectedIsLockedOut, actualIsLockedOut);
        system.assertEquals(expectedTimeOfFirstFailedAttempt, actualTimeOfFirstFailedAttempt);
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedLoginError, actualLoginError);
    }

    @isTest static void TestLogin_IncorrectCredentialsSecondAttemptButAfterMoreThan20Minutes()
    {
        //Arrange
        decimal expectedIncorrectAttemptCount = 1;
        boolean expectedIsLockedOut = false;
        DateTime expectedTimeOfFirstFailedAttempt = Date.valueOf('2017-01-01 00:00:00');
        PageReference expectedPageReference = null;
        string expectedLoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Blob passwordBlob = Blob.valueOf('testpassword');
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, PasswordHash__c = passwordHashString, Email = 'TestContact@TestAccount.edu', Incorrect_Attempt_Count__c = 1, Time_of_First_Failed_Attempt__c = Date.valueOf('2016-06-30 00:00:00') );
        insert testContact;
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController, Date.valueOf('2017-01-01 00:00:00'));
        controller.ExternalPartnerLoginViewModel = new ExternalPartnerPortalController.ExternalPartnerLoginViewModel();
        controller.ExternalPartnerLoginViewModel.EmailAddress = 'TestContact@TestAccount.edu';        
        controller.ExternalPartnerLoginViewModel.Password = 'dfafdasfdasfdsf';

        //Act
        Test.startTest();
        PageReference actualPageReference = controller.Login();
        Test.stopTest();
        Contact retrievedContact = [SELECT Incorrect_Attempt_Count__c, Time_of_First_Failed_Attempt__c, Is_Locked_Out__c FROM Contact Where Id =: testContact.Id];
        decimal actualIncorrectAttemptCount = retrievedContact.Incorrect_Attempt_Count__c;
        boolean actualIsLockedOut = retrievedContact.Is_Locked_Out__c;
        DateTime actualTimeOfFirstFailedAttempt = retrievedContact.Time_of_First_Failed_Attempt__c;
        string actualLoginError = controller.ExternalPartnerLoginViewModel.LoginError;

        //Assert
        system.assertEquals(expectedIncorrectAttemptCount, actualIncorrectAttemptCount);
        system.assertEquals(expectedIsLockedOut, actualIsLockedOut);
        system.assertEquals(expectedTimeOfFirstFailedAttempt, actualTimeOfFirstFailedAttempt);
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedLoginError, actualLoginError);
    }

    @isTest static void TestLoadCompleteExternalPartnerResetPassword_MissingContactId_LoadLogin()
    {
        //Arrange
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        PageReference expected = GetGoToLoginPageReference();

        //Act
        PageReference actual = controller.LoadCompleteExternalPartnerResetPassword();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadCompleteExternalPartnerResetPassword_MissingResetCode_LoadLogin()
    {
        //Arrange
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        PageReference expected = GetGoToLoginPageReference();
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SObjectType);
        ApexPages.currentPage().getParameters().put('contactId', fakeContactId); 
        
        //Act
        PageReference actual = controller.LoadCompleteExternalPartnerResetPassword();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadCompleteExternalPartnerResetPassword_InvalidContact_LoadLogin()
    {
        //Arrange
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        PageReference expected = GetGoToLoginPageReference();
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SObjectType);
        ApexPages.currentPage().getParameters().put('contactId', fakeContactId); 
        ApexPages.currentPage().getParameters().put('resetCode', 'fakeResetCode'); 
        
        //Act
        PageReference actual = controller.LoadCompleteExternalPartnerResetPassword();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadCompleteExternalPartnerResetPassword_InvalidResetCode_LoadLogin()
    {
        //Arrange
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        PageReference expected = GetGoToLoginPageReference();
        Account account = UnitTestHelper.CreateTestAccount();
        Contact contact = UnitTestHelper.CreateTestCalEPAPartnerContact(account.Id, 'TestContact@TestAccount.edu');
        ApexPages.currentPage().getParameters().put('contactId', contact.Id); 
        ApexPages.currentPage().getParameters().put('resetCode', 'fakeResetCode'); 
        
        //Act
        PageReference actual = controller.LoadCompleteExternalPartnerResetPassword();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadCompleteExternalPartnerResetPassword_ValidResetCode_LoadPage()
    {
        //Arrange
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        PageReference expected = null;
        Account account = UnitTestHelper.CreateTestAccount();
        Contact contact = UnitTestHelper.CreateTestCalEPAPartnerContact(account.Id, 'TestContact@TestAccount.edu');
        contact.Reset_Code__c = 'test';
        update contact;
        ApexPages.currentPage().getParameters().put('contactId', contact.Id); 
        ApexPages.currentPage().getParameters().put('resetCode', 'test'); 
        
        //Act
        PageReference actual = controller.LoadCompleteExternalPartnerResetPassword();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadCreate_MissingReferralIdAndComplaintIdAndAccountId_GotoLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();      

        //Act
        PageReference actual = controller.LoadCreate();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadCreate_ComplaintIdButMissingAccountId_GotoLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();

        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        ApexPages.currentPage().getParameters().put('complaintId', fakeComplaintId); 

        //Act
        PageReference actual = controller.LoadCreate();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestLoadCreate_ReferralInvalidReferralId_GotoLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();

        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        string fakeReferralId = UnitTestHelper.GetFakeId(Referral__c.SObjectType);
        ApexPages.currentPage().getParameters().put('referralId', fakeReferralId); 
        
        //Act
        PageReference actual = controller.LoadCreate();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestLoadCreate_ReferralValidReferral_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;

        integer expectedContactCount = 4;
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        string expectedExternalPartnerId = testAccount.Id;
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact1@TestAccount.edu');               
        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact2@TestAccount.edu');
        

        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        string expectedComplaintId = testComplaint.Id;
        string expectedComplaintName = [SELECT Id, Name FROM Complaints__c WHERE Id =: testComplaint.Id ].Name;
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        string exptectedReferralId = testReferral.Id;
        ApexPages.currentPage().getParameters().put('referralId', testReferral.Id); 
        
        string expectedContactValue0 = '';
        string expectedContactValue1 = testContact1.Id;
        string expectedContactValue2 = testContact2.Id;
        string expectedContactValue3 = '';

        Contact retrievedContact1 = [SELECT Id, Name FROM Contact Where Id =: testContact1.Id ];
        Contact retrievedContact2 = [SELECT Id, Name FROM Contact Where Id =: testContact2.Id ];

        string expectedContactLabel0 = '';
        string expectedContactLabel1 = retrievedContact1.Name;
        string expectedContactLabel2 = retrievedContact2.Name;
        string expectedContactLabel3 = 'I am a new contact';

        //Act
        PageReference actualPageReference = controller.LoadCreate();
        string actualReferralId = controller.CreateFindingsViewModel.ReferralId;
        string actualExternalPartnerId = controller.CreateFindingsViewModel.ExternalPartnerId;
        string actualComplaintId = controller.CreateFindingsViewModel.ComplaintId;
        string actualComplaintName = controller.CreateFindingsViewModel.ComplaintName;
        integer actualContactCount = controller.CreateFindingsViewModel.Contacts.Size();
        string actualContactValue0 = controller.CreateFindingsViewModel.Contacts[0].GetValue();
        string actualContactValue1 = controller.CreateFindingsViewModel.Contacts[1].GetValue();
        string actualContactValue2 = controller.CreateFindingsViewModel.Contacts[2].GetValue();
        string actualContactValue3 = controller.CreateFindingsViewModel.Contacts[3].GetValue();
        string actualContactLabel0 = controller.CreateFindingsViewModel.Contacts[0].GetLabel();
        string actualContactLabel1 = controller.CreateFindingsViewModel.Contacts[1].GetLabel();
        string actualContactLabel2 = controller.CreateFindingsViewModel.Contacts[2].GetLabel();
        string actualContactLabel3 = controller.CreateFindingsViewModel.Contacts[3].GetLabel();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(exptectedReferralId, actualReferralId);
        system.assertEquals(expectedExternalPartnerId, actualExternalPartnerId);
        system.assertEquals(expectedComplaintId, actualComplaintId);
        system.assertEquals(expectedComplaintName, actualComplaintName);
        system.assertEquals(expectedContactCount, actualContactCount);
        
        system.assertEquals(expectedContactValue0, actualContactValue0);
        system.assertEquals(expectedContactValue1, actualContactValue1);
        system.assertEquals(expectedContactValue2, actualContactValue2);
        system.assertEquals(expectedContactValue3, actualContactValue3);

        system.assertEquals(expectedContactLabel0, actualContactLabel0);
        system.assertEquals(expectedContactLabel1, actualContactLabel1);
        system.assertEquals(expectedContactLabel2, actualContactLabel2);
        system.assertEquals(expectedContactLabel3, actualContactLabel3);
    }

    @isTest static void TestLoadCreate_ComplaintInvalidComplaintId_GotoLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();

        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        ApexPages.currentPage().getParameters().put('complaintId', fakeComplaintId); 
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        ApexPages.currentPage().getParameters().put('accountId', fakeAccountId); 

        
        //Act
        PageReference actual = controller.LoadCreate();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);


    }

    @isTest static void TestLoadCreate_ComplaintInvalidAccountId_GotoLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();

        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        ApexPages.currentPage().getParameters().put('complaintId', testComplaint.Id); 
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        ApexPages.currentPage().getParameters().put('accountId', fakeAccountId); 

        
        //Act
        PageReference actual = controller.LoadCreate();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestLoadCreate_ComplaintValidComplaint_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;

        integer expectedContactCount = 4;
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        string expectedExternalPartnerId = testAccount.Id;
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact1@TestAccount.edu');               
        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact2@TestAccount.edu');
        

        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        string expectedComplaintId = testComplaint.Id;
        string expectedComplaintName = [SELECT Id, Name FROM Complaints__c WHERE Id =: testComplaint.Id ].Name;
        ApexPages.currentPage().getParameters().put('complaintId', testComplaint.Id); 
        ApexPages.currentPage().getParameters().put('accountId', testAccount.Id); 
        
        string expectedContactValue0 = '';
        string expectedContactValue1 = testContact1.Id;
        string expectedContactValue2 = testContact2.Id;
        string expectedContactValue3 = '';

        Contact retrievedContact1 = [SELECT Id, Name FROM Contact Where Id =: testContact1.Id ];
        Contact retrievedContact2 = [SELECT Id, Name FROM Contact Where Id =: testContact2.Id ];

        string expectedContactLabel0 = '';
        string expectedContactLabel1 = retrievedContact1.Name;
        string expectedContactLabel2 = retrievedContact2.Name;
        string expectedContactLabel3 = 'I am a new contact';

        //Act
        PageReference actualPageReference = controller.LoadCreate();
        string actualExternalPartnerId = controller.CreateFindingsViewModel.ExternalPartnerId;
        string actualComplaintId = controller.CreateFindingsViewModel.ComplaintId;
        string actualComplaintName = controller.CreateFindingsViewModel.ComplaintName;
        integer actualContactCount = controller.CreateFindingsViewModel.Contacts.Size();
        string actualContactValue0 = controller.CreateFindingsViewModel.Contacts[0].GetValue();
        string actualContactValue1 = controller.CreateFindingsViewModel.Contacts[1].GetValue();
        string actualContactValue2 = controller.CreateFindingsViewModel.Contacts[2].GetValue();
        string actualContactValue3 = controller.CreateFindingsViewModel.Contacts[3].GetValue();
        string actualContactLabel0 = controller.CreateFindingsViewModel.Contacts[0].GetLabel();
        string actualContactLabel1 = controller.CreateFindingsViewModel.Contacts[1].GetLabel();
        string actualContactLabel2 = controller.CreateFindingsViewModel.Contacts[2].GetLabel();
        string actualContactLabel3 = controller.CreateFindingsViewModel.Contacts[3].GetLabel();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedExternalPartnerId, actualExternalPartnerId);
        system.assertEquals(expectedComplaintId, actualComplaintId);
        system.assertEquals(expectedComplaintName, actualComplaintName);
        system.assertEquals(expectedContactCount, actualContactCount);
        
        system.assertEquals(expectedContactValue0, actualContactValue0);
        system.assertEquals(expectedContactValue1, actualContactValue1);
        system.assertEquals(expectedContactValue2, actualContactValue2);
        system.assertEquals(expectedContactValue3, actualContactValue3);

        system.assertEquals(expectedContactLabel0, actualContactLabel0);
        system.assertEquals(expectedContactLabel1, actualContactLabel1);
        system.assertEquals(expectedContactLabel2, actualContactLabel2);
        system.assertEquals(expectedContactLabel3, actualContactLabel3);        
    }

    @isTest static void TestLoadExternalPartnerAccountProfile_AuthenticationNotLoggedIn_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = false;
        authentication.UsersName = testContact.Name;
        authentication.UserId = testContact.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestLoadExternalPartnerAccountProfile_AuthenticationUserIdNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact.Name;
        authentication.UserId = null;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestLoadExternalPartnerAccountProfile_AuthenticationExternalPartnerNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact.Name;
        authentication.UserId = testContact.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestLoadExternalPartnerAccountProfile_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        Account testAccount = UnitTestHelper.CreateTestAccount();
        string expectedAccountId = testAccount.Id;
        string expectedAccountName = testAccount.Name;
        testAccount.Phone = '(555) 111-2222';
        string expectedPhone = '(555) 111-2222';
        testAccount.Fax = '(111) 333-0000';
        string expectedFax = '(111) 333-0000';
        testAccount.Website = 'http://www.testaccount.com';
        string expectedWebsite = 'http://www.testaccount.com';
        testAccount.ShippingCity = 'MyCity';
        string expectedShippingCity = 'MyCity';
        testAccount.ShippingPostalCode = '00000';
        string expectedShippingPostalCode = '00000';
        testAccount.ShippingStreet = '123 Main Street';
        string expectedShippingStreet = '123 Main Street';
        update testAccount;

        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact.Name;
        authentication.UserId = testContact.Id;
        authentication.ExternalPartnerId = testAccount.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountProfile();
        string actualAccountId = controller.ExternalPartnerAccountProfileViewModel.AccountId;
        string actualAccountName = controller.ExternalPartnerAccountProfileViewModel.Name;
        string actualPhone = controller.ExternalPartnerAccountProfileViewModel.Phone; 
        string actualFax = controller.ExternalPartnerAccountProfileViewModel.Fax; 
        string actualWebsite = controller.ExternalPartnerAccountProfileViewModel.Website; 
        string actualShippingCity = controller.ExternalPartnerAccountProfileViewModel.ShippingCity; 
        string actualShippingPostalCode = controller.ExternalPartnerAccountProfileViewModel.ShippingPostalCode; 
        string actualShippingStreet = controller.ExternalPartnerAccountProfileViewModel.ShippingStreet;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.AssertEquals(expectedAccountId, actualAccountId);        
        system.AssertEquals(expectedAccountName, actualAccountName);
        system.AssertEquals(expectedPhone, actualPhone);
        system.AssertEquals(expectedFax, actualFax);
        system.AssertEquals(expectedWebsite, actualWebsite);
        system.AssertEquals(expectedShippingCity, actualShippingCity);
        system.AssertEquals(expectedShippingPostalCode, actualShippingPostalCode);
        system.AssertEquals(expectedShippingStreet, actualShippingStreet);
    }

    @isTest static void TestLoadExternalPartnerContactProfile_AuthenticationNotLoggedIn_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = false;
        authentication.UsersName = testContact.Name;
        authentication.UserId = testContact.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerContactProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestLoadExternalPartnerContactProfile_AuthenticationUserIdNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact.Name;
        authentication.UserId = null;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerContactProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestLoadExternalPartnerContactProfile_CurrentUser_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        string expectedContactId = testContact.Id;
        string expectedFirstName = testContact.FirstName;
        string expectedLastName = testContact.LastName;
        string expectedEmail = testContact.Email.ToLowercase();
        testContact.Phone = '(555) 111-2222';
        string expectedPhone = '(555) 111-2222';
        testContact.Title = 'My Title';
        string expectedTitle = 'My Title';
        testContact.Inactive__c = false;
        boolean expectedInactive = false;
        update testContact;     
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact.Name;
        authentication.UserId = testContact.Id;
        authentication.ExternalPartnerId = testAccount.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerContactProfile();
        string actualContactId = controller.ExternalPartnerContactProfileViewModel.ContactId;
        string actualFirstName = controller.ExternalPartnerContactProfileViewModel.FirstName;
        string actualLastName = controller.ExternalPartnerContactProfileViewModel.LastName; 
        string actualEmail = controller.ExternalPartnerContactProfileViewModel.Email; 
        string actualPhone = controller.ExternalPartnerContactProfileViewModel.Phone; 
        string actualTitle = controller.ExternalPartnerContactProfileViewModel.Title; 
        boolean actualInactive = controller.ExternalPartnerContactProfileViewModel.Inactive; 

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.AssertEquals(expectedContactId, actualContactId);        
        system.AssertEquals(expectedFirstName, actualFirstName);
        system.AssertEquals(expectedLastName, actualLastName);
        system.AssertEquals(expectedEmail, actualEmail);
        system.AssertEquals(expectedPhone, actualPhone);
        system.AssertEquals(expectedTitle, actualTitle);
        system.AssertEquals(expectedInactive, actualInactive);
    }

    @isTest static void TestLoadExternalPartnerContactProfile_AnotherUser_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact1@TestAccount.edu');
        string expectedContactId = testContact1.Id;
        string expectedFirstName = testContact1.FirstName;
        string expectedLastName = testContact1.LastName;
        string expectedEmail = testContact1.Email.ToLowercase();
        testContact1.Phone = '(555) 111-2222';
        string expectedPhone = '(555) 111-2222';
        testContact1.Title = 'My Title';
        string expectedTitle = 'My Title';
        testContact1.Inactive__c = false;
        boolean expectedInactive = false;
        update testContact1;        
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        

        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact2@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact2.Name;
        authentication.UserId = testContact2.Id;
        authentication.ExternalPartnerId = testAccount.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        ApexPages.currentPage().getParameters().put('contactId', testContact1.Id);

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerContactProfile();
        string actualContactId = controller.ExternalPartnerContactProfileViewModel.ContactId;
        string actualFirstName = controller.ExternalPartnerContactProfileViewModel.FirstName;
        string actualLastName = controller.ExternalPartnerContactProfileViewModel.LastName; 
        string actualEmail = controller.ExternalPartnerContactProfileViewModel.Email; 
        string actualPhone = controller.ExternalPartnerContactProfileViewModel.Phone; 
        string actualTitle = controller.ExternalPartnerContactProfileViewModel.Title; 
        boolean actualInactive = controller.ExternalPartnerContactProfileViewModel.Inactive; 

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.AssertEquals(expectedContactId, actualContactId);        
        system.AssertEquals(expectedFirstName, actualFirstName);
        system.AssertEquals(expectedLastName, actualLastName);
        system.AssertEquals(expectedEmail, actualEmail);
        system.AssertEquals(expectedPhone, actualPhone);
        system.AssertEquals(expectedTitle, actualTitle);
        system.AssertEquals(expectedInactive, actualInactive);
    }

    @isTest static void TestLoadExternalPartnerResetPassword()
    {
        //Arrange
        PageReference expectedPageReference = null;
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerResetPassword();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.Assert(controller.FindingsResetPasswordViewModel != null);
    }

    @isTest static void TestLoadExternalPartnerAccountCreation_NullComplaintId_GoToLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        
        //Act
        PageReference actual = controller.LoadExternalPartnerAccountCreation();

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadExternalPartnerAccountCreation_Success_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        string expectedComplaintId = testComplaint.Id;
        ApexPages.currentPage().getParameters().put('complaintId', testComplaint.Id);
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountCreation();
        string actualComplaintId = controller.ExternalPartnerAccountCreationViewModel.ComplaintId;
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedComplaintId, actualComplaintId);

    }

    @isTest static void TestExternalPartnerAccountSelector() 
    {
        //Arrange
        PageReference expected =  Page.ExternalPartnerAccountSelector;
        expected.setRedirect(true);
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
          
        //Act
        PageReference actual = controller.ExternalPartnerAccountSelector();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadExternalPartnerAccountSelector_AuthenticationNotLoggedIn_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = false;
        authentication.UsersName = testContact.Name;
        authentication.UserId = testContact.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountSelector();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);

    }

    @isTest static void TestLoadExternalPartnerAccountSelector_AuthenticationUserIdNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact.Name;
        authentication.UserId = null;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountSelector();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);

    }

    @isTest static void TestLoadExternalPartnerAccountSelector_AuthenticationInvalidUserId_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SObjectType);
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact.Name;
        authentication.UserId = fakeContactId;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountSelector();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);

    }

    @isTest static void TestLoadExternalPartnerAccountSelector_Success_LoadPage()
    {
        //Arrange
        //check options verify null pagereference and authentication cookie
        integer expectedContactCount = 3;
        PageReference expectedPageReference = null;
        ExternalPartnerPortalController controller = GetExternalPartnerPortalController();
        Account testAccount1 = UnitTestHelper.CreateTestAccount();
        testAccount1.Name = 'Test Account 1';
        update testAccount1;
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount1.Id, 'TestContact1@TestAccount.edu');
        Account testAccount2 = UnitTestHelper.CreateTestAccount();
        testAccount2.Name = 'Test Account 2';
        update testAccount2;

        AccountContactRelation accountContactRelation = new AccountContactRelation();
        accountContactRelation.ContactId = testContact1.Id;
        accountContactRelation.AccountId = testAccount2.Id;
        insert accountContactRelation;





        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = testContact1.Name;
        authentication.UserId = testContact1.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        string expectedContactLabel0 = '';
        string expectedContactLabel1 = testAccount1.Name;
        string expectedContactLabel2 = testAccount2.Name;
        string expectedContactValue0 = '';
        string expectedContactValue1 = testAccount1.Id;
        string expectedContactValue2 = testAccount2.Id;
        integer expectedCookieExternalPartnersCount = 2;
        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerAccountSelector();
        system.debug('ExternalPartnerAccountSelectorViewModel:  ' + controller.ExternalPartnerAccountSelectorViewModel);
        integer actualContactCount = controller.ExternalPartnerAccountSelectorViewModel.ExternalPartners.Size();
        string actualContactValue0 = controller.ExternalPartnerAccountSelectorViewModel.ExternalPartners[0].GetValue();
        string actualContactValue1 = controller.ExternalPartnerAccountSelectorViewModel.ExternalPartners[1].GetValue();
        string actualContactValue2 = controller.ExternalPartnerAccountSelectorViewModel.ExternalPartners[2].GetValue();
        string actualContactLabel0 = controller.ExternalPartnerAccountSelectorViewModel.ExternalPartners[0].GetLabel();
        string actualContactLabel1 = controller.ExternalPartnerAccountSelectorViewModel.ExternalPartners[1].GetLabel();
        string actualContactLabel2 = controller.ExternalPartnerAccountSelectorViewModel.ExternalPartners[2].GetLabel();
        Cookie retrievedCookie =  ApexPages.currentPage().getCookies().get('AuthenticationModel');
        ExternalPartnerPortalController.AuthenticationModel retrievedAuthenticationModel = (ExternalPartnerPortalController.AuthenticationModel)JSON.deserialize(retrievedCookie.getValue(), ExternalPartnerPortalController.AuthenticationModel.class);
        integer actualCookieExternalPartnersCount = retrievedAuthenticationModel.ExternalPartners.size();
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedContactCount, actualContactCount);
        system.assertEquals(expectedContactValue0, actualContactValue0);
        system.assertEquals(expectedContactValue1, actualContactValue1);
        system.assertEquals(expectedContactValue2, actualContactValue2);
        system.assertEquals(expectedContactLabel0, actualContactLabel0);
        system.assertEquals(expectedContactLabel1, actualContactLabel1);
        system.assertEquals(expectedContactLabel2, actualContactLabel2);
        system.assertEquals(expectedCookieExternalPartnersCount, actualCookieExternalPartnersCount);
    }

    @isTest static void TestLoadExternalPartnerCreatePassword_NullViewModel_GotoExternalPartnerRequestAccessPage()
    {
        //Arrange
        PageReference expected =  GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        //Act
        PageReference actual = controller.LoadExternalPartnerCreatePassword();
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }
    
    @isTest static void TestLoadExternalPartnerCreatePassword_ContactIdEmpty_GotoExternalPartnerRequestAccessPage()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        //Act
        PageReference actual = controller.LoadExternalPartnerCreatePassword();
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestLoadExternalPartnerCreatePassword_Success_LoadPage()
    {
        //Arrange
        PageReference expected = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'test@test.com');
        testContact.Reset_Code__c = 'test';
        update testContact;
        ApexPages.currentPage().getParameters().put('contactId', testContact.Id); 
        ApexPages.currentPage().getParameters().put('resetCode', testContact.Reset_Code__c); 
        //Act
        PageReference actual = controller.LoadExternalPartnerCreatePassword();
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }
    
    @isTest static void TestLoadExternalPartnerLandingScreen_NotLoggedIn_GoToLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        PageReference actual = controller.LoadExternalPartnerLandingScreen();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestLoadExternalPartnerLandingScreen_LoggedIn_LoadPage()
    {
        //Arrange
        SimulateLogin();
        PageReference expected = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        PageReference actual = controller.LoadExternalPartnerLandingScreen();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }
        
    @isTest static void TestLoadFindingReferralSelector_ComplaintIdParameterNull_GoToLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        PageReference actual = controller.LoadFindingReferralSelector();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestLoadFindingReferralSelector_ComplaintDoesntExist_GotoLogin()
    {
        //Arrange
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        ApexPages.currentPage().getParameters().put('complaintId', fakeComplaintId); 
        PageReference expected = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        PageReference actual = controller.LoadFindingReferralSelector();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    
    @isTest static void TestLoadFindingReferralSelector_Success_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Complaints__c retrievedTestComplaint = [SELECT Id, Name FROM Complaints__c WHERE Id =: testComplaint.Id];
        string expectedComplaintId = retrievedTestComplaint.Id;
        string expectedComplaintNumber = retrievedTestComplaint.Name;
        ApexPages.currentPage().getParameters().put('complaintId', testComplaint.Id); 
        Account testAccount1 = UnitTestHelper.CreateTestAccount();
        testAccount1.Name = 'Test Account 1';
        update testAccount1;
        Account testAccount2 = UnitTestHelper.CreateTestAccount();
        testAccount2.Name = 'Test Account 2';
        update testAccount2;
        Contact testContact1 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount1.Id, 'TestContact1@TestAccount.edu');
        Contact testContact2 = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount2.Id, 'TestContact2@TestAccount.edu');      
        Referral__c testReferral1 = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount1.Id, testContact1.Id);
        Referral__c testReferral2 = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount2.Id, testContact2.Id);
        integer expectedExternalPartnersCount = 4;
        string expectedOption0Label = '';
        string expectedOption1Label = 'Test Account 1';
        string expectedOption2Label = 'Test Account 2';
        string expectedOption3Label = 'My Agency/Department is Not Listed';
        string expectedOption0Value = '';
        string expectedOption1Value = testReferral1.Id;
        string expectedOption2Value = testReferral2.Id;
        string expectedOption3Value = '';
        
        //Act
        PageReference actualPageReference = controller.LoadFindingReferralSelector();
        string actualComplaintId = controller.FindingReferralSelectorViewModel.ComplaintId;
        string actualComplaintNumber = controller.FindingReferralSelectorViewModel.ComplaintNumber;
        integer actualExternalPartnersCount = controller.FindingReferralSelectorViewModel.ExternalPartners.Size();
        string actualOption0Label = controller.FindingReferralSelectorViewModel.ExternalPartners[0].GetLabel();
        string actualOption1Label = controller.FindingReferralSelectorViewModel.ExternalPartners[1].GetLabel();
        string actualOption2Label = controller.FindingReferralSelectorViewModel.ExternalPartners[2].GetLabel();
        string actualOption3Label = controller.FindingReferralSelectorViewModel.ExternalPartners[3].GetLabel();
        string actualOption0Value = controller.FindingReferralSelectorViewModel.ExternalPartners[0].GetValue();
        string actualOption1Value = controller.FindingReferralSelectorViewModel.ExternalPartners[1].GetValue();
        string actualOption2Value = controller.FindingReferralSelectorViewModel.ExternalPartners[2].GetValue();
        string actualOption3Value = controller.FindingReferralSelectorViewModel.ExternalPartners[3].GetValue();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.AssertEquals(expectedComplaintId, actualComplaintId);
        system.AssertEquals(expectedComplaintNumber, actualComplaintNumber);
        system.AssertEquals(expectedExternalPartnersCount, actualExternalPartnersCount);
        system.AssertEquals(expectedOption0Label, actualOption0Label);
        system.AssertEquals(expectedOption1Label, actualOption1Label);
        system.AssertEquals(expectedOption2Label, actualOption2Label);
        system.AssertEquals(expectedOption3Label, actualOption3Label);
        system.AssertEquals(expectedOption0Value, actualOption0Value);
        system.AssertEquals(expectedOption1Value, actualOption1Value);
        system.AssertEquals(expectedOption2Value, actualOption2Value);
        system.AssertEquals(expectedOption3Value, actualOption3Value);
    }

    @isTest static void TestLoadExternalPartnerRequestAccess()
    {
        //Arrange
        PageReference expected = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        PageReference actual = controller.LoadExternalPartnerRequestAccess();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
        System.Assert(controller.ExternalPartnerRequestAccessViewModel != null);

    }

    @isTest static void TestLoadLogin()
    {
        //Arrange
        PageReference expected = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        PageReference actual = controller.LoadLogin();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
        System.Assert(controller.ExternalPartnerLoginViewModel != null);
    }

    @isTest static void TestLogout()
    {
        //Arrange
        SimulateLogin();
        PageReference expectedPageReference = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        boolean expectedIsLoggedIn = false;
        integer expectedExternalPartnerCount = 0;
        string expectedExternalPartnerName = null;
        string expectedExternalPartnerId = null;
        string expectedUsersName = null;
        string expectedUserId = null;


        //Act
        PageReference actualPageReference = controller.Logout();
        boolean actualIsLoggedIn = controller.Authentication.IsLoggedIn;
        integer actualExternalPartnerCount = controller.Authentication.ExternalPartners.size();
        string actualExternalPartnerName = controller.Authentication.ExternalPartnerName;
        string actualExternalPartnerId = controller.Authentication.ExternalPartnerId;
        string actualUsersName = controller.Authentication.UsersName;
        string actualUserId = controller.Authentication.UserId; 



        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedIsLoggedIn, actualIsLoggedIn);
        System.AssertEquals(expectedExternalPartnerCount, actualExternalPartnerCount);
        System.AssertEquals(expectedExternalPartnerName, actualExternalPartnerName);
        System.AssertEquals(expectedExternalPartnerId, actualExternalPartnerId);
        System.AssertEquals(expectedUsersName, actualUsersName);
        System.AssertEquals(expectedUserId, actualUserId);
    }
    
    @isTest static void TestRedirectToCreate()
    {
        //Arrange
        PageReference expected = Page.CreateFinding;        
        expected.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeReferralId = UnitTestHelper.GetFakeId(Referral__c.SObjectType);
        controller.ExternalPartnerLandingScreenViewModel = new ExternalPartnerPortalController.ExternalPartnerLandingScreenViewModel();
        controller.ExternalPartnerLandingScreenViewModel.ReferralId = fakeReferralId;
        expected.getParameters().put('referralId', fakeReferralId);
        
        //Act
        PageReference actual = controller.RedirectToCreate();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestRedirectToExternalPartnerContactProfile()
    {
        //Arrange
        PageReference expected = Page.ExternalPartnerContactProfile;        
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SObjectType);
        controller.ExternalPartnerAccountProfileViewModel = new ExternalPartnerPortalController.ExternalPartnerAccountProfileViewModel();
        controller.ExternalPartnerAccountProfileViewModel.ContactId = fakeContactId;
        expected.getParameters().put('contactId', fakeContactId);
        
        //Act
        PageReference actual = controller.RedirectToExternalPartnerContactProfile();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestRedirectToExternalPartnerAccountCreation_ComplaintDoesNotExist_Error()
    {
        //Arrange
        PageReference expected = null;      
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        controller.FindingReferralSelectorViewModel.ComplaintId = fakeComplaintId;
        string expectedPageErrorMessage = 'Complaint Id Not Found.';
        
        //Act
        PageReference actual = controller.RedirectToExternalPartnerAccountCreation();
        string actualPageErrorMessage = controller.PageErrorMessage;

        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage);  
    }

    @isTest static void TestRedirectToExternalPartnerAccountCreation_ComplaintExists_LoadPage()
    {
        //Arrange
        PageReference expected = Page.ExternalPartnerAccountCreation;       
        expected.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        controller.FindingReferralSelectorViewModel.ComplaintId = testComplaint.Id;
        expected.getParameters().put('complaintId', testComplaint.Id);
        
        //Act
        PageReference actual = controller.RedirectToExternalPartnerAccountCreation();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestRedirectToFindingsDetails()
    {
        //Arrange
        PageReference expectedPageReference = Page.ExternalPartnerPortalFindingDetails; 
        expectedPageReference.setRedirect(true);
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
        expectedPageReference.getParameters().put('findingId', testFinding.Id);
        ApexPages.StandardController standardController = new ApexPages.StandardController(testFinding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLandingScreenViewModel = new ExternalPartnerPortalController.ExternalPartnerLandingScreenViewModel();
        controller.ExternalPartnerLandingScreenViewModel.FindingId = testFinding.Id;

        //Act
        PageReference actualPageReference = controller.ViewLandingScreenFindingDetails();

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);

    }

    @isTest static void TestRemoveDocument_DocumentIdNull_ExpectError()
    {
        //Arrange

        try
        {
            //Act
            ExternalPartnerPortalController.RemoveAttachment('');
        }
        catch(Exception ex)
        {
            //Assert
            System.Assert(ex.GetMessage() == 'contentDocumentId was null.');
        }

    }
    
    @isTest static void TestRequestAccess()
    {
        //Arrange
        PageReference expected = Page.ExternalPartnerRequestAccess;     
        expected.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        
        //Act
        PageReference actual = controller.RequestAccess();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestResetPassword()
    {
        //Arrange
        PageReference expected = Page.ExternalPartnerResetPassword;     
        expected.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        
        //Act
        PageReference actual = controller.ResetPassword();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestRouting_MissingReferralId_GoToLogin()
    {
        //Arrange
        PageReference expected = GetGoToLoginPageReference();       
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        
        //Act
        PageReference actual = controller.Routing();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }

    @isTest static void TestRouting_Success_LoadPage()
    {
        //Arrange
        PageReference expected = Page.CreateFinding;        
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeReferralId = UnitTestHelper.GetFakeId(Referral__c.SObjectType);
        expected.getParameters().put('referralId', fakeReferralId);
        ApexPages.currentPage().getParameters().put('referralId', fakeReferralId); 
        
        //Act
        PageReference actual = controller.Routing();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

    }
     
    //SecondaryReferral: Yes
    //Site Visit:  Yes
    //ViolationsOrComplianceIssues:  No
    //IsEnforcementComplete:  Yes
    @isTest static void TestSave_Success1_CheckPageReference()
    {
        //Arrange
        /*
        //TODO:  Dan Update to ContentVersion/ContentDocument/ContentDocumentLink  
        Attachment attachment = new Attachment();
        attachment.Body = Blob.valueOf('Some Text');
        attachment.ContentType = 'application/pdf';
        attachment.Name = 'My Document';
        //attachment.ParentId = testPlaceholderForAttachments.Id;
        insert attachment;
        */

        List<Id> ids = new List<Id>();
        //ids.Add(attachment.Id);
        string idsJSONString = JSON.serialize(ids);
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        ExternalPartnerPortalController.CreateFindingsViewModel testFinding = new ExternalPartnerPortalController.CreateFindingsViewModel();
        testFinding.ComplaintId = testComplaint.Id;
        testFinding.ContactId = testContact.Id;
        testFinding.DateOfReferral = '01/01/2017';
        testFinding.DateOfSiteVisit = '01/01/2017';     
        testFinding.IsEnforcementComplete = 'Yes';
        testFinding.OnGoingEnforcement = '';
        testFinding.OtherReasonForNoSiteVisit = '';
        testFinding.ReasonForNoSiteVisit = '';
        testFinding.ReferralAgency = 'Lorem Ipsum';
        testFinding.ReferralId = testReferral.Id;
        testFinding.SecondaryReferral = 'Yes';
        testFinding.SiteVisitConducted = 'Yes';
        testFinding.SummaryOfViolationsAndEnforcement = 'Lorem Ipsum';
        testFinding.ViolationsOrComplianceIssues = 'No';
        testFinding.ViolationsRelatedToComplaint = null;
        PageReference expectedPageReference = Page.FindingComplete;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CreateFindingsViewModel = new ExternalPartnerPortalController.CreateFindingsViewModel();     
        controller.CreateFindingsViewModel = testFinding;
        //controller.CreateFindingsViewModel.PlaceholderForAttachmentsId = testPlaceholderForAttachments.Id;
        
        //Act
        PageReference actualPageReference = controller.Save(); 
        system.debug('expectedPageReference:  ' +  expectedPageReference);
        system.debug('actualPageReference:  ' +  actualPageReference);
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);

    }

    //SecondaryReferral: Yes
    //Site Visit:  No
    //Reason for No Site Visit: Complaint is outside agency jurisdiction
    //ViolationsOrComplianceIssues:  No
    //IsEnforcementComplete:  Yes
    @isTest static void TestSave_Success2_CheckPageReference()
    {
        //Arrange
        /*
        //TODO:  Dan Update to ContentVersion/ContentDocument/ContentDocumentLink
        Attachment attachment = new Attachment();
        attachment.Body = Blob.valueOf('Some Text');
        attachment.ContentType = 'application/pdf';
        attachment.Name = 'My Document';
        //attachment.ParentId = testPlaceholderForAttachments.Id;
        insert attachment;
        */

        List<Id> ids = new List<Id>();
        //ids.Add(attachment.Id);
        string idsJSONString = JSON.serialize(ids);
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        ExternalPartnerPortalController.CreateFindingsViewModel testFinding = new ExternalPartnerPortalController.CreateFindingsViewModel();
        testFinding.ComplaintId = testComplaint.Id;
        testFinding.ContactId = testContact.Id;
        testFinding.DateOfReferral = '01/01/2017';
        testFinding.DateOfSiteVisit = '01/01/2017';     
        testFinding.IsEnforcementComplete = 'Yes';
        testFinding.OnGoingEnforcement = '';
        testFinding.OtherReasonForNoSiteVisit = '';
        testFinding.ReasonForNoSiteVisit = 'Complaint is outside agency jurisdiction';
        testFinding.ReferralAgency = 'Lorem Ipsum';
        testFinding.ReferralId = testReferral.Id;
        testFinding.SecondaryReferral = 'Yes';
        testFinding.SiteVisitConducted = 'No';
        testFinding.SummaryOfViolationsAndEnforcement = 'Lorem Ipsum';
        testFinding.ViolationsOrComplianceIssues = 'No';
        testFinding.ViolationsRelatedToComplaint = null;
        PageReference expectedPageReference = Page.FindingComplete;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CreateFindingsViewModel = new ExternalPartnerPortalController.CreateFindingsViewModel();     
        controller.CreateFindingsViewModel = testFinding;
        //controller.CreateFindingsViewModel.PlaceholderForAttachmentsId = testPlaceholderForAttachments.Id;
        
        //Act
        PageReference actualPageReference = controller.Save(); 
        system.debug('expectedPageReference:  ' +  expectedPageReference);
        system.debug('actualPageReference:  ' +  actualPageReference);
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);

    }

    //SecondaryReferral: Yes
    //Site Visit:  No
    //Reason for No Site Visit: Other
    //ViolationsOrComplianceIssues:  Yes
    //IsEnforcementComplete:  No
    @isTest static void TestSave_Success3_CheckPageReference()
    {
        //Arrange
        
        /*
        //TODO:  Dan Update to ContentVersion/ContentDocument/ContentDocumentLink
        Attachment attachment = new Attachment();
        attachment.Body = Blob.valueOf('Some Text');
        attachment.ContentType = 'application/pdf';
        attachment.Name = 'My Document';
        //attachment.ParentId = testPlaceholderForAttachments.Id;
        insert attachment;
        */

        List<Id> ids = new List<Id>();
        //ids.Add(attachment.Id);
        string idsJSONString = JSON.serialize(ids);
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        ExternalPartnerPortalController.CreateFindingsViewModel testFinding = new ExternalPartnerPortalController.CreateFindingsViewModel();
        testFinding.ComplaintId = testComplaint.Id;
        testFinding.ContactId = testContact.Id;
        testFinding.DateOfReferral = '01/01/2017';
        testFinding.DateOfSiteVisit = '01/01/2017';     
        testFinding.IsEnforcementComplete = 'No';
        testFinding.OnGoingEnforcement = 'Lorem Ipsum';
        testFinding.OtherReasonForNoSiteVisit = 'Lorem Ipsum';
        testFinding.ReasonForNoSiteVisit = 'Other';     
        testFinding.ReferralAgency = 'Lorem Ipsum';
        testFinding.ReferralId = testReferral.Id;
        testFinding.SecondaryReferral = 'Yes';
        testFinding.SiteVisitConducted = 'No';
        testFinding.SummaryOfViolationsAndEnforcement = 'Lorem Ipsum';
        testFinding.ViolationsOrComplianceIssues = 'Yes';
        testFinding.ViolationsRelatedToComplaint = null;
        PageReference expectedPageReference = Page.FindingComplete;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CreateFindingsViewModel = new ExternalPartnerPortalController.CreateFindingsViewModel();     
        controller.CreateFindingsViewModel = testFinding;
        //controller.CreateFindingsViewModel.PlaceholderForAttachmentsId = testPlaceholderForAttachments.Id;
        
        //Act
        PageReference actualPageReference = controller.Save(); 
        system.debug('expectedPageReference:  ' +  expectedPageReference);
        system.debug('actualPageReference:  ' +  actualPageReference);
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);

    }

    @isTest static void TestSave_Exception_ReloadPage()
    {
        //Arrange
        /*
        //TODO:  Dan Update to ContentVersion/ContentDocument/ContentDocumentLink
        Attachment attachment = new Attachment();
        attachment.Body = Blob.valueOf('Some Text');
        attachment.ContentType = 'application/pdf';
        attachment.Name = 'My Document';
        //attachment.ParentId = testPlaceholderForAttachments.Id;
        insert attachment;
        */
        List<Id> ids = new List<Id>();
        //ids.Add(attachment.Id);
        string idsJSONString = JSON.serialize(ids);
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        ExternalPartnerPortalController.CreateFindingsViewModel testFinding = new ExternalPartnerPortalController.CreateFindingsViewModel();
        testFinding.ContactId = testContact.Id;
        testFinding.DateOfReferral = '01/01/2017';
        testFinding.DateOfSiteVisit = '01/01/2017';     
        testFinding.IsEnforcementComplete = 'Yes';
        testFinding.OnGoingEnforcement = '';
        testFinding.OtherReasonForNoSiteVisit = '';
        testFinding.ReasonForNoSiteVisit = '';
        testFinding.ReferralAgency = 'Lorem Ipsum';
        testFinding.ReferralId = testReferral.Id;
        testFinding.SecondaryReferral = 'Yes';
        testFinding.SiteVisitConducted = 'Yes';
        testFinding.SummaryOfViolationsAndEnforcement = 'Lorem Ipsum';
        testFinding.ViolationsOrComplianceIssues = 'No';
        testFinding.ViolationsRelatedToComplaint = null;
        PageReference expectedPageReference = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CreateFindingsViewModel = new ExternalPartnerPortalController.CreateFindingsViewModel();     
        controller.CreateFindingsViewModel = testFinding;
        //controller.CreateFindingsViewModel.PlaceholderForAttachmentsId = testPlaceholderForAttachments.Id;

        //Act
        PageReference actualPageReference = controller.Save(); 
        string actualPageErrorMessage = controller.PageErrorMessage;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assert(!string.IsEmpty(actualPageErrorMessage));
    }

    @isTest static void TestSaveAuthenticationCookie()
    {
        //Arrange
        boolean expectedIsLoggedIn = true;
        string expectedUsersName = 'Test Contact';
        integer expectedExternalPartnerCount = 1;
        string expectedExternalPartnerName = 'Test Account';
        boolean expectedCookieExists = true;
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        string expectedExternalPartnerId = testAccount.Id;
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = testAccount.Id, IsRegistered__c = true, Email = 'TestContact@TestAccount.edu' );
        insert testContact;
        testContact = [SELECT Id, Name FROM Contact WHERE Id =: testContact.Id];
        string expectedUserId = testContact.Id;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        controller.Authentication.IsLoggedIn = true;
        controller.Authentication.ExternalPartners.Put(testAccount.Id, testAccount.Name);
        controller.Authentication.ExternalPartnerName = testAccount.Name;
        controller.Authentication.ExternalPartnerId = testAccount.Id;
        controller.Authentication.UsersName = testContact.Name;
        controller.Authentication.UserId = testContact.Id;
        //Act
        controller.SaveAuthenticationCookie();
        Cookie retrievedCookie = ApexPages.currentPage().getCookies().get('AuthenticationModel');
        ExternalPartnerPortalController.AuthenticationModel deserializedAuthentication = (ExternalPartnerPortalController.AuthenticationModel)JSON.deserialize(retrievedCookie.GetValue(), ExternalPartnerPortalController.AuthenticationModel.class);      


        boolean actualIsLoggedIn = deserializedAuthentication.IsLoggedIn;
        string actualUsersName = deserializedAuthentication.UsersName;
        string actualUserId = deserializedAuthentication.UserId;
        integer actualExternalPartnerCount = deserializedAuthentication.ExternalPartners.size();
        string actualExternalPartnerName = deserializedAuthentication.ExternalPartnerName;
        string actualExternalPartnerId = deserializedAuthentication.ExternalPartnerId;
        boolean actualCookieExists =  ApexPages.currentPage().getCookies().get('AuthenticationModel') != null;

        //Assert
        system.assertEquals(expectedIsLoggedIn, actualIsLoggedIn);
        system.assertEquals(expectedUsersName, actualUsersName);
        system.assertEquals(expectedUserId, actualUserId);
        system.assertEquals(expectedExternalPartnerCount, actualExternalPartnerCount);
        system.assertEquals(expectedExternalPartnerName, actualExternalPartnerName);
        system.assertEquals(expectedExternalPartnerId, actualExternalPartnerId);
        system.assertEquals(expectedCookieExists, actualCookieExists);

    }   

    @isTest static void TestSavePassword_PasswordNull_ExpectPageErrorMessage() 
    {
        //Arrange
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = '';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Please Provide a Password.';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestSavePassword_PasswordLessThan8Characters_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = '1234567';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least 8 Characters.';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestSavePassword_PasswordMustHaveAtLeastOneUppercase_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = '12345678';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least One Uppercase Letter.';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }
    
    @isTest static void TestSavePassword_PasswordMustHaveAtLeastOneLowercase_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = 'A2345678';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least One Lowercase Letter.';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }
    
    @isTest static void TestSavePassword_PasswordMustHaveAtLeastOneNumeral_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = 'AbCDEFGH';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Must Contain At Least One Numeral.';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestSavePassword_PasswordMoreThan16Characters_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = 'AbCDEFGH901234567';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Password Can Be No More Than 16 Characters.';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
         
    }

    @isTest static void TestSavePassword_PasswordsDoNotMatch_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = 'AbCDefgh10';
        controller.ExternalPartnerCreatePasswordViewModel.ConfirmPassword = 'AbCDefgh101';
        PageReference expected = null;
        string expectedPageErrorMessage = 'Your Passwords Do Not Match';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
        
         
    }
    
    @isTest static void TestSavePassword_ContactDoesntExist_ExpectPageErrorMessage() 
    {
        //Arrange 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        controller.ExternalPartnerCreatePasswordViewModel.Password = 'AbCDefgh10';
        controller.ExternalPartnerCreatePasswordViewModel.ConfirmPassword = 'AbCDefgh10';
        controller.ExternalPartnerCreatePasswordViewModel.EmailAddress = 'emaildoesntexist@test.com';
        PageReference expected = null;
        string expectedPageErrorMessage = 'There was a problem registering your account, please contact complaints@calepa.ca.gov for assistance.';

        //Act
        PageReference actual = controller.SavePassword();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);

        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
         
        
         
    }
    
    @isTest static void TestSavePassword_PageReferenceEqual() 
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'test@test.com');
        testContact.IsRegistered__c = false;
        update testContact;
        Contact testContact1 = [SELECT Id, RecordType.Name, Email, IsRegistered__c  FROM Contact WHERE Id =: testContact.Id];
        
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerCreatePasswordViewModel = new ExternalPartnerPortalController.ExternalPartnerCreatePasswordViewModel();
        
        controller.ExternalPartnerCreatePasswordViewModel.ContactId = testContact.Id;
        controller.ExternalPartnerCreatePasswordViewModel.EmailAddress = testContact.Email;
        controller.ExternalPartnerCreatePasswordViewModel.Password = 'AbCDefgh10';
        controller.ExternalPartnerCreatePasswordViewModel.ConfirmPassword = 'AbCDefgh10';
        PageReference expected = GetGoToLoginPageReference();
        
        //Act
        PageReference actual = controller.SavePassword();
        
        //Assert
        PageReferenceTestHelper.Assert(expected, actual);
    }

    @isTest static void TestSelectAccount_MissingComplaintIdAndAccountId_ExpectPageErrorMessage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        string expectedPageErrorMessage = 'Complaint Id or Account Id Not Found.';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();

        //Act
        PageReference actualPageReference = controller.SelectAccount();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage);
    }

    @isTest static void TestSelectAccount_InvalidComplaintId_ExpectPageErrorMessage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        string expectedPageErrorMessage = 'Complaint Id Not Found.';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        system.debug('fakeComplaintId:  ' + fakeComplaintId);
        controller.FindingReferralSelectorViewModel.ComplaintId = fakeComplaintId;
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        controller.FindingReferralSelectorViewModel.AccountId = fakeAccountId;
        //Act
        PageReference actualPageReference = controller.SelectAccount();
        string actualPageErrorMessage = controller.PageErrorMessage;
        

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
    } 

    @isTest static void TestSelectAccount_InvalidAccountId_ExpectPageErrorMessage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        string expectedPageErrorMessage = 'Account Id Not Found.';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        controller.FindingReferralSelectorViewModel.ComplaintId = testComplaint.Id;
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        controller.FindingReferralSelectorViewModel.AccountId = fakeAccountId;
        //Act
        PageReference actualPageReference = controller.SelectAccount();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
    }

    @isTest static void TestSelectAccount_Success_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = Page.CreateFinding;
        expectedPageReference.setRedirect(true);
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        expectedPageReference.getParameters().put('complaintId',testComplaint.Id);
        expectedPageReference.getParameters().put('accountId',testAccount.Id);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        controller.FindingReferralSelectorViewModel.ComplaintId = testComplaint.Id;
        controller.FindingReferralSelectorViewModel.AccountId = testAccount.Id;
        //Act
        PageReference actualPageReference = controller.SelectAccount();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestSelectExternalPartner_AccountExists_GoToLandingScreen()
    {
        //Arrange
        Account account = UnitTestHelper.CreateTestAccount();
        string expectedExternalPartnerName = account.Name;
        string expectedExternalPartnerId = account.Id;
        PageReference expectedPageReference = Page.ExternalPartnerLandingScreen;
        expectedPageReference.setRedirect(true);        
        Contact contact = UnitTestHelper.CreateTestCalEPAPartnerContact(account.Id, 'TestContact@TestAccount.edu');
        Contact retrievedContact = [SELECT Id, Name from Contact WHERE Id =: contact.Id];                       
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = retrievedContact.Name;
        authentication.UserId = retrievedContact.Id;
        authentication.ExternalPartnerId = account.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);

        //Act
        PageReference actualPageReference = controller.SelectExternalPartner();     
        Cookie retrievedCookie = ApexPages.currentPage().getCookies().get('AuthenticationModel');
        ExternalPartnerPortalController.AuthenticationModel deserializedAuthentication = (ExternalPartnerPortalController.AuthenticationModel)JSON.deserialize(retrievedCookie.GetValue(), ExternalPartnerPortalController.AuthenticationModel.class);      
        string actualExternalPartnerName = deserializedAuthentication.ExternalPartnerName;
        string actualExternalPartnerId = deserializedAuthentication.ExternalPartnerId;
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedExternalPartnerName, actualExternalPartnerName);
        System.AssertEquals(expectedExternalPartnerId, actualExternalPartnerId);
    }

    @isTest static void TestSelectExternalPartner_AccountDoesntExists_ExpectPageErrorMessage()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        string expectedPageErrorMessage = 'There was an issue retrieving your agency.  Please contact complaints@calepa.ca.gov for assistance.';
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        PageReference expectedPageReference = null;
        Contact contact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        Contact retrievedContact = [SELECT Id, Name from Contact WHERE Id =: contact.Id];                       
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = retrievedContact.Name;
        authentication.UserId = retrievedContact.Id;
        authentication.ExternalPartnerId = fakeAccountId;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);

        //Act
        PageReference actualPageReference = controller.SelectExternalPartner();     
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 

    }

    @isTest static void TestSelectNewAccount_MissingComplaintIdAndAccountId_ExpectPageErrorMessage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        string expectedPageErrorMessage = 'Complaint Id or Account Id Not Found.';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerAccountCreationViewModel = new ExternalPartnerPortalController.ExternalPartnerAccountCreationViewModel();

        //Act
        PageReference actualPageReference = controller.SelectNewAccount();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
    }

    @isTest static void TestSelectNewAccount_InvalidComplaintId_ExpectPageErrorMessage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        string expectedPageErrorMessage = 'Complaint Id Not Found.';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerAccountCreationViewModel = new ExternalPartnerPortalController.ExternalPartnerAccountCreationViewModel();
        string fakeComplaintId = UnitTestHelper.GetFakeId(Complaints__c.SObjectType);
        system.debug('fakeComplaintId:  ' + fakeComplaintId);
        controller.ExternalPartnerAccountCreationViewModel.ComplaintId = fakeComplaintId;
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        controller.ExternalPartnerAccountCreationViewModel.AccountId = fakeAccountId;
        //Act
        PageReference actualPageReference = controller.SelectNewAccount();
        string actualPageErrorMessage = controller.PageErrorMessage;


        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
    }

    @isTest static void TestSelectNewAccount_InvalidAccountId_ExpectPageErrorMessage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        string expectedPageErrorMessage = 'Account Id Not Found.';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerAccountCreationViewModel = new ExternalPartnerPortalController.ExternalPartnerAccountCreationViewModel();
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        controller.ExternalPartnerAccountCreationViewModel.ComplaintId = testComplaint.Id;
        string fakeAccountId = UnitTestHelper.GetFakeId(Account.SObjectType);
        controller.ExternalPartnerAccountCreationViewModel.AccountId = fakeAccountId;
        //Act
        PageReference actualPageReference = controller.SelectNewAccount();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 
    }

    @isTest static void TestSelectNewAccount_Success_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = Page.CreateFinding;
        expectedPageReference.setRedirect(true);
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        expectedPageReference.getParameters().put('complaintId',testComplaint.Id);
        expectedPageReference.getParameters().put('accountId',testAccount.Id);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerAccountCreationViewModel = new ExternalPartnerPortalController.ExternalPartnerAccountCreationViewModel();
        controller.ExternalPartnerAccountCreationViewModel.ComplaintId = testComplaint.Id;
        controller.ExternalPartnerAccountCreationViewModel.AccountId = testAccount.Id;
        //Act
        PageReference actualPageReference = controller.SelectNewAccount();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestSelectReferral_ReferralIdIsBlank_ExpectPageErrorMessage()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = Page.FindingAccountSelector;      
        expectedPageReference.getParameters().put('complaintId', testComplaint.Id);
        expectedPageReference.SetRedirect(true);

        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        controller.FindingReferralSelectorViewModel.ComplaintId = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.SelectReferral();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestSelectReferral_ReferralNotFound_ExpectPageErrorMessage()
    {
        //Arrange
        string expectedPageErrorMessage = 'Referral Id Not Found.';
        PageReference  expectedPageReference = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        string fakeReferralId = UnitTestHelper.GetFakeId(Referral__c.SobjectType);
        controller.FindingReferralSelectorViewModel.ReferralId = fakeReferralId;
        //Act
        PageReference actualPageReference = controller.SelectReferral();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
         
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 

    }

    @isTest static void TestSelectReferral_Success_LoadPage()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        PageReference   expectedPageReference = Page.CreateFinding;
        expectedPageReference.getParameters().put('referralId', testReferral.Id);
        expectedPageReference.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingReferralSelectorViewModel = new ExternalPartnerPortalController.FindingReferralSelectorViewModel();
        controller.FindingReferralSelectorViewModel.ReferralId = testReferral.Id;

        //Act
        PageReference actualPageReference = controller.SelectReferral();
        string actualPageErrorMessage = controller.PageErrorMessage;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestSendResetEmail()
    {
        //Arrange
        string emailAddress = 'test@test.com';
        integer expectedPageErrorMessageCount = 1;
        string expectedSubject = 'Password Reset:  CalEPA Environmental Complaint System External Partner Portal';
        integer expectedToAddressesCount = 1;
        string expectedToAddress = emailAddress;
        boolean expectedUseSignature = false;
        boolean expectedSaveAsActivity = false;

        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SobjectType);
        
        //Act
        List<Messaging.SingleEmailMessage> retrievedMessages = controller.SendResetEmail(emailAddress, fakeContactId, 'Test Contact', '00000');
        integer actualMessageCount = retrievedMessages.Size();
        string actualSubject = retrievedMessages[0].GetSubject();
        integer actualToAddressesCount = retrievedMessages[0].GetToAddresses().Size();
        string actualToAddress = retrievedMessages[0].GetToAddresses()[0];
        boolean actualUseSignature = retrievedMessages[0].GetUseSignature();
        boolean actualSaveAsActivity = retrievedMessages[0].GetSaveAsActivity();

        //Assert
        System.AssertEquals(expectedPageErrorMessageCount, actualMessageCount);
        System.Assert(retrievedMessages[0].GetHtmlBody().Contains(fakeContactId));
        System.Assert(retrievedMessages[0].GetHtmlBody().Contains('Test Contact'));
        System.Assert(retrievedMessages[0].GetHtmlBody().Contains('00000'));
        System.AssertEquals(expectedPageErrorMessageCount, actualMessageCount);
        System.AssertEquals(expectedSubject, actualSubject);
        System.AssertEquals(expectedToAddressesCount, actualToAddressesCount);
        System.AssertEquals(expectedToAddress, actualToAddress);
        System.AssertEquals(expectedUseSignature, actualUseSignature);
        System.AssertEquals(expectedSaveAsActivity, actualSaveAsActivity);
    }

    @isTest static void TestSubmitAccessRequest_ExistingContactSuccess_LoadPage()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        testContact.IsRegistered__c = false;
        testContact.Inactive__c = false;
        update testContact;
        PageReference   expectedPageReference = Page.ExternalPartnerRequestAccessCheckEmail;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerRequestAccessViewModel = new ExternalPartnerPortalController.ExternalPartnerRequestAccessViewModel();
        controller.ExternalPartnerRequestAccessViewModel.FirstName = testContact.FirstName;
        controller.ExternalPartnerRequestAccessViewModel.LastName = testContact.LastName;
        controller.ExternalPartnerRequestAccessViewModel.EmailAddress = testContact.Email;

        //Act
        PageReference actualPageReference = controller.SubmitAccessRequest();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestSubmitAccessRequest_NewContactSuccess_LoadPage()
    {
        //Arrange
        string firstName = 'test';
        string lastName = 'contact';
        Account testAccount = UnitTestHelper.CreateTestAccount();        
        PageReference   expectedPageReference = Page.ExternalPartnerRequestAccessContact;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerRequestAccessViewModel = new ExternalPartnerPortalController.ExternalPartnerRequestAccessViewModel();
        controller.ExternalPartnerRequestAccessViewModel.FirstName = firstName;
        controller.ExternalPartnerRequestAccessViewModel.LastName = lastName;
        controller.ExternalPartnerRequestAccessViewModel.EmailAddress = 'TestContact@TestAccount.edu';

        //Act
        PageReference actualPageReference = controller.SubmitAccessRequest();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestSubmitAccessRequest_AlreadyRegistered_ExpectPageReference()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        testContact.IsRegistered__c = true;
        testContact.Inactive__c = false;
        update testContact;
        PageReference   expectedPageReference = Page.ExternalPartnerRequestAccessCheckEmail;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerRequestAccessViewModel = new ExternalPartnerPortalController.ExternalPartnerRequestAccessViewModel();
        controller.ExternalPartnerRequestAccessViewModel.FirstName = testContact.FirstName;
        controller.ExternalPartnerRequestAccessViewModel.LastName = testContact.LastName;
        controller.ExternalPartnerRequestAccessViewModel.EmailAddress = testContact.Email;
        string expectedEmailAddress = testContact.Email;


        //Act
        PageReference actualPageReference = controller.SubmitAccessRequest();
        string actualEmailAddress = controller.ExternalPartnerRequestAccessViewModel.EmailAddress;
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedEmailAddress, actualEmailAddress);
    }

    @isTest static void TestSubmitAccessRequest_InvalidContact_ExpectPageErrorMessage()
    {
        //Arrange
        string firstName = 'test';
        string lastName = 'contact';
        string emailAddress = 'test@test.com';
        PageReference   expectedPageReference = Page.ExternalPartnerRequestAccessContact;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerRequestAccessViewModel = new ExternalPartnerPortalController.ExternalPartnerRequestAccessViewModel();
        controller.ExternalPartnerRequestAccessViewModel.FirstName = firstName;
        controller.ExternalPartnerRequestAccessViewModel.LastName = lastName;
        controller.ExternalPartnerRequestAccessViewModel.EmailAddress = emailAddress;
        //Act
        PageReference actualPageReference = controller.SubmitAccessRequest();
        string actualPageErrorMessage = controller.PageErrorMessage;
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestSubmitPasswordReset_ContactDoesntExist_ExpectPageErrorMessage()
    {
        //Arrange
        string emailAddress = 'test@test.com';
        string expectedPageErrorMessage = emailAddress + ' could not be found in our system.  Please contact complaints@calepa.ca.gov if you believe this to be a mistake.';
        PageReference  expectedPageReference = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingsResetPasswordViewModel = new ExternalPartnerPortalController.FindingsResetPasswordViewModel();
        controller.FindingsResetPasswordViewModel.EmailAddress = emailAddress;
        //Act
        PageReference actualPageReference = controller.SubmitPasswordReset();
        string actualPageErrorMessage = controller.PageErrorMessage;        
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        system.assertEquals(expectedPageErrorMessage, actualPageErrorMessage); 

    }

    @isTest static void TestSubmitPasswordReset_Success_GotoLogin()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        PageReference  expectedPageReference = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingsResetPasswordViewModel = new ExternalPartnerPortalController.FindingsResetPasswordViewModel();
        controller.FindingsResetPasswordViewModel.EmailAddress = testContact.Email;
        //Act
        Test.StartTest();
        PageReference actualPageReference = controller.SubmitPasswordReset();
        Test.StopTest();
        Contact retrievedContact = [SELECT Id, Reset_Code__c FROM Contact WHERE Id =: testContact.Id];
        string actualResetCode = retrievedContact.Reset_Code__c;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.Assert(!string.IsEmpty(actualResetCode));
    }

    @isTest static void TestUpdateExternalPartnerAccountProfile_ExternalPartnerAccountProfileViewModelIsNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);

        //Act
        PageReference actualPageReference = controller.UpdateExternalPartnerAccountProfile();

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        
    }

    @isTest static void TestUpdateExternalPartnerAccountProfile_AuthenticationExternalPartnerIdIsNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerAccountProfileViewModel = new ExternalPartnerPortalController.ExternalPartnerAccountProfileViewModel();
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();

        //Act
        PageReference actualPageReference = controller.UpdateExternalPartnerAccountProfile();

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        
    }
    
    @isTest static void TestUpdateExternalPartnerAccountProfile_Success_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference = null;
        string expectedPhone = '(000) 999-8888';
        string expectedFax = '(000) 777-6666';
        string expectedShippingStreet = '222 Test Avenue';
        string expectedShippingCity = 'Test City';
        string expectedShippingPostalCode = '99999';
        string expectedWebsite = 'http://www.testwebsite.com';
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerAccountProfileViewModel = new ExternalPartnerPortalController.ExternalPartnerAccountProfileViewModel();
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        controller.Authentication.ExternalPartnerId = testAccount.Id;
        controller.ExternalPartnerAccountProfileViewModel.Phone = '(000) 999-8888';
        controller.ExternalPartnerAccountProfileViewModel.Fax = '(000) 777-6666';
        controller.ExternalPartnerAccountProfileViewModel.ShippingStreet = '222 Test Avenue';
        controller.ExternalPartnerAccountProfileViewModel.ShippingCity = 'Test City';
        controller.ExternalPartnerAccountProfileViewModel.ShippingPostalCode = '99999';
        controller.ExternalPartnerAccountProfileViewModel.Website = 'http://www.testwebsite.com';

        //Act
        Test.StartTest();
        PageReference actualPageReference = controller.UpdateExternalPartnerAccountProfile();
        Test.StopTest();
        Account retrievedAccount = [SELECT Id, Phone, Fax, ShippingStreet, ShippingCity, ShippingPostalCode, Website FROM Account WHERE Id =: testAccount.Id];
        string actualPhone = retrievedAccount.Phone;
        string actualFax = retrievedAccount.Fax;
        string actualShippingStreet = retrievedAccount.ShippingStreet;
        string actualShippingCity = retrievedAccount.ShippingCity;
        string actualShippingPostalCode = retrievedAccount.ShippingPostalCode;
        string actualWebsite = retrievedAccount.Website;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedFax, actualFax);
        System.AssertEquals(expectedShippingStreet, actualShippingStreet);
        System.AssertEquals(expectedShippingCity, actualShippingCity);
        System.AssertEquals(expectedShippingPostalCode, actualShippingPostalCode);
        System.AssertEquals(expectedWebsite, actualWebsite);
    }

    @isTest static void TestUpdateExternalPartnerContactProfile_UpdateExternalPartnerContactProfileIsNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);

        //Act
        PageReference actualPageReference = controller.UpdateExternalPartnerContactProfile();

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        
    }

    @isTest static void TestUpdateExternalPartnerContactProfile_ExternalPartnerContactProfileViewModelContactIdIsNull_GoToLogin()
    {
        //Arrange
        PageReference expectedPageReference = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerContactProfileViewModel = new ExternalPartnerPortalController.ExternalPartnerContactProfileViewModel();

        //Act
        PageReference actualPageReference = controller.UpdateExternalPartnerContactProfile();

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        
    }

    @isTest static void TestUpdateExternalPartnerContactProfile_LoggedInUserSuccess_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference =  Page.ExternalPartnerLandingScreen;
        expectedPageReference.setRedirect(true);
        string expectedFirstName = 'tseT';
        string expectedLastName = 'tcatnoC';
        string expectedEmail = 'tset.tcatnoc@tset.moc';
        string expectedPhone = '(888) 899-9000';
        string expectedTitle = 'President';
        boolean expectedInactive = true;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerContactProfileViewModel = new ExternalPartnerPortalController.ExternalPartnerContactProfileViewModel();
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        controller.ExternalPartnerContactProfileViewModel.ContactId = testContact.Id;
        controller.ExternalPartnerContactProfileViewModel.FirstName = expectedFirstName;
        controller.ExternalPartnerContactProfileViewModel.LastName = expectedLastName;
        controller.ExternalPartnerContactProfileViewModel.Email = expectedEmail;
        controller.ExternalPartnerContactProfileViewModel.Phone = expectedPhone;
        controller.ExternalPartnerContactProfileViewModel.Title = expectedTitle;
        controller.ExternalPartnerContactProfileViewModel.Inactive = expectedInactive;
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        controller.Authentication.UserId = testContact.Id;
        //Act
        Test.StartTest();
        PageReference actualPageReference = controller.UpdateExternalPartnerContactProfile();
        Test.StopTest();
        Contact retrievedContact = [SELECT Id, FirstName, LastName, Email, Phone, Title, Inactive__c FROM Contact WHERE Id =: testContact.Id];
        string actualFirstName = retrievedContact.FirstName;
        string actualLastName = retrievedContact.LastName;
        string actualEmail = retrievedContact.Email;
        string actualPhone = retrievedContact.Phone;
        string actualTitle = retrievedContact.Title;
        boolean actualInactive = retrievedContact.Inactive__c;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedFirstName, actualFirstName);
        System.AssertEquals(expectedLastName, actualLastName);
        System.AssertEquals(expectedEmail, actualEmail);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedTitle, actualTitle);
        System.AssertEquals(expectedInactive, actualInactive);
    }

    @isTest static void TestUpdateExternalPartnerContactProfile_AnotherUserSuccess_LoadPage()
    {
        //Arrange
        PageReference expectedPageReference =  Page.ExternalPartnerAccountProfile;
        string expectedFirstName = 'tseT';
        string expectedLastName = 'tcatnoC';
        string expectedEmail = 'tset.tcatnoc@tset.moc';
        string expectedPhone = '(888) 899-9000';
        string expectedTitle = 'President';
        boolean expectedInactive = true;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerContactProfileViewModel = new ExternalPartnerPortalController.ExternalPartnerContactProfileViewModel();
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        controller.ExternalPartnerContactProfileViewModel.ContactId = testContact.Id;
        controller.ExternalPartnerContactProfileViewModel.FirstName = expectedFirstName;
        controller.ExternalPartnerContactProfileViewModel.LastName = expectedLastName;
        controller.ExternalPartnerContactProfileViewModel.Email = expectedEmail;
        controller.ExternalPartnerContactProfileViewModel.Phone = expectedPhone;
        controller.ExternalPartnerContactProfileViewModel.Title = expectedTitle;
        controller.ExternalPartnerContactProfileViewModel.Inactive = expectedInactive;
        controller.Authentication = new ExternalPartnerPortalController.AuthenticationModel();
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SObjectType);
        controller.Authentication.UserId = fakeContactId;
        //Act
        Test.StartTest();
        PageReference actualPageReference = controller.UpdateExternalPartnerContactProfile();
        Test.StopTest();
        Contact retrievedContact = [SELECT Id, FirstName, LastName, Email, Phone, Title, Inactive__c FROM Contact WHERE Id =: testContact.Id];
        string actualFirstName = retrievedContact.FirstName;
        string actualLastName = retrievedContact.LastName;
        string actualEmail = retrievedContact.Email;
        string actualPhone = retrievedContact.Phone;
        string actualTitle = retrievedContact.Title;
        boolean actualInactive = retrievedContact.Inactive__c;

        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedFirstName, actualFirstName);
        System.AssertEquals(expectedLastName, actualLastName);
        System.AssertEquals(expectedEmail, actualEmail);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedTitle, actualTitle);
        System.AssertEquals(expectedInactive, actualInactive);
    }

    @isTest static void TestViewComplaintDetails()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = Page.ExternalPartnerPortalComplaintDetails;
        expectedPageReference.getParameters().put('complaintId', testComplaint.Id);
        expectedPageReference.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CreateFindingsViewModel = new ExternalPartnerPortalController.CreateFindingsViewModel();
        controller.CreateFindingsViewModel.ComplaintId = testComplaint.Id;
        
        //Act
        PageReference actualPageReference = controller.ViewComplaintDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestGetContact_ContactDoesntExist_ThrowException()
    {
        //Arrange
        string expectedPageErrorMessage = 'Contact Not Found.  Please contact complaints@calepa.ca.gov for assistance.';
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SobjectType);
        try
        {
            //Act
            Contact retrievedContact = ExternalPartnerPortalController.GetContact(fakeContactId);
        }
        catch(Exception ex)
        {
            //Assert
            System.AssertEquals(expectedPageErrorMessage, ex.getMessage());
        }
    }

    @isTest static void TestGetContact_Success_ReturnContact()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        testContact = [SELECT Id, FirstName, LastName, Email, Phone, Title FROM Contact WHERE Id =: testContact.Id];
        string expectedId = testContact.Id;
        string expectedFirstName = testContact.FirstName;
        string expectedLastName = testContact.LastName;
        string expectedEmail = testContact.Email;
        string expectedPhone = testContact.Phone;
        string expectedTitle = testContact.Title;
        
        //Act
        Contact retrievedContact = ExternalPartnerPortalController.GetContact(testContact.Id);
        string actualId = retrievedContact.Id;
        string actualFirstName = retrievedContact.FirstName;
        string actualLastName = retrievedContact.LastName;
        string actualEmail = retrievedContact.Email;
        string actualPhone = retrievedContact.Phone;
        string actualTitle = retrievedContact.Title;

        //Assert
        System.AssertEquals(expectedId, actualId);
        System.AssertEquals(expectedFirstName, actualFirstName);
        System.AssertEquals(expectedLastName, actualLastName);
        System.AssertEquals(expectedEmail, actualEmail);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedTitle, actualTitle);

    }

    @isTest static void TestUpdateContact_EmptyContactId_ExpectNewContact()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        string contactId = null;
        string firstName = 'Test';
        string lastName = 'Contact';
        string email = 'test.contact@test.com';
        string phone = '(000) 111-6666';
        string title = 'Vice President';
        string accountId = testAccount.Id;      
        string expectedFirstName = firstName;
        string expectedLastName = lastName;
        string expectedEmail = email;
        string expectedPhone = phone;
        string expectedTitle = title;
        string expectedAccountId = accountId;


        //Act
        Test.StartTest();
        ExternalPartnerPortalController.UpdateContact(contactId, firstName, lastName, email, phone, title, accountId);
        Test.StopTest();
        List<Contact> retrievedContacts = [SELECT Id, FirstName, LastName, Email, Phone, Title, AccountId FROM Contact WHERE Email =: email AND AccountId =: accountId ];
        string actualContactId = retrievedContacts[0].Id;
        string actualFirstName = retrievedContacts[0].FirstName;
        string actualLastName = retrievedContacts[0].LastName;
        string actualEmail = retrievedContacts[0].Email;
        string actualPhone = retrievedContacts[0].Phone;
        string actualTitle = retrievedContacts[0].Title;
        string actualAccountId = retrievedContacts[0].AccountId;

        //Assert
        System.Assert(!string.IsEmpty(actualContactId));
        System.AssertEquals(expectedFirstName, actualFirstName);
        System.AssertEquals(expectedLastName, actualLastName);
        System.AssertEquals(expectedEmail, actualEmail);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedTitle, actualTitle);
        System.AssertEquals(expectedAccountId, actualAccountId);

    }

    @isTest static void TestUpdateContact_NonEmptyContactId_ExpectUpdatedContact()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'TestContact@TestAccount.edu');
        string contactId = testContact.Id;
        string firstName = 'tset';
        string lastName = 'tcatnoC';
        string email = 'tset.tcatnoc@tset.moc';
        string phone = '(666) 111-0000';
        string title = 'Leader';
        string accountId = testAccount.Id;      
        string expectedFirstName = firstName;
        string expectedLastName = lastName;
        string expectedEmail = email;
        string expectedPhone = phone;
        string expectedTitle = title;
        string expectedAccountId = testAccount.Id;


        //Act
        Test.StartTest();
        ExternalPartnerPortalController.UpdateContact(contactId, firstName, lastName, email, phone, title, accountId);
        Test.StopTest();
        List<Contact> retrievedContacts = [SELECT Id, FirstName, LastName, Email, Phone, Title, AccountId FROM Contact WHERE Id =: testContact.Id];
        string actualContactId = retrievedContacts[0].Id;
        string actualFirstName = retrievedContacts[0].FirstName;
        string actualLastName = retrievedContacts[0].LastName;
        string actualEmail = retrievedContacts[0].Email;
        string actualPhone = retrievedContacts[0].Phone;
        string actualTitle = retrievedContacts[0].Title;
        string actualAccountId = retrievedContacts[0].AccountId;

        //Assert
        System.Assert(!string.IsEmpty(actualContactId));
        System.AssertEquals(expectedFirstName, actualFirstName);
        System.AssertEquals(expectedLastName, actualLastName);
        System.AssertEquals(expectedEmail, actualEmail);
        System.AssertEquals(expectedPhone, actualPhone);
        System.AssertEquals(expectedTitle, actualTitle);
        System.AssertEquals(expectedAccountId, actualAccountId);

    } 

    @isTest static void TestUpdateContact_MissingRequiredField_ExpectException()
    {
        //Arrange
        Account testAccount = UnitTestHelper.CreateTestAccount();
        string contactId = null;
        string firstName = null;
        string lastName = null;
        string email = 'test.contact@test.com';
        string phone = '(000) 111-6666';
        string title = 'Vice President';
        string accountId = testAccount.Id;      
        try
        {
            //Act
            ExternalPartnerPortalController.UpdateContact(contactId, firstName, lastName, email, phone, title, accountId);
        }
        catch (Exception ex)
        {
            //Assert
            System.Assert(!string.IsEmpty(ex.GetMessage()));
        }
    }

    @isTest static void TestViewLandingScreenComplaintDetails()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = Page.ExternalPartnerPortalComplaintDetails;
        expectedPageReference.getParameters().put('complaintId', testComplaint.Id);
        expectedPageReference.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ExternalPartnerLandingScreenViewModel = new ExternalPartnerPortalController.ExternalPartnerLandingScreenViewModel();
        controller.ExternalPartnerLandingScreenViewModel.ComplaintId = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.ViewLandingScreenComplaintDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestGetFindingsByReferral()
    {
        //Arrange
        integer expected = 2;
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        Finding__c testFinding1 = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, null);
        Finding__c testFinding2 = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, null);
        
        //Act
        integer actual = ExternalPartnerPortalController.GetFindingsByReferral(testReferral.Id).size();
        
        //Assert
        System.AssertEquals(expected, actual);
    }

    @isTest static void TestRedirectToFindingAccountSelector()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = Page.FindingAccountSelector;
        expectedPageReference.setRedirect(true);
        expectedPageReference.getParameters().put('complaintId', testComplaint.Id);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.CreateFindingsViewModel = new ExternalPartnerPortalController.CreateFindingsViewModel();
        controller.CreateFindingsViewModel.ComplaintId = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.RedirectToFindingAccountSelector();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }
    
    @isTest static void TestViewComplaintPDF()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        PageReference expectedPageReference = Page.ComplaintPDF;
        expectedPageReference.getParameters().put('id', testComplaint.Id);
        //expectedPageReference.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ComplaintDetailsViewModel = new ComplaintDetailsViewModel();
        controller.ComplaintDetailsViewModel.Id = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.ViewComplaintPDF();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    @isTest static void TestViewFindingPDFPage()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'test@test.com');
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
        PageReference expectedPageReference = Page.FindingPDF;
        expectedPageReference.getParameters().put('id', testFinding.Id);
        //expectedPageReference.setRedirect(true);
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingDetailViewModel = new FindingDetailViewModel();
        controller.FindingDetailViewModel.FindingId = testFinding.Id;

        //Act
        PageReference actualPageReference = controller.ViewFindingPDFPage();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    //Complaint Id Parameter Null
    @isTest static void TestLoadExternalPartnerPortalComplaintDetails1()
    {
        //Arrange       
        PageReference expectedPageReference = GetGoToLoginPageReference();
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ComplaintDetailsViewModel = new ComplaintDetailsViewModel();

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerPortalComplaintDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    //LoadExternalPartnerPortalComplaintDetails
    //Date_and_Time_of_Occurrence__c (Not Null)
    //Anonymous (No, Opted Out)
    //Number of BDOs (> 1)
    
    //Date and Time of Occurrence: Null
    //Anonymous: Yes
    //Number of BDOs: 0
    @isTest static void TestLoadExternalPartnerPortalComplaintDetails2()
    {
        //Arrange       
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        testComplaint.Anonymous__c = true;
        testComplaint.Date_and_Time_of_Occurrence__c = null;
        update testComplaint;       
        ApexPages.currentPage().getParameters().put('complaintId', testComplaint.Id); 
        PageReference expectedPageReference = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ComplaintDetailsViewModel = new ComplaintDetailsViewModel();
        controller.ComplaintDetailsViewModel.Id = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerPortalComplaintDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    //Date and Time of Occurrence: Not Null
    //Anonymous: No
    //Number of BDOs: 1
    @isTest static void TestLoadExternalPartnerPortalComplaintDetails3()
    {
        //Arrange       
        Account testAccount = UnitTestHelper.CreateTestPersonAccount();
        testAccount.PersonHasOptedOutOfEmail = false;       
        update testAccount;     
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        testComplaint.Date_and_Time_of_Occurrence__c = Date.valueOf('2008-01-01 00:00:00');
        testComplaint.Anonymous__c = false;
        testComplaint.Air__c = true;
        testComplaint.Complainant__c = testAccount.Id;
        update testComplaint;
        testComplaint.recalculateFormulas();
        ApexPages.currentPage().getParameters().put('complaintId', testComplaint.Id); 
        PageReference expectedPageReference = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ComplaintDetailsViewModel = new ComplaintDetailsViewModel();
        controller.ComplaintDetailsViewModel.Id = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerPortalComplaintDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    //Date and Time of Occurrence: Not Null
    //Anonymous: No
    //Opted Out: Yes
    //Number of BDOs: 2
    @isTest static void TestLoadExternalPartnerPortalComplaintDetails4()
    {
        //Arrange       
        Account testAccount = UnitTestHelper.CreateTestPersonAccount();
        testAccount.PersonHasOptedOutOfEmail = true;        
        update testAccount;     
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        testComplaint.Date_and_Time_of_Occurrence__c = Date.valueOf('2008-01-01 00:00:00');
        testComplaint.Anonymous__c = false;
        testComplaint.Air__c = true;
        testComplaint.Water__c = true;
        testComplaint.Complainant__c = testAccount.Id;      
        update testComplaint;
        testComplaint.recalculateFormulas();
        ApexPages.currentPage().getParameters().put('complaintId', testComplaint.Id); 
        PageReference expectedPageReference = null;
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.ComplaintDetailsViewModel = new ComplaintDetailsViewModel();
        controller.ComplaintDetailsViewModel.Id = testComplaint.Id;

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerPortalComplaintDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    //finding.Secondary_Referral__c (Yes), Referral_Agency__c
    //finding.Date_of_Referral__c (Not Null)
    //finding.Site_Visit_Conducted__c (Yes)
    //finding.Date_of_Site_Visit__c (Not Null)
    //finding.Violations_or_Compliance_Issues__c (Yes),  Summary_of_Violations_and_enforcement__c, Violations_Related_to_Complaint__c
    //finding.Is_Enforcement_Complete__c (No), On_Going_Enforcement__c
    @isTest static void TestLoadExternalPartnerPortalFindingDetails1()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'test@test.com');
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
        testFinding.Secondary_Referral__c = 'Yes';
        testFinding.Referral_Agency__c = 'Lorem Ipsum';
        testFinding.Date_of_Referral__c = Date.valueOf('2008-01-01 00:00:00');
        testFinding.Site_Visit_Conducted__c = 'Yes';
        testFinding.Date_of_Site_Visit__c = Date.valueOf('2008-01-01 00:00:00');
        testFinding.Violations_or_Compliance_Issues__c = 'Yes';
        testFinding.Summary_of_Violations_and_enforcement__c = 'Lorem Ipsum';
        testFinding.Violations_Related_to_Complaint__c = 'Yes';
        testFinding.Is_Enforcement_Complete__c = 'No';
        testFinding.On_Going_Enforcement__c = 'Lorem Ipsum';
        update testFinding;
        ApexPages.currentPage().getParameters().put('findingId', testFinding.Id); 
        PageReference expectedPageReference = null;
        ApexPages.StandardController standardController = new ApexPages.StandardController(testFinding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingDetailViewModel = new FindingDetailViewModel();
        controller.FindingDetailViewModel.FindingId = testFinding.Id;

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerPortalFindingDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }

    //finding.Secondary_Referral__c (No)
    //finding.Date_of_Referral__c (Null)
    //finding.Site_Visit_Conducted__c (No)
    //finding.Date_of_Site_Visit__c (Null)
    //finding.Reason_for_No_Site_Visit__c (Not Other)
    //finding.Violations_or_Compliance_Issues__c (No)
    //finding.Is_Enforcement_Complete__c (Yes)
    @isTest static void TestLoadExternalPartnerPortalFindingDetails2()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'test@test.com');
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
        testFinding.Secondary_Referral__c = 'No';
        testFinding.Date_of_Referral__c = null;
        testFinding.Site_Visit_Conducted__c = 'No';
        testFinding.Date_of_Site_Visit__c = null;
        testFinding.Reason_for_No_Site_Visit__c = 'Complaint was referred to another agency for handling';
        testFinding.Violations_or_Compliance_Issues__c = 'No';
        testFinding.Is_Enforcement_Complete__c = 'Yes';
        update testFinding;
        ApexPages.currentPage().getParameters().put('findingId', testFinding.Id); 
        PageReference expectedPageReference = null;
        ApexPages.StandardController standardController = new ApexPages.StandardController(testFinding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingDetailViewModel = new FindingDetailViewModel();
        controller.FindingDetailViewModel.FindingId = testFinding.Id;

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerPortalFindingDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }



    //finding.Secondary_Referral__c (No)
    //finding.Date_of_Referral__c (Null)
    //finding.Site_Visit_Conducted__c (No)
    //finding.Date_of_Site_Visit__c (Null)
    //finding.Reason_for_No_Site_Visit__c (Other)
    //finding.Violations_or_Compliance_Issues__c (No)
    //finding.Is_Enforcement_Complete__c (Yes)
    @isTest static void TestLoadExternalPartnerPortalFindingDetails3()
    {
        //Arrange
        Complaints__c testComplaint = UnitTestHelper.CreateTestComplaint();
        Account testAccount = UnitTestHelper.CreateTestAccount();
        Contact testContact = UnitTestHelper.CreateTestCalEPAPartnerContact(testAccount.Id, 'test@test.com');
        Referral__c testReferral = UnitTestHelper.CreateTestReferral(testComplaint.Id, testAccount.Id,'');
        Finding__c testFinding = UnitTestHelper.CreateTestFinding(testComplaint.Id, testReferral.Id, testContact.Id);
        testFinding.Secondary_Referral__c = 'No';
        testFinding.Site_Visit_Conducted__c = 'No';
        testFinding.Reason_for_No_Site_Visit__c = 'Other';
        testFinding.Violations_or_Compliance_Issues__c = 'No';
        testFinding.Is_Enforcement_Complete__c = 'Yes';
        testFinding.Other_Reason_for_No_Site_Visit__c = 'Lorem Ipsum';
        update testFinding;
        ApexPages.currentPage().getParameters().put('findingId', testFinding.Id); 
        PageReference expectedPageReference = null;
        ApexPages.StandardController standardController = new ApexPages.StandardController(testFinding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        controller.FindingDetailViewModel = new FindingDetailViewModel();
        controller.FindingDetailViewModel.FindingId = testFinding.Id;

        //Act
        PageReference actualPageReference = controller.LoadExternalPartnerPortalFindingDetails();
        
        //Assert
        PageReferenceTestHelper.Assert(expectedPageReference, actualPageReference);
    }


    @isTest static void TestSendRegistrationEmail()
    {
        //Arrange
        string emailAddress = 'test@test.com';
        integer expectedPageErrorMessageCount = 1;
        string expectedSubject = 'Access Approved:  CalEPA Environmental Complaint System External Partner Portal';
        integer expectedToAddressesCount = 1;
        string expectedToAddress = emailAddress;
        boolean expectedUseSignature = false;
        boolean expectedSaveAsActivity = false;

        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        string fakeContactId = UnitTestHelper.GetFakeId(Contact.SobjectType);
        
        //Act
        List<Messaging.SingleEmailMessage> retrievedMessages = controller.SendRegistrationEmail(emailAddress, fakeContactId, 'Test Contact', '00000');
        integer actualMessageCount = retrievedMessages.Size();
        string actualSubject = retrievedMessages[0].GetSubject();
        integer actualToAddressesCount = retrievedMessages[0].GetToAddresses().Size();
        string actualToAddress = retrievedMessages[0].GetToAddresses()[0];
        boolean actualUseSignature = retrievedMessages[0].GetUseSignature();
        boolean actualSaveAsActivity = retrievedMessages[0].GetSaveAsActivity();

        //Assert
        System.AssertEquals(expectedPageErrorMessageCount, actualMessageCount);
        System.Assert(retrievedMessages[0].GetHtmlBody().Contains(fakeContactId));
        System.Assert(retrievedMessages[0].GetHtmlBody().Contains('Test Contact'));
        System.Assert(retrievedMessages[0].GetHtmlBody().Contains('00000'));
        System.AssertEquals(expectedPageErrorMessageCount, actualMessageCount);
        System.AssertEquals(expectedSubject, actualSubject);
        System.AssertEquals(expectedToAddressesCount, actualToAddressesCount);
        System.AssertEquals(expectedToAddress, actualToAddress);
        System.AssertEquals(expectedUseSignature, actualUseSignature);
        System.AssertEquals(expectedSaveAsActivity, actualSaveAsActivity);
    }

    private static ExternalPartnerPortalController GetExternalPartnerPortalController()
    {
        Finding__c finding = new Finding__c();
        ApexPages.StandardController standardController = new ApexPages.StandardController(finding);
        ExternalPartnerPortalController controller = new ExternalPartnerPortalController(standardController);
        return controller;
    }

    private static void SimulateLogin()
    {
        Account account = UnitTestHelper.CreateTestAccount();
        Contact contact = UnitTestHelper.CreateTestCalEPAPartnerContact(account.Id, 'TestContact@TestAccount.edu');
        Contact retrievedContact = [SELECT Id, Name from Contact WHERE Id =: contact.Id];                       
        ExternalPartnerPortalController.AuthenticationModel authentication = new ExternalPartnerPortalController.AuthenticationModel();
        authentication.IsLoggedIn = true;
        authentication.UsersName = retrievedContact.Name;
        authentication.UserId = retrievedContact.Id;
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(authentication),null,1800,true);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie}); 
    }
    
    private static PageReference GetGoToLoginPageReference()
    {
         PageReference findingStart =  Page.ExternalPartnerLogin;
        findingStart.setRedirect(true);
        return findingStart;
    }
}