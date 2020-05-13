@isTest
public class CAMSTaskTriggerHandlerTests 
{
    /*
    */
    static testMethod void CAMSTaskTriggerHandlerBeforeInsertSequentialFirstTaskErrorTest()
    {
        //Arrange
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
        task.Task_Type__c = 'Sequential';
        try
        {
            //Act
            insert task;
        }
        catch(Exception ex) 
        {    
            //Assert
            System.Assert(ex.getMessage().contains('The first task for an Assignment must be Concurrent'));
        }
    }

    static testMethod void CAMSTaskTriggerHandlerBeforeInsertCreateChildOfChildErrorTest()
    {
        //Arrange
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

        CAMS_Task__c childTask1 = new CAMS_Task__c();
        childTask1.BDO__c = 'Agency';
        childTask1.BDO_Suborganization__c = 'Executive Office';
        childTask1.Related_To__c = task.Id;
        childTask1.CAMS_Assignment__c = assignment.Id;
        childTask1.Due_Date__c = Date.Today().AddDays(2);
        insert childTask1;

        CAMS_Task__c childTask2 = new CAMS_Task__c();
        childTask2.BDO__c = 'Agency';
        childTask2.BDO_Suborganization__c = 'Executive Office';
        childTask2.Related_To__c = childTask1.Id;
        childTask2.CAMS_Assignment__c = assignment.Id;
        childTask2.Due_Date__c = Date.Today().AddDays(1);
        try
        {
            //Act
            insert childTask2;    
        }
        catch(Exception ex) 
        {    
            //Assert
            System.Assert(ex.getMessage().contains('You cannot create a child task from a child task.'));
        }
    }

    static testMethod void CAMSTaskTriggerHandlerBeforeUpdateSequentialFirstTaskErrorTest()
    {
        //Arrange
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
        task.Task_Type__c = 'Sequential';
        try
        {
            //Act
            update task;
        }
        catch(Exception ex) 
        {    
            //Assert
            System.Assert(ex.getMessage().contains('The first task for an Assignment must be Concurrent'));
        }
    }

    static testMethod void CAMSTaskTriggerHandlerBeforeUpdateCannotCompleteTaskWhenThereAreOpenChildTasksTest()
    {
        //Arrange
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

        CAMS_Task__c childTask1 = new CAMS_Task__c();
        childTask1.BDO__c = 'Agency';
        childTask1.BDO_Suborganization__c = 'Executive Office';
        childTask1.Related_To__c = task.Id;
        childTask1.CAMS_Assignment__c = assignment.Id;
        childTask1.Due_Date__c = Date.Today().AddDays(1);
        insert childTask1;

        task.Status__c = 'Completed';

        try
        {
            //Act
            update task;    
        }
        catch(Exception ex) 
        {    
            //Assert
            System.Assert(ex.getMessage().contains('You must complete the Subtasks before completing this task.'));
        }
    }

    static testMethod void CAMSTaskTriggerHandlerAfterDeleteTest()
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

        CAMS_Task__c task = new CAMS_Task__c();
        task.BDO__c = 'Agency';
        task.BDO_Suborganization__c = 'Executive Office';
        task.CAMS_Assignment__c = assignment.Id;
        task.Due_Date__c = Date.Today().AddDays(3);
        insert task;

        //Act
        delete task;

        List<CAMS_History__c> histories = [SELECT Id FROM CAMS_History__c WHERE Assignment__c =: assignment.Id AND Type__c='Task' AND Action__c = 'Delete'];
        System.Debug('histories:  ' + histories);
        integer actual = histories.Size();

        //Assert
        System.assertEquals(expected, actual);
    }
}