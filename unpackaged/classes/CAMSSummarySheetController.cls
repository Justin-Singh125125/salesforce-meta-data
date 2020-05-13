public with sharing class CAMSSummarySheetController 
{ 
    public list <CAMS_Assignment__history> ah {get; set; }
    public CAMS_Assignment__c assgnmnt {get; set; }
    public list <CAMS_Task__history> task {get; set; }
    public list <File__c> File {get; set; }
    public list <CAMS_Note__c> notes {get; set; }
    public string adParam {get; set; }
    
    public CAMSSummarySheetController() 
    {
        String idParam = apexPages.currentPage().getParameters().get('id');
        if ( string.isNotBlank(idParam) ) 
        {
            assgnmnt = [select id, name, CreatedDate, CreatedBy.Name, Subject__c, BDO__c, BDO_Suborganization__c, Originator__r.name, type__c, Governor_s_Office_Number__c, Status__c,Closed_Withdrawn_Date__c   from CAMS_Assignment__c where id = :idParam];
            ah = [SELECT createddate, OldValue, NewValue, field, Parent.Id, Parent.name, Parent.bdo__c, createdby.name FROM cams_assignment__history where parent.id = :idParam AND field in ('due_date__c', 'Status__c', 'Closed_Withdrawn_Date__c') order by createddate desc];
            task = [SELECT createddate, OldValue, NewValue, field, Parent.Id, Parent.name, Parent.bdo__c, createdby.name FROM cams_task__history where parent.CAMS_Assignment__r.id = :idParam AND field in ('due_date__c', 'Status__c', 'bdo__c', 'assigned_to__c') order by createddate desc];
            File = [select name, createdby.name, Description__c, CreatedDate from File__c where Assignment__c = :idParam];
            List<ContentDocumentLink> results = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityID = :assgnmnt.id];
            notes = [SELECT Id, Name, Content__c, createdby.name,  CreatedDate  FROM CAMS_Note__c where CAMS_Assignment__c =:idParam  order by createddate desc]; //'069r0000000VUZIAA4' ];
        }
    }
}