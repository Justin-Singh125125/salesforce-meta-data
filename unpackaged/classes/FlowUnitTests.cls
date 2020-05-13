@isTest
public with sharing class FlowUnitTests 
{
    //Close_Complaint_After_All_Assignments_are_Closed
    public static testMethod void CloseComplaintAfterAllAssignmentsAreClosed_AllClosed()
    {
        //Arrange
        string expected = 'Closed';

        Complaint_Assignment_Group__c complaintAssignmentGroup1 = new Complaint_Assignment_Group__c(Name='Air Resources Board', Lookup_Value__c='Air', Type__c = 'Air');
        insert complaintAssignmentGroup1;        

        Complaint_Assignment_Group__c complaintAssignmentGroup2 = new Complaint_Assignment_Group__c(Name='California Department of Resources Recycling and Recovery (CalRecycle)', Lookup_Value__c='Solid Waste/CalRecycle', Type__c = 'Solid Waste');
        insert complaintAssignmentGroup2;        


        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c complaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Air__c = true,Solid_Waste__c = true);
        insert complaint;        
        
        List<Complaint_Assignment__c> assignments = [SELECT Id,Status__c,Closure_Reason__c,Closure_Comments__c FROM Complaint_Assignment__c WHERE Complaint__c=:complaint.Id];
        
        //Act
        for(Complaint_Assignment__c assignment : assignments)
        {
            assignment.Status__c = 'Closed';
            assignment.Closure_Reason__c = 'Other';
            assignment.Closure_Comments__c = 'Closed For Test';
        }
        Test.startTest();
        update assignments;
        Test.stopTest();
        complaint = [SELECT Id, Status__c FROM Complaints__c WHERE Id=:complaint.Id];
        string actual = complaint.Status__c;

        //Assert
        system.assertEquals(expected, actual);
    }

    //Create_Toxic_Substances_Assignment
     public static testMethod void CreateToxicSubstancesAssignmentNorthern()
    {
        //Arrange
        integer expected = 1;



        Complaint_Assignment_Group__c complaintAssignmentGroup = new Complaint_Assignment_Group__c(Name='Department of Toxic Substances Control (Northern)', Lookup_Value__c='Department of Toxic Substances Control - Northern', Type__c = 'Toxic Substances');
        insert complaintAssignmentGroup;        

        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c complaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id);
        insert complaint;        
        
        //Act
        Test.startTest();
        ComplaintManager.LaunchUpdateToxicsRegionFlow(complaint.Id, 'Sacramento County');
        Test.stopTest();
        List<Complaint_Assignment__c> assignments = [SELECT Id FROM Complaint_Assignment__c WHERE Complaint__c=:complaint.Id AND Type__c='Toxic Substances'];
        integer actual = assignments.Size();
        //Assert
        system.assertEquals(expected, actual);
    }

    public static testMethod void CreateToxicSubstancesAssignmentSouthern()
    {
        //Arrange
        integer expected = 1;
        
        Complaint_Assignment_Group__c complaintAssignmentGroup = new Complaint_Assignment_Group__c(Name='Department of Toxic Substances Control (Southern)', Lookup_Value__c='Department of Toxic Substances Control - Southern', Type__c = 'Toxic Substances');
        insert complaintAssignmentGroup;        

        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c complaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id);
        insert complaint;        
        
        
        
        //Act
        Test.startTest();
        ComplaintManager.LaunchUpdateToxicsRegionFlow(complaint.Id, 'Los Angeles County');
        Test.stopTest();
        List<Complaint_Assignment__c> assignments = [SELECT Id FROM Complaint_Assignment__c WHERE Complaint__c=:complaint.Id AND Type__c='Toxic Substances'];
        integer actual = assignments.Size();
        //Assert
        system.assertEquals(expected, actual);
    }

    public static testMethod void CreateToxicSubstancesAssignmentUnknown()
    {
        //Arrange
        integer expected = 1;

        Complaint_Assignment_Group__c complaintAssignmentGroup = new Complaint_Assignment_Group__c(Name='Department of Toxic Substances Control', Lookup_Value__c='Department of Toxic Substances Control', Type__c = 'Toxic Substances');
        insert complaintAssignmentGroup;        

        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c complaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id);
        insert complaint;        
        
        
        
        //Act
        Test.startTest();
        ComplaintManager.LaunchUpdateToxicsRegionFlow(complaint.Id, '');
        Test.stopTest();
        List<Complaint_Assignment__c> assignments = [SELECT Id FROM Complaint_Assignment__c WHERE Complaint__c=:complaint.Id AND Type__c='Toxic Substances'];
        integer actual = assignments.Size();
        //Assert
        system.assertEquals(expected, actual);
    }

    public static testMethod void CreateWaterAssignmentRegion1()
    {
        //Arrange
        integer expected = 1;
        
        insert new Disable_All_Flows__c(SetupOwnerId=UserInfo.getOrganizationId(), Value__c=false);

        Complaint_Assignment_Group__c complaintAssignmentGroup = new Complaint_Assignment_Group__c(Name='State of California North Coast Regional Water Quality Control Board', Lookup_Value__c='SWRCB - Region 1 - North Coast', Type__c = 'Water');
        insert complaintAssignmentGroup;        


        RecordType parentComplaintRecordType = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name =: 'Parent' Limit 1 ];
        Complaints__c complaint = new Complaints__c(RecordTypeId = parentComplaintRecordType.Id, Water_Quality__c = true, Regional_Water_Board__c='Region 1');
        insert complaint;        
        
        
        
        //Act
        Test.startTest();
        ComplaintManager.LaunchSetWaterContactAndNotifyFlow(complaint.Id, 'Region 1');
        Test.stopTest();
        List<Complaint_Assignment__c> assignments = [SELECT Id FROM Complaint_Assignment__c WHERE Complaint__c=:complaint.Id AND Type__c='Water'];
        integer actual = assignments.Size();
        //Assert
        system.assertEquals(expected, actual);
    }
}