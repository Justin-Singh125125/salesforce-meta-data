@isTest
public class CAMSNoteTriggerHandlerTests 
{
    static testMethod void CAMSNoteTriggerHandlerAfterDeleteTest()
    {
        //Arrange
        integer expected = 1;
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        assignment = [SELECT Id, Name FROM CAMS_Assignment__c WHERE Id =: assignment.Id];

        string subject = 'Lorem';
        string content = 'Lorem Ipsum';
        CAMS_Note__c note = new CAMS_Note__c();
        note.Name = subject;
        note.Content__c = content;
        note.CAMS_Assignment__c = assignment.Id;
        note.Uploaded_To__c = assignment.Name;
        insert note;

        //Act
        delete note;

        List<CAMS_History__c> histories = [SELECT Id FROM CAMS_History__c WHERE Assignment__c =: assignment.Id AND Type__c='Note' AND Action__c = 'Delete'];
        System.Debug('histories:  ' + histories);
        integer actual = histories.Size();

        //Assert
        System.assertEquals(expected, actual);
    }
}