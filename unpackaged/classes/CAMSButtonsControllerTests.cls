@isTest
public class CAMSButtonsControllerTests 
{
    static testMethod void AssignTasks2Test()
    {
        //Arrange
        integer expected = 2;
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        
        CAMS_Task__c task1 = new CAMS_Task__c();
        task1.BDO__c = 'Agency';
        task1.BDO_Suborganization__c = 'Executive Office';
        task1.CAMS_Assignment__c = assignment.Id;
        task1.Due_Date__c = Date.Today().AddDays(3);
        insert task1;

        CAMS_Task__c task2 = new CAMS_Task__c();
        task2.BDO__c = 'Agency';
        task2.BDO_Suborganization__c = 'Executive Office';
        task2.CAMS_Assignment__c = assignment.Id;
        task2.Due_Date__c = Date.Today().AddDays(3);
        insert task2;
        string aatParam = assignment.Id;

        //Act
        CAMSButtonsController.AssignTasks2( aatParam);
        
        integer actual = ([SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c =: assignment.Id AND Status__c = 'Delegated']).Size();
                
        //Assert
        System.assertEquals(expected, actual);
    }
}