@isTest
public class CAMSUserProvisioningControllerTests 
{
    static testMethod void GetBDOsTest()
    {
        //Arrange
        integer expected = 9;        
        
        //Act
        List<string> bdos = CAMSUserProvisioningController.GetBDOs();
        System.Debug('bdos:  ' + bdos);
        integer actual = bdos.Size();

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetBDOSuborganizationsTest()
    {
        //Arrange
        integer expected = 5;

        //Act
        integer actual = CAMSUserProvisioningController.GetBDOSuborganizations('ARB').Size();

        //Assert
        System.assertEquals(expected, actual);
    }


    static testMethod void GetSaveCAMSUserLastNameLessThan7Test()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Assigner';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserLastNameGreaterThan7Test()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'DoeDoeDoe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Assigner';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserNoUserWithNicknameAlreadyTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Assigner';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserAgencyAssignerTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Assigner';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserAgencyCoordinatorTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Coordinator';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserAgencyExecutiveTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Executive';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserAgencyReviewerTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Reviewer';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserBDOAssignerTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Assigner';
        string bdo = 'ARB';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserBDOCoordinatorTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Coordinator';
        string bdo = 'ARB';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserBDOExecutiveTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Executive';
        string bdo = 'ARB';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserBDOReviewerTest()
    {
        //Arrange
        boolean expected = true;
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        string jobFunction = 'Reviewer';
        string bdo = 'ARB';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetSaveCAMSUserUserWithNicknamealreadyTest()
    {
        //Arrange
        boolean expected = true;

        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='CAMS Agency Assigner Platform User'];
        User u = new User(Alias = 'jdoe', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', FirstName='John', LastName='Doe', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
        UserName=uniqueUserName, BDO__c='Agency',CommunityNickname='John.Doe');
        insert u;
        
        string firstName = 'John';
        string lastName = 'Doe';
        string email = 'John.Doe@test.com';
        string userName = 'standarduser' + DateTime.now().getTime() + '2@testorg.com';
        string jobFunction = 'Assigner';
        string bdo = 'Agency';
        string division = 'Executive Office';
        
        //Act
        boolean actual = CAMSUserProvisioningController.SaveCAMSUser(firstName, lastName, email, userName, jobFunction, bdo, division);

        //Assert
        System.assertEquals(expected, actual);
    } 
}