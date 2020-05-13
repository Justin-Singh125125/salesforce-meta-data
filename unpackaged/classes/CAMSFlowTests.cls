@isTest
public class CAMSFlowTests 
{
	static testMethod void CAMSUpdateAssignmentOwnerTest()
    {
        //Arrange
        string expected = 'Agency_Unified_Program';
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        //Act
        //boolean actual = CAMSNoteCreateController.SaveCAMSNote(assignment.Id, subject, content);
        assignment.BDO_Suborganization__c = 'Unified Program';         
		update assignment;
        
        //Assert
        CAMS_Assignment__c actualAssignment = [SELECT Id, OwnerId FROM CAMS_Assignment__c WHERE Id=:assignment.Id];
        Group gr = [SELECT Id, DeveloperName FROM Group WHERE Id=:actualAssignment.OwnerId];
        string actual = gr.DeveloperName;
        System.assertEquals(expected, actual);
    }
    
    static testMethod void CAMSAutomateTravelTest1()
    {
        //Arrange
        integer expected = 1;
        Id recordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'In_State_Travel'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = recordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        //Act
        assignment.Status__c = 'In Progress';
		update assignment;
        //Assert
        List<CAMS_Task__c> actualTasks = [SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c =: assignment.Id];
        integer actual = actualTasks.size();
        System.assertEquals(expected, actual);
    }
    
    static testMethod void CAMSAutomateTravelTest2()
    {
        //Arrange
        integer expected = 2;
        Id recordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'In_State_Travel'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = recordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'ARB';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        //Act
        assignment.Status__c = 'In Progress';
		update assignment;
        //Assert
        List<CAMS_Task__c> actualTasks = [SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c =: assignment.Id];
        integer actual = actualTasks.size();
        System.assertEquals(expected, actual);
    }
    
    static testMethod void CAMSCompleteTaskTest()
    {
        //Arrange
        integer expected = 1;
        Id recordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'In_State_Travel'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = recordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'ARB';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        assignment.Status__c = 'In Progress';
		update assignment;
        List<CAMS_Task__c> tasks = [SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c =: assignment.Id AND Status__c = 'Delegated'];
        CAMS_Task__c task = tasks[0];
        //Act
        task.Status__c = 'Completed';
        update task;
        //Assert
       	List<CAMS_Task__c> actualTasks = [SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c =: assignment.Id AND Status__c = 'Delegated'];
        integer actual = actualTasks.size();
        System.assertEquals(expected, actual);
    }
    
    static testMethod void CAMSUpdateTaskOwnerToQueueTest()
    {
        //Arrange
        string expected = 'ARB_Travel';
        Id recordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'In_State_Travel'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = recordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'ARB';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        assignment.Status__c = 'In Progress';
		update assignment;
        List<CAMS_Task__c> tasks = [SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c =: assignment.Id AND Status__c = 'Delegated'];
        CAMS_Task__c task = tasks[0];
        //Act
        task.BDO_Suborganization__c = 'Travel';
        update task;
        //Assert
        CAMS_Task__c actualTask = [SELECT Id, OwnerId FROM CAMS_Task__c WHERE Id=:task.Id];
        Group gr = [SELECT Id, DeveloperName FROM Group WHERE Id=:actualTask.OwnerId];
        string actual = gr.DeveloperName;
        System.assertEquals(expected, actual);
    }
}