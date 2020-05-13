@isTest
public class CAMSNoteCreateControllerTests 
{
    static testMethod void CAMSNoteCreateControllerSaveCAMSNoteAssignmentTest()
    {
        //Arrange
        boolean expected = true;

        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        string subject = 'Lorem';
        string content = 'Lorem Ipsum';
        //Act
        boolean actual = CAMSNoteCreateController.SaveCAMSNote(assignment.Id, subject, content);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void CAMSNoteCreateControllerSaveCAMSNoteTaskTest()
    {
        //Arrange
        boolean expected = true;

        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;

        CAMS_Task__c task = new CAMS_Task__c();
        task.BDO__c = 'Agency';
        task.BDO_Suborganization__c = 'Executive Office';
        task.CAMS_Assignment__c = assignment.Id;
        task.Due_Date__c = Date.Today().AddDays(3);
        insert task;

        string subject = 'Lorem';
        string content = 'Lorem Ipsum';
        //Act
        boolean actual = CAMSNoteCreateController.SaveCAMSNote(task.Id, subject, content);

        //Assert
        System.assertEquals(expected, actual);
    }

}