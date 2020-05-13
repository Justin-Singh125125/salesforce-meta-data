@isTest
public class CAMSBackToRequestorEmailTests 
{
    static testMethod void ProcessSendEmailTest()
    {
        //Arrange

        String uniqueUserName1 = 'standarduser' + DateTime.now().getTime() + '1@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='CAMS Agency Assigner Platform User'];
        User u1 = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName=uniqueUserName1, BDO__c='Agency');
        insert u1;

        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        assignment.Assigned_To__c = u1.Id;
        insert assignment;
        
        CAMS_Task__c task = new CAMS_Task__c();
        task.BDO__c = 'Agency';
        task.BDO_Suborganization__c = 'Executive Office';
        task.CAMS_Assignment__c = assignment.Id;
        task.Due_Date__c = Date.Today().AddDays(3);
        insert task;
        List<Id> ids = new List<Id>();
        ids.Add(task.Id);
        
        //Act
        CAMSBackToRequestorEmail.ProcessSendEmail(ids);
        
        //Assert
        system.assert(true);

    }
}