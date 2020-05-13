public with sharing class UnitTestHelper 
{
    static Integer s_num = 1; 

    public static Account CreateTestAccount()
    {
        RecordType calEPAPartnerAgencyAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'CalEPA Partner Agency' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = calEPAPartnerAgencyAccountRecordType.Id, Name = 'Test Account');
        insert testAccount;
        return testAccount;
    }

    public static Account CreateTestPersonAccount()
    {
        RecordType complainantAccountRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Account' AND Name =: 'Complainant' Limit 1 ];
        Account testAccount = new Account(RecordTypeId = complainantAccountRecordType.Id, FirstName = 'Test', LastName = 'Complainant');
        insert testAccount;
        return testAccount;
    }

    public static Contact CreateTestCalEPAPartnerContact(string accountId, string email)
    {       
        RecordType calEPAPartnerContactRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Contact' AND Name =: 'CalEPA Partner' Limit 1 ];
        Contact testContact = new Contact(RecordTypeId = calEPAPartnerContactRecordType.Id, FirstName = 'Test', LastName = 'Contact', AccountId = accountId, IsRegistered__c = true, Email = email );
        insert testContact;
        return testContact;
    }

    public static Complaints__c CreateTestComplaint()
    {
        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c testComplaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true);
        insert testComplaint;
        return testComplaint;
    }

    public static Referral__c CreateTestReferral(string complaintId, string accountId, string contactIds)
    {
        Referral__c testReferral = new Referral__c(Complaint__c = complaintId, External_Partner__c = accountId, SelectedContacts__c=contactIds);
        insert testReferral;
        return testReferral;    
    }

    public static Finding__c CreateTestFinding(string complaintId, string referralId, string contactId)
    {
        Finding__c testFinding = new Finding__c();
        testFinding.Complaint__c = complaintId;
        testFinding.Contact__c = contactId;
        testFinding.Date_of_Referral__c = Date.valueOf('2017-01-01 00:00:00');
        testFinding.Date_of_Site_Visit__c = Date.valueOf('2017-01-01 00:00:00');        
        testFinding.Is_Enforcement_Complete__c = 'Yes';
        testFinding.On_Going_Enforcement__c = '';
        testFinding.Other_Reason_for_No_Site_Visit__c = '';
        testFinding.Reason_for_No_Site_Visit__c = '';
        testFinding.Referral_Agency__c = 'Lorem Ipsum';
        testFinding.Referral__c = referralId;
        testFinding.Secondary_Referral__c = 'Yes';
        testFinding.Site_Visit_Conducted__c = 'Yes';
        testFinding.Summary_of_Violations_and_enforcement__c = 'Lorem Ipsum';
        testFinding.Violations_or_Compliance_Issues__c = 'No';
        testFinding.Violations_Related_to_Complaint__c = null;
        insert testFinding;
        return testFinding; 
    }

    public static Document CreateTestDocument(string documentName)
    {
        Document document;
        document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'application/pdf';
        document.DeveloperName = 'my_document';
        document.IsPublic = true;
        document.Name = documentName;
        document.FolderId = [select id from folder where name = 'Temp'].id;
        insert document;
        return document;    
    }
    
    public static string GetFakeId(Schema.SObjectType sot)
    {
      String result = String.valueOf(s_num++);
      return sot.getDescribe().getKeyPrefix() + '0'.repeat(12-result.length()) + result;
    }   
}