@isTest
public class CAMSFileUploadControllerTests 
{
    /*
        SaveTheChunk
            blank file id
            not blank file id
    */
    static testMethod void SaveCAMSFileForAssignmentTest()
    {
        //Arrange
        boolean expected = true;
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

        string title = 'Test File';
        string name = 'Test File Name';
        string description = 'Test File Description';
        string fin = 'false';
        //Act
        boolean actual = CAMSFileUploadController.SaveCAMSFile(assignment.Id, name, description, cv.Id, fin);
        
        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void SaveCAMSFileForTaskTest()
    {
        //Arrange
        boolean expected = true;
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        insert assignment;

        CAMS_Task__c task = new CAMS_Task__c();
        task.BDO__c = 'Agency';
        task.BDO_Suborganization__c = 'Executive Office';
        task.CAMS_Assignment__c = assignment.Id;
        task.Due_Date__c = Date.Today().AddDays(3);
        insert task;

        ContentVersion cv=new Contentversion();
        cv.title='ABC';
        cv.PathOnClient ='test';
        Blob b=Blob.valueOf('Unit Test Attachment Body');
        cv.versiondata=EncodingUtil.base64Decode('Unit Test Attachment Body');
        insert cv;

        string title = 'Test File';
        string name = 'Test File Name';
        string description = 'Test File Description';
        string fin = 'false';
        //Act
        boolean actual = CAMSFileUploadController.SaveCAMSFile(task.Id, name, description, cv.Id, fin);
        
        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void SaveTheChunkBlankFileIdTest()
    {
        //Arrange
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        insert assignment;

        Id parentId = assignment.Id;
        string fileName ='ABC';
        string base64Data = 'Unit Test Attachment Body';
        string contentType = '';
        string fileId = '';
        //Act
        Id actual = CAMSFileUploadController.SaveTheChunk(parentId, fileName, base64Data, contentType, fileId);
        //Assert
        system.assertNotEquals(null, actual);

    }

    static testMethod void SaveTheChunkNotBlankFileIdTest()
    {
        //Arrange
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

        Id parentId = assignment.Id;
        string fileName ='ABC';
        string base64Data = 'Unit Test Attachment Body';
        string contentType = '';
        string fileId = cv.Id;

        //Act
        Id actual = CAMSFileUploadController.SaveTheChunk(parentId, fileName, base64Data, contentType, fileId);
        
        //Assert
        system.assertNotEquals(null, actual);

    }
}