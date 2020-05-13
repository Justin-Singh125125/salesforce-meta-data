@isTest
public with sharing class CAMSAssignmentTriggerHandlerTests 
{
    static testMethod void CAMSAssignmentTriggerHandlerBeforeInsertMissingDivisionExpectErrorTest()
    {
        //Arrange
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.Due_Date__c = Date.Today().AddDays(14);
        try
        {
            //Act
            insert assignment;
        }
        catch(Exception ex) 
        {    
            //Assert
            System.Assert(ex.getMessage().contains('Division, Office or Program is required'));
        }
    }
    
    static testMethod void CAMSAssignmentTriggerHandlerBeforeUpdateDelegateAssignmentWithoutTaskExpectErrorTest()
    {
        //Arrange
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.Due_Date__c = Date.Today().AddDays(14);
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        insert assignment;
        try
        {
            //Act
            assignment.Status__c = 'In Progress'; 
            update assignment;
        }
        catch(Exception ex) 
        {    
            //Assert
            System.Assert(ex.getMessage().contains('You cannot delegate an assignment that has no tasks.'));
        }
    }

    static testMethod void CAMSAssignmentTriggerHandlerBeforeUpdateCloseAssignmentWithOpenTaskExpectErrorTest()
    {
        //Arrange
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.Due_Date__c = Date.Today().AddDays(14);
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        insert assignment;

        CAMS_Task__c task = new CAMS_Task__c();
        task.BDO__c = 'Agency';
        task.BDO_Suborganization__c = 'Executive Office';
        task.CAMS_Assignment__c = assignment.Id;
        task.Due_Date__c = Date.Today().AddDays(3);
        insert task;
        assignment.Status__c = 'In Progress'; 
        update assignment;
        
        try
        {
            //Act
            assignment.Status__c = 'Closed'; 
            update assignment;
        }
        catch(Exception ex) 
        {    
            //Assert
            System.Assert(ex.getMessage().contains('You cannot close an assignment without all tasks either completed or withdrawn.'));
        }
    }

    static testMethod void CAMSAssignmentTriggerHandlerBeforeDeleteDeleteTasks()
    {
        //Arrange
        integer expected = 0;
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

        //Act
        delete assignment;

        List<CAMS_Task__c> tasks = [SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c =: assignment.Id];
        integer actual = tasks.Size();
        
        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void CAMSAssignmentTriggerHandlerAfterDeleteCreateCAMSHistory()
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
        assignment = [SELECT Id, Name FROM CAMS_Assignment__c WHERE Id=:assignment.Id];
        string assignmentName = assignment.Name;
        //Act
        delete assignment;

        List<CAMS_History__c> histories = [SELECT Id FROM CAMS_History__c WHERE Name_Id__c =: assignmentName AND Type__c='Assignment' AND Action__c = 'Delete'];
        integer actual = histories.Size();

        //Assert
        System.assertEquals(expected, actual);
    }
}