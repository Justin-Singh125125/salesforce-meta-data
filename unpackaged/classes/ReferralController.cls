public with sharing class ReferralController 
{
    public CreateReferralViewModel CreateReferralViewModel {get; set;}  
    public ReferralController(ApexPages.StandardController controller)
    {
        
    }
    //SFDC Create VisualForce Page

    public PageReference LoadCreateReferral()
    {
        CreateReferralViewModel = new CreateReferralViewModel();
        Map<String, String> params = ApexPages.currentPage().getParameters();
        system.debug('params:  ' + params);
        string complaintId = '';
        for(string paramId: params.KeySet())
        {
            if(paramId.Contains('lkid'))
            {
                complaintId = params.Get(paramId);
                break;
            }
        }
        if(complaintId != null)
        {
            CreateReferralViewModel.Referral.Complaint__c = complaintId;            
        }
        return null;
    }

    public List<Contact> GetContacts()
    {
        List<Contact> contacts = new List<Contact>();
        if(CreateReferralViewModel.Referral.External_Partner__c != null)
        {
            List<Contact> retrievedContacts = [SELECT Id, FirstName, LastName, Name, Email, Title FROM Contact Where Email != null AND Inactive__c = false and Id in (SELECT ContactId FROM AccountContactRelation WHERE AccountId =: CreateReferralViewModel.Referral.External_Partner__c )];
            for(Contact c : retrievedContacts)
            {
                contacts.add(c);
            }
        }
        return contacts;        
    }
    
    public PageReference Save()
    {
        if(CreateReferralViewModel.SelectedContacts == null || CreateReferralViewModel.SelectedContacts == '')
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You must select at least one contact'));
            return null;
        }
        PageReference pr = new PageReference('/' + CreateReferralViewModel.Referral.Complaint__c);
        try
        {
            Create();
        }
        catch(System.DmlException e) 
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
            return null;
        }
        return pr;
    }  
    
    public PageReference SaveAndNew()
    {
        if(CreateReferralViewModel.SelectedContacts == null ||CreateReferralViewModel.SelectedContacts == '')
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'You must select at least one contact'));
            return null;
        }
        PageReference pr = new PageReference('/apex/newReferral?complaint=' + CreateReferralViewModel.Referral.Complaint__c);
        try
        {
            Create();
        }
        catch(System.DmlException e) 
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
               return null;
        }
        return pr; 
    }
    
    public PageReference Cancel()
    {
        PageReference pr = new PageReference('/' + CreateReferralViewModel.Referral.Complaint__c);
        pr.setRedirect(true);
        return pr;
    }

    private void Create()
    {
        //Create Referral or Retrieve Existing Referral
        List<Referral__c> existingReferrals = [SELECT Id, Complaint__c, External_Partner__c,Message__c,SelectedContacts__c   FROM Referral__c WHERE Complaint__c =: CreateReferralViewModel.Referral.Complaint__c AND External_Partner__c =: CreateReferralViewModel.Referral.External_Partner__c  ];
        if(existingReferrals.size() > 0)    
        {
            CreateReferralViewModel.Referral = existingReferrals[0];
            CreateReferralViewModel.Referral.Message__c = CreateReferralViewModel.Message;
            CreateReferralViewModel.Referral.SelectedContacts__c = CreateReferralViewModel.SelectedContacts;
            System.Debug('CreateReferralViewModel.Referral.SelectedContacts__c:  ' + CreateReferralViewModel.Referral.SelectedContacts__c);
            update CreateReferralViewModel.Referral; 
        }
        else
        {
            CreateReferralViewModel.Referral.Message__c = CreateReferralViewModel.Message;
            CreateReferralViewModel.Referral.SelectedContacts__c = CreateReferralViewModel.SelectedContacts;
            insert CreateReferralViewModel.Referral; 
        }
        //End Create Referral or Retrieve Existing Referral       
        
        //Update Complaint Status
        Complaints__c complaint = [SELECT Id, Name, Status__c from Complaints__c Where Id =: CreateReferralViewModel.Referral.Complaint__c];
        complaint.Status__c = 'Referred';
        update complaint;
        //End Update Complaint Status
    }
    
    //End SFDC Create VisualForce Page    

    public with sharing class CreateReferralViewModel 
    { 
        public string Message {get;set;}
        public Referral__c Referral { get; set; }
        public string SelectedContacts {get; set;} 
        
        public CreateReferralViewModel() 
        {
            Referral = new Referral__c();
        }
    }
    
    //MakeReferralsTestable
}