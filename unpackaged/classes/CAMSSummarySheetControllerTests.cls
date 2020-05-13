@isTest
public class CAMSSummarySheetControllerTests 
{
    static testMethod void Test()
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
        Id expected = assignment.Id;
        ApexPages.currentPage().getParameters().put('id',assignment.Id);
        
        //Act
        CAMSSummarySheetController controller = new CAMSSummarySheetController();
        Id actual = controller.assgnmnt.Id;
        
        //Assert
        System.assertEquals(expected, actual);
    }

}