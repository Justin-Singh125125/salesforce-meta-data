@isTest
public class CAMSFileTriggerHandlerTests 
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
        insert assignment;

        ContentVersion cv=new Contentversion();
        cv.title='ABC';
        cv.PathOnClient ='test';
        Blob b=Blob.valueOf('Unit Test Attachment Body');
        cv.versiondata=EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv;
        cv = [SELECT Id,ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id];

        string title = 'Test File';
        string name = 'Test File Name';
        string description = 'Test File Description';

         File__c newFile = new File__c();
        newFile.assignment__c = assignment.id;
        newFile.uploaded_to__c = assignment.name;
        newFile.Name = title;
        newFile.Description__c = description;
        newFile.Doc_Id__c = cv.ContentDocumentId;
        insert newFile;

        //Act
        delete newFile;

        List<CAMS_History__c> histories = [SELECT Id FROM CAMS_History__c WHERE Assignment__c =: assignment.Id AND Type__c='File' AND Action__c = 'Delete'];
        System.Debug('histories:  ' + histories);
        integer actual = histories.Size();

        //Assert
        System.assertEquals(expected, actual);
    }

}