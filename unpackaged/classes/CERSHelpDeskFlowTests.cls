@isTest(SeeAllData=true)
public with sharing class CERSHelpDeskFlowTests 
{
    /*
    //This is a comment
    public static testMethod void Test()
    {
        //Arrange
        integer expected = 0;

        //Act
        Test.startTest();
        Test.stopTest();
        integer actual = 0;

        //Assert
        System.AssertEquals(expected, actual);
    }
    */

    //CERS_Help_Desk_Add_Technical_Manager_to_Case_Team
    public static testMethod void TestAddTechnicalManagerToCaseTeam()
    {
        //Arrange
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        System.runAs ( thisUser ) 
        {
            List<CaseTeamRole> roles = [SELECT Id FROM CaseTeamRole WHERE Name='Technical Manager'];
            if(roles.size() == 0)
            {
                CaseTeamRole r = new CaseTeamRole();
                r.AccessLevel = 'Edit';
                r.Name = 'Technical Manager';
                insert r;
            }
        }

        integer expected = 1;
        User u = new User();
        List<User> users = [SELECT Id FROM User WHERE Name='Manoj Beeravelli'];
        if(users.Size() == 0)
        {
            String orgId = UserInfo.getOrganizationId();
            String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
            Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
            String uniqueName = orgId + dateString + randomInt;
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            u = new User(
                Alias = 'm', 
                email = uniqueName + '@test' + orgId + '.org',
                Username = uniqueName + '@test' + orgId + '.org',
                EmailEncodingKey='UTF-8', 
                FirstName='Manoj', 
                LastName='Beeravelli', 
                LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', 
                ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles');
            insert u;
        }
        else {
            u = users[0];
        }        

        //Get CERS Help Desk Record Type
        Id recordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = 'CERS'].Id;
        //Act
        Test.startTest();
        //Create Case
        Case c = new Case();
        c.recordTypeId = recordTypeId;
        c.Origin = 'Web';
        insert c;
        Test.stopTest();
        List<CaseTeamMember> teamMembers = [SELECT Id,MemberId FROM CaseTeamMember WHERE ParentId=:c.Id]; // AND MemberId=:u.Id
        integer actual = teamMembers.Size();

        //Assert
        System.AssertEquals(expected, actual);
    }
    
    //CERS_Help_Desk_Set_Manager_on_Case
    public static testMethod void TestSetManagerOnCase()
    {
        //Arrange
        string expected = '';
        User u = new User();
        List<User> users = [SELECT Id FROM User WHERE Name='Manoj Beeravelli'];
        if(users.Size() == 0)
        {
            String orgId = UserInfo.getOrganizationId();
            String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
            Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
            String uniqueName = orgId + dateString + randomInt;
            Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
            u = new User(
                Alias = 'm', 
                email = uniqueName + '@test' + orgId + '.org',
                Username = uniqueName + '@test' + orgId + '.org',
                EmailEncodingKey='UTF-8', 
                FirstName='Manoj', 
                LastName='Beeravelli', 
                LanguageLocaleKey='en_US', 
                LocaleSidKey='en_US', 
                ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles');
            insert u;
        }
        else {
            u = users[0];
        }        
        expected = u.Id;
        //Get CERS Help Desk Record Type
        Id recordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = 'CERS'].Id;
        //Act
        Test.startTest();
        //Create Case
        Case c = new Case();
        c.recordTypeId = recordTypeId;
        c.Origin = 'Web';
        insert c;
        Test.stopTest();
        c = [SELECT Id,CERS_Technical_Manager__c FROM Case WHERE Id=:c.Id LIMIT 1];
        string actual = c.CERS_Technical_Manager__c;

        //Assert
        System.AssertEquals(expected, actual);
    }
    
    //CERS_Help_Desk_Automatically_Contact_Association
    public static testMethod void TestAutomaticContactAssociationContactAlreadyExists()
    {
        //Arrange
        string expected = '';
        //Create Account
        Id accountRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND DeveloperName = 'Business_Account'].Id;
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.RecordTypeId = accountRecordTypeId;
        insert testAccount;
        //Create Contact
        Id contactRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Contact' AND DeveloperName = 'Business_Contact'].Id;
        Contact testContact = new Contact();
        testContact.FirstName = 'Test';
        testContact.LastName = 'Contact';
        testContact.AccountId = testAccount.Id;
        testContact.RecordTypeId = contactRecordTypeId;
        testContact.Email = 'test.contact@testaccount.com';
        insert testContact;
        expected = testContact.Id;
        Id caseRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = 'CERS'].Id;
        //Act
        Test.startTest();
        //Create Case with Contact's Email
        Case c = new Case();
        c.recordTypeId = caseRecordTypeId;
        c.Origin = 'Web';
        c.SuppliedEmail = 'test.contact@testaccount.com';
        insert c;
        Test.stopTest();
        c = [SELECT Id,ContactId FROM Case WHERE Id=:c.Id LIMIT 1];
        string actual = c.ContactId;
        //Assert
        //Check if Contact.Id = Case.ContactId
        System.AssertEquals(expected, actual);
    }

    public static testMethod void TestAutomaticContactAssociationContactDoesNotExistCompanyNotSuppliedDomainExists()
    {
        //Arrange
        string expected = 'Test Contact';
        //Create Account
        Id accountRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND DeveloperName = 'Business_Account'].Id;
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.RecordTypeId = accountRecordTypeId;
        testAccount.Email_Domain__c = 'testaccount.com';
        insert testAccount;


        Id caseRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = 'CERS'].Id;
        //Act
        Test.startTest();
        //Create Case with Contact's Email
        Case c = new Case();
        c.recordTypeId = caseRecordTypeId;
        c.Origin = 'Web';
        c.SuppliedEmail = 'test.contact@testaccount.com';
        c.SuppliedName = 'Test Contact';
        insert c;
        Test.stopTest();
        c = [SELECT Id,Contact.Name FROM Case WHERE Id=:c.Id LIMIT 1];
        string actual = c.Contact.Name;
        //Assert
        //Check if Contact.Id = Case.ContactId
        System.AssertEquals(expected, actual);
    }

    public static testMethod void TestAutomaticContactAssociationContactDoesNotExistCompanyNotSuppliedDomainDoesNotExist()
    {
        //Arrange
        string expected = 'testaccount.com';

        Id caseRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = 'CERS'].Id;
        //Act
        Test.startTest();
        //Create Case with Contact's Email
        Case c = new Case();
        c.recordTypeId = caseRecordTypeId;
        c.Origin = 'Web';
        c.SuppliedEmail = 'test.contact@testaccount.com';
        c.SuppliedName = 'Test Contact';
        insert c;
        Test.stopTest();
        c = [SELECT Id,Account.Name FROM Case WHERE Id=:c.Id LIMIT 1];
        string actual = c.Account.Name;
        //Assert
        //Check if Contact.Id = Case.ContactId
        System.AssertEquals(expected, actual);
    }

    public static testMethod void TestAutomaticContactAssociationContactDoesNotExistCompanySuppliedAccountExists()
    {
       //Arrange
        string expected = 'Test Account';
        //Create Account
        Id accountRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Account' AND DeveloperName = 'Business_Account'].Id;
        Account testAccount = new Account();
        testAccount.Name = 'Test Account';
        testAccount.RecordTypeId = accountRecordTypeId;
        insert testAccount;
        Id caseRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = 'CERS'].Id;
        //Act
        Test.startTest();
        //Create Case with Contact's Email
        Case c = new Case();
        c.recordTypeId = caseRecordTypeId;
        c.Origin = 'Web';
        c.SuppliedName = 'Test Contact';
        c.SuppliedEmail = 'test.contact@testaccount.com';
        c.SuppliedCompany = 'Test Account';
        insert c;
        Test.stopTest();
        c = [SELECT Id,Account.Name,ContactId FROM Case WHERE Id=:c.Id LIMIT 1];
        System.Debug('ContactId: ' + c.ContactId);
        string actual = c.Account.Name; 
        //Assert
        //Check if Contact.Id = Case.ContactId
        System.AssertEquals(expected, actual);
    }

    public static testMethod void TestAutomaticContactAssociationContactDoesNotExistCompanySuppliedAccountDoesNotExist()
    {
        //Arrange
        integer expected = 0;

        //Act
        Test.startTest();
        Test.stopTest();
        integer actual = 0;

        //Assert
        System.AssertEquals(expected, actual);
    }

    
    //CERS_Help_Desk_Send_Overdue_Case_Manager_Notification
    public static testMethod void TestSendOverdueCaseManagerNotification()
    {
        //Arrange
        string expected = '';
        //Get CERS Help Desk Record Type
        Id recordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'Case' AND DeveloperName = 'CERS'].Id;
        //Act
        
        //Create Case
        Case c = new Case();
        c.recordTypeId = recordTypeId;
        c.Origin = 'Web';
        Test.startTest();
        insert c;        
        Test.stopTest();
        Map<String, Object> myMap = new Map<String, Object>();
        myMap.put('CaseId', c.Id);
        Flow.Interview.CERS_Help_Desk_Send_Overdue_Case_Manager_Notification myFlow = new Flow.Interview.CERS_Help_Desk_Send_Overdue_Case_Manager_Notification(myMap);
        myFlow.start(); 
        string actual = '';

        //Assert
        System.AssertEquals(expected, actual);
    }    
}