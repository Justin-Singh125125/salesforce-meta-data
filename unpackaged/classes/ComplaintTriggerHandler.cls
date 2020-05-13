public class ComplaintTriggerHandler extends TriggerHandler 
{
    public ComplaintManager CmplntMngr { get; set; }
    public ICallout2 CO { get; set; }

    
    public ComplaintTriggerHandler(ICallout2 callout) 
    {   
        CmplntMngr = new ComplaintManager(callout);
        CO = callout;
    }

    protected override void afterInsert() //Bulkified
    {
        system.debug('afterInsert 1');
        if(TriggerManager.runAfterInsertOnce())
        {
            Set<Id> allComplaintIds = new Set<Id>();
            Set<Id> needsAddressStandardization = new Set<Id>();
            Set<Id> needsAssignment = new Set<Id>();
            system.debug('afterInsert 2');
            for(Complaints__c complaint: (List<Complaints__c>)trigger.new)
            {     
                allComplaintIds.Add(complaint.Id);
                if((complaint.Complaint_Location_City__c != null || complaint.Complaint_Location_Zip_Code__c != null))
                {
                    system.debug('afterInsert 3');
                    needsAddressStandardization.Add(complaint.Id);
                }
                else
                {
                    system.debug('afterInsert 4');
                    needsAssignment.Add(complaint.Id);
                }
            }  
            if(needsAddressStandardization.size() > 0)
            {
                system.debug('afterInsert 5');
                ComplaintManager.StandardizeAddress(needsAddressStandardization , true, 'Region 5');  //Region 5 is just injected for unit testing.           
            }
            if(needsAssignment.size() > 0)
            {
                system.debug('afterInsert 6');
                ComplaintManager.CreateToxicsAndWaterAssignments(needsAssignment);
            }
            if(allComplaintIds.size() > 0)
            {
                system.debug('afterInsert 6');
                if(!Test.isRunningTest())
                {
                    ComplaintManager.CreateComplaintPDF(allComplaintIds);                    
                }
            }
        }
    }
        
    protected override void afterUpdate() 
    {
        if(TriggerManager.runAfterUpdateOnce())
        {
            Set<Id> needsAddressStandardization = new Set<Id>();
            Set<Id> needsAssignment = new Set<Id>();
            for(Complaints__c complaint : (List<Complaints__c>)trigger.new)
            {                    
                Complaints__c oldComplaint = (Complaints__c)trigger.oldMap.get(complaint.Id);
                if((complaint.Complaint_Location_City__c != null || complaint.Complaint_Location_Zip_Code__c != null))
                {
                    if(complaint.Complaint_Location_Address__c != oldComplaint.Complaint_Location_Address__c
                        || complaint.Complaint_Location_City__c != oldComplaint.Complaint_Location_City__c
                        || complaint.Complaint_Location_State__c != oldComplaint.Complaint_Location_State__c
                        || complaint.Complaint_Location_Zip_Code__c != oldComplaint.Complaint_Location_Zip_Code__c)
                    {                            
                        needsAddressStandardization.Add(complaint.Id);
                    }
                    else
                    {
                        if((oldComplaint.Toxic_Substances__c != complaint.Toxic_Substances__c) || (oldComplaint.Water__c != complaint.Water__c))
                        {
                            needsAssignment.Add(complaint.Id);
                        }
                    }
                }
                else
                {
                    if((oldComplaint.Toxic_Substances__c != complaint.Toxic_Substances__c) || (oldComplaint.Water__c != complaint.Water__c))
                    {
                        needsAssignment.Add(complaint.Id);
                    }
                }
            }
            if(needsAddressStandardization.size() > 0)
            {                
                ComplaintManager.StandardizeAddress(needsAddressStandardization , true, 'Region 5');  //Region 5 is just injected for unit testing.           
            }
            if(needsAssignment.size() > 0)
            {
                ComplaintManager.CreateToxicsAndWaterAssignments(needsAssignment);
            }
        }
    }
    
    protected override void beforeDelete()
    {
        List<Id> complaintIds = new List<Id>();
        for(Complaints__c complaint: (List<Complaints__c >)Trigger.Old) 
        {
            complaintIds.Add(complaint.Id);
        }
        
        List<Complaint_Assignment__c> complaintAssignmentsToDelete = [SELECT Id FROM Complaint_Assignment__c WHERE Complaint__c in: complaintIds];
        delete complaintAssignmentsToDelete;
    }
}