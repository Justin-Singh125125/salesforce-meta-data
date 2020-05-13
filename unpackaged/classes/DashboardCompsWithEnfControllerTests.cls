@isTest
public class DashboardCompsWithEnfControllerTests 
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

    static testMethod void GetComplaintsWithEnforcementActionTest()
    {
        //Arrange
        Complaints__c complaint = new Complaints__c(Actual_Receive_Date__c=date.today());
        insert complaint;
        Finding__c finding = new Finding__c(Complaint__c = complaint.Id, Violations_or_Compliance_Issues__c='Yes',Is_Enforcement_Complete__c='Yes', Secondary_Referral__c='No', Site_Visit_Conducted__c='Yes');
        insert finding;
        string expected = finding.Id;



        //Act
        Test.startTest();
        string temp = DashboardCompsWithEnforcementController.GetComplaintsWithEnforcementAction();
        System.Debug(temp);
        List<DashboardCompsWithEnforcementWrapper> tempObj = (List<DashboardCompsWithEnforcementWrapper>)JSON.deserialize(temp, List<DashboardCompsWithEnforcementWrapper>.class);
        string actual = tempObj[0].Id;
        Test.stopTest();
        
        //Assert
        System.assertEquals(expected, actual); 
    }

    class DashboardCompsWithEnforcementWrapper
    {
       @AuraEnabled
       public String Id;
       @AuraEnabled
       public String URL;
       @AuraEnabled
       public String ComplaintNumber;
       @AuraEnabled
       public string CreatedDate;
    }
}