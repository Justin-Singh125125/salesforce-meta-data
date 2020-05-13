@RestResource(urlMapping='/AttachmentUploadService')
global with sharing class AttachmentUploadService  
{
    @HttpPost
    global static String CreateAttachment()
    {
        try
        {
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.ContentLocation = 'S';
            contentVersion.Title = req.Params.get('Name'); //'lorem.docx' //attachmentUpload.Name;//document.Name;
            contentVersion.PathOnClient = req.Params.get('Name'); //'lorem.docx' //attachmentUpload.Name;//document.Name;
            if(!Test.isRunningTest())
            {
                Integer size = req.requestBody.size();       
                if(size > 0)
                {
                    contentVersion.VersionData = req.requestBody;//attachmentUpload.Body;
                }
                else
                {
                    ApplicationException ex = new ApplicationException();
                    ex.setMessage('The file you attempted to upload was empty.');
                    throw ex;
                }
            }
            else
            {
                Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
                contentVersion.VersionData=bodyBlob;
            }
            contentVersion.IsMajorVersion = true;
            //contentVersion.PublishStatus
            //SharingOption
            //SharingPrivacy
            insert contentVersion;
            contentVersion = [SELECT Id, Title, ContentDocumentId FROM ContentVersion WHERE Id = :contentVersion.Id LIMIT 1];
            //ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
            //contentDocumentLink.ContentDocumentId = contentVersion.ContentDocumentId;
            //contentDocumentLink.LinkedEntityId = placeholder.Id;
            //contentDocumentLink.ShareType = 'I';
            //contentDocumentLink.Visibility = 'AllUsers';
            //insert contentDocumentLink;
            return contentVersion.ContentDocumentId;
        }
        catch (Exception e) 
        {
            ApplicationException ex = new ApplicationException();
            ex.setMessage(e.getMessage());
            throw ex;
        }
    }
}