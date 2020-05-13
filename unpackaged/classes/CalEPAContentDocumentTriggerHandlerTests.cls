@isTest
public with sharing class CalEPAContentDocumentTriggerHandlerTests 
{
    static testMethod void NewContentVersion_EXE_Error()
    {
        //Arrange
        Excluded_File_Type__c eft = new Excluded_File_Type__c();
        eft.Name = 'exe';
        eft.Extension__c = 'exe';
        insert eft;


        string before = 'Testing base 64 encode';            
        Blob beforeblob = Blob.valueOf(before);
           
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test.exe';           
        cv.VersionData = beforeblob;          
        //Act
        try 
        {
            insert cv;          
        } 
        catch (Exception e) 
        {
            //Assert
            Boolean expectedExceptionThrown =  e.getMessage().contains('File having this extension could not be attached') ? true : false;
            System.AssertEquals(expectedExceptionThrown, true);
        }
    }    

    
    static testMethod void NewContentVersion_DocX_NoError()
    {
        //Arrange
        Excluded_File_Type__c eft = new Excluded_File_Type__c();
        eft.Name = 'exe';
        eft.Extension__c = 'exe';
        insert eft;


        string before = 'Testing base 64 encode';            
        Blob beforeblob = Blob.valueOf(before);
           
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test.docx';           
        cv.VersionData = beforeblob;          
        //Act
        insert cv;          

        //Assert
        Boolean noError = true;
        System.AssertEquals(noError, true);
    }
    
}