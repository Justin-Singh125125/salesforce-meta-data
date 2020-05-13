@isTest
public class DashboardComplaintsByBDOChartTests 
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

    static testMethod void GetComplaintsByBDOAllTime()
    {
        //Arrange
        string expected = '[{"y":100,"name":"Air"}]';
        Complaints__c complaint = new Complaints__c(Actual_Receive_Date__c=date.today(),Air__c=true);
        insert complaint;

        //Act
        Test.startTest();
        string actual = DashboardComplaintsByBDOChart.GetComplaintsByBDOAllTime();
        Test.stopTest();
        
        //Assert
        System.assertEquals(expected, actual); 
    }
  
    static testMethod void GetComplaintsByBDOThisYear()
    {
        //Arrange
        string expected = '[{"y":100,"name":"Air"}]';
        Complaints__c complaint = new Complaints__c(Actual_Receive_Date__c=date.today(),Air__c=true);
        insert complaint;

        //Act
        Test.startTest();
        string actual = DashboardComplaintsByBDOChart.GetComplaintsByBDOThisYear();
        Test.stopTest();
        
        //Assert
        System.assertEquals(expected, actual); 
    }
}