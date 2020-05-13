@isTest
public class DashboardAvgDaysOpenControllerTests 
{
    /*static testMethod void Test()
    {
        //Arrange
        string expected = '';

        //Act
        Test.startTest();        
        Test.stopTest();
        
        string actual = '';
        
        //Assert
        System.assertEquals(expected, actual); 
    }*/

    static testMethod void GetMaximumDaysOpenTestAll()
    {
        //Arrange
        Date actualReceiveDate = Date.newInstance(2019, 1, 1);
        Date today = date.today();
        integer expected = actualReceiveDate.DaysBetween(today) + 1;
        Complaints__c complaint = new Complaints__c(Actual_Receive_Date__c=actualReceiveDate);
        insert complaint;

        //Act
        Test.startTest();
        integer actual = DashboardAvgDaysOpenController.GetMaximumDaysOpen('All').IntValue();
        Test.stopTest();
        
        //Assert
        System.assertEquals(expected, actual); 
    }

    static testMethod void GetMaximumDaysOpenTestBDO()
    {
        //Arrange
        Date actualReceiveDate = Date.newInstance(2019, 1, 1);
        Date today = date.today();
        integer expected = actualReceiveDate.DaysBetween(today) + 1;
        Complaints__c complaint = new Complaints__c(Actual_Receive_Date__c=actualReceiveDate,Air__c=true);
        insert complaint;

        //Act
        Test.startTest();
        integer actual = DashboardAvgDaysOpenController.GetMaximumDaysOpen('Air').IntValue();
        Test.stopTest();
        
        //Assert
        System.assertEquals(expected, actual); 
    }

     static testMethod void GetAverageDaysOpenTestAll()
    {
        //Arrange
        Date actualReceiveDate = Date.newInstance(2019, 1, 1);
        Date today = date.today();
        integer expected = actualReceiveDate.DaysBetween(today) + 1;
        Complaints__c complaint = new Complaints__c(Actual_Receive_Date__c=actualReceiveDate);
        insert complaint;

        //Act
        Test.startTest();
        integer actual = DashboardAvgDaysOpenController.GetAverageDaysOpen('All').IntValue();
        Test.stopTest();
        
        //Assert
        System.assertEquals(expected, actual); 
    }

    static testMethod void GetAverageDaysOpenTestBDO()
    {
        //Arrange
        Date actualReceiveDate = Date.newInstance(2019, 1, 1);
        Date today = date.today();
        integer expected = actualReceiveDate.DaysBetween(today) + 1;
        Complaints__c complaint = new Complaints__c(Actual_Receive_Date__c=actualReceiveDate,Air__c=true);
        insert complaint;

        //Act
        Test.startTest();
        integer actual = DashboardAvgDaysOpenController.GetAverageDaysOpen('Air').IntValue();
        Test.stopTest();
        
        //Assert
        System.assertEquals(expected, actual); 
    }
}