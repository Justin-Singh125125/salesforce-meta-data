@isTest
public with sharing class CalEPAPartnerAgencyTriggerHandlerTests 
{
    public static testMethod void TestDeleteAccountRemoveAccountEdits()
    {
        //Arrange
        integer expected = 0;
        Account testAccount = UnitTestHelper.CreateTestAccount();
        string testAccountId = testAccount.Id;
        AccountEdit__c accountEdit = new AccountEdit__c();
        accountEdit.Account__c = testAccount.Id;
        insert accountEdit;

        //Act
        Test.startTest();
        delete testAccount;
        Test.stopTest();
        List<AccountEdit__c> edits = [SELECT Id FROM AccountEdit__c WHERE Account__c=: testAccountId ];
        integer actual = edits.Size();
        //Assert

        System.AssertEquals(expected, actual);
    }
}