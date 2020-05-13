public with sharing class FindingController
{

	public SFDCCreateNewFindingViewModel SFDCCreateNewFindingViewModel {get;set;}
	
	public FindingController(ApexPages.StandardController controller)
	{
		
    }
 
	//Create New Finding From Within SFDC

    public PageReference LoadSFDCCreateNewFinding()
    {
        SFDCCreateNewFindingViewModel = new SFDCCreateNewFindingViewModel();
        Map<String, String> params = ApexPages.currentPage().getParameters();
        for(string paramId: params.KeySet())
		{
			if(paramId.Contains('lkid'))
			{                
                if(params.Get(paramId) != null)
                {
                    system.debug('params.Get(paramId):  ' + params.Get(paramId));
                    SFDCCreateNewFindingViewModel.Finding.Complaint__c = params.Get(paramId);        	
                }
			}
		}
        return null;
    }

    public PageReference SFDCSaveNewFinding()
	{
        PageReference pr = new PageReference('/' + SFDCCreateNewFindingViewModel.Finding.Complaint__c);
        insert SFDCCreateNewFindingViewModel.Finding;
        return pr;
    }  
    
	public PageReference SFDCCancelNewFinding()
	{
        PageReference pr = new PageReference('/' + SFDCCreateNewFindingViewModel.Finding.Complaint__c);
        pr.setRedirect(true);
        return pr;
    }

    //End Create New Finding Form WIthin SFDC

	public with sharing class SFDCCreateNewFindingViewModel 
    {
	    public Finding__c Finding { get; set; }
        public SFDCCreateNewFindingViewModel() 
        {
            Finding = new Finding__c();
        }
    }
}