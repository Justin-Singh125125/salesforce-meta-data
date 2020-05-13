@isTest
public class CAMSUserByBDOControllerTests 
{
    static testMethod void CAMSUserByBDOControllerGetBDOUserCountsTest()
    {
        //Arrange
        integer expectedCount = 2;
        Profile p = [SELECT Id FROM Profile WHERE Name='CAMS Agency Assigner Platform User'];
        String uniqueUserName1 = 'standardagencyuser' + DateTime.now().getTime() + '@1testorg.com';
        User agencyUser1 = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName=uniqueUserName1, BDO__c='Agency');
        insert agencyUser1;

        String uniqueUserName2 = 'standardagencyuser' + DateTime.now().getTime() + '2@testorg.com';
        User agencyUser2 = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName=uniqueUserName2, BDO__c='Agency');
        insert agencyUser2;

        String uniqueUserName3 = 'standardrbuser' + DateTime.now().getTime() + '1@testorg.com';
        User arbUser1 = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName=uniqueUserName3, BDO__c='ARB');
        insert arbUser1;


        //Act
        Map<string, integer> actual = CAMSUserByBDOController.GetBDOUserCounts();

        //Assert
        System.assert(actual != null);
    }
}