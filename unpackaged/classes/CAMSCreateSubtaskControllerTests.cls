@isTest
public class CAMSCreateSubtaskControllerTests 
{
   
    static testMethod void GetParentDueDateTest()
    {
        //Arrange
        Date expected = Date.Today().AddDays(3);
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        
        CAMS_Task__c task = new CAMS_Task__c();
        task.BDO__c = 'Agency';
        task.BDO_Suborganization__c = 'Executive Office';
        task.CAMS_Assignment__c = assignment.Id;
        task.Due_Date__c = Date.Today().AddDays(3);
        insert task;


        //Act
        Date actual = CAMSCreateSubtaskController.GetParentDueDate(task.Id);

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetBDOsTest()
    {
        //Arrange
        integer expected = 1;
        integer actual = null;
        Id controlledCorrespondenceRecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'CAMS_Assignment__c' AND DeveloperName = 'Controlled_Correspondence'].Id;
        CAMS_Assignment__c assignment = new CAMS_Assignment__c();
        assignment.RecordTypeId = controlledCorrespondenceRecordTypeId;
        assignment.Subject__c = 'Lorem Ipsum';
        assignment.BDO__c = 'Agency';
        assignment.BDO_Suborganization__c = 'Executive Office'; 
        assignment.Due_Date__c = Date.Today().AddDays(14);
        insert assignment;
        
        CAMS_Task__c task = new CAMS_Task__c();
        task.BDO__c = 'Agency';
        task.BDO_Suborganization__c = 'Executive Office';
        task.CAMS_Assignment__c = assignment.Id;
        task.Due_Date__c = Date.Today().AddDays(3);
        insert task;





        
        //Act
        actual = CAMSCreateSubtaskController.GetBDOs(task.Id).Size();
        

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetStatusesTest()
    {
        //Arrange
        integer expected = 7;

        //Act
        integer actual = CAMSCreateSubtaskController.GetStatuses().Size();
        
        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetBDOSuborganizationsNotAgencyForAgencyTest()
    {
        //Arrange
        integer expected = 3;
        integer actual = null;
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='CAMS Agency Assigner Platform User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName, BDO__c='ARB');

        
        //Act
        System.runAs(u) 
        {
            actual = CAMSCreateSubtaskController.GetBDOSuborganizations('Agency').Size();
        }
        

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetBDOSuborganizationsBDOForSameBDO()
    {
        //Arrange
        integer expected = 5;
        integer actual = null;
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@testorg.com';
        Profile p = [SELECT Id FROM Profile WHERE Name='CAMS Agency Assigner Platform User'];
        User u = new User(Alias = 'standt', Email='standarduser@testorg.com',
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
        LocaleSidKey='en_US', ProfileId = p.Id,
        TimeZoneSidKey='America/Los_Angeles',
         UserName=uniqueUserName, BDO__c='ARB');

        
        //Act
        System.runAs(u) 
        {
            actual = CAMSCreateSubtaskController.GetBDOSuborganizations('ARB').Size();
        }
        

        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void GetQueueUsersTest()
    {
        //Arrange
        integer expected = 3;
        Profile assignerProfile = [SELECT Id FROM Profile WHERE Name='CAMS BDO Assigner Platform User'];
        Profile reviewerProfile = [SELECT Id FROM Profile WHERE Name='CAMS BDO Reviewer Platform User'];

        Group testGroup = new Group(Name='Test Group', DeveloperName='Test_Group', Type='Regular');
        insert testGroup;

        Group testQueue = new Group(Name='Test Group', DeveloperName='Test_Group', Type='Queue');
        insert testQueue;

        String uniqueUserName1 = 'standarduser' + DateTime.now().getTime() + '1@testorg.com';
        User assigner = new User();
        assigner.Alias = 'standt'; 
        assigner.Email='standarduser@testorg.com';
        assigner.EmailEncodingKey='UTF-8'; 
        assigner.LastName='Testing'; 
        assigner.LanguageLocaleKey='en_US';
        assigner.LocaleSidKey='en_US'; 
        assigner.ProfileId = assignerProfile.Id;
        assigner.TimeZoneSidKey='America/Los_Angeles';
        assigner.UserName=uniqueUserName1;
        assigner.BDO__c='Agency';
        insert assigner;

        String uniqueUserName2 = 'standarduser' + DateTime.now().getTime() + '1@testorg.com';
        User reviewer = new User();
        reviewer.Alias = 'standt'; 
        reviewer.Email='standarduser@testorg.com';
        reviewer.EmailEncodingKey='UTF-8'; 
        reviewer.LastName='Testing'; 
        reviewer.LanguageLocaleKey='en_US';
        reviewer.LocaleSidKey='en_US'; 
        reviewer.ProfileId = reviewerProfile.Id;
        reviewer.TimeZoneSidKey='America/Los_Angeles';
        reviewer.UserName=uniqueUserName2;
        reviewer.BDO__c='Agency';
        insert reviewer;

        GroupMember gm1 = new GroupMember();
        gm1.UserOrGroupId = assigner.Id;
        gm1.GroupId = testQueue.Id;
        insert gm1;

        GroupMember gm2 = new GroupMember();
        gm2.UserOrGroupId = reviewer.Id;
        gm2.GroupId = testGroup.Id;
        insert gm2;

        //Act
        integer actual = CAMSCreateSubtaskController.GetQueueUsers('Test','Group').Size();
        
        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void SaveChildTaskTest()
    {
        //Arrange
        string expected = 'Agency';
        string actual = null;
        
        
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
        task.Due_Date__c = date.Today().addDays(3);
        insert task;

        //Act
        string subTaskDueDate =  date.Today().addDays(2).format();
        CAMS_Task__c subtask = CAMSCreateSubtaskController.SaveChildTask(task.Id, 'Agency', 'Executive Office', null, subTaskDueDate, 'Pending', null);
        actual = subtask.BDO__c;
        
        //Assert
        System.assertEquals(expected, actual);
    }
}