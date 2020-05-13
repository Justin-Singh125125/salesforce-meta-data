@isTest
public with sharing class AttachmentUploadServiceTests 
{
	public AttachmentUploadServiceTests() 
	{
		
	}
	/*
	@isTest static void TestCreateAttachment_NewPlaceholder_VerifyCount()
	{
		//Arrange
		integer expectedCount = 1;
		RestRequest testRestRequest = new RestRequest();
		testRestRequest.AddParameter('PlaceholderForAttachmentsId', '');
		testRestRequest.AddParameter('Name', 'TestName');
		testRestRequest.AddParameter('ContentType', 'TestType');
		Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
		testRestRequest.RequestBody = bodyBlob;
		RestContext.request = testRestRequest;
		//Act
		string placeholderId = AttachmentUploadService.CreateAttachment();
		//Assert
		List<ContentDocumentLink> actualAttachments = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId =: placeholderId];
		integer actualCount = actualAttachments.Size();
		System.AssertEquals(expectedCount , actualCount);		
	}
	*/
}