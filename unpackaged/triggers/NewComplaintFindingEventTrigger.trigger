trigger NewComplaintFindingEventTrigger on New_Complaint_Finding__e (after insert) 
{
    for(New_Complaint_Finding__e e: (List<New_Complaint_Finding__e>)trigger.new)
    {
        Complaints__c complaint = [SELECT Id, Name FROM Complaints__c WHERE Id=:e.Complaint__c];
        FeedItem item = new FeedItem();
        item.parentId = complaint.Id;
        //item.createdById = '005j000000D0eJF'; // author to impersonate
        item.body = 'A new finding has been submitted for ' + complaint.Name;
        item.isRichText = true;
        insert item;
    }
}