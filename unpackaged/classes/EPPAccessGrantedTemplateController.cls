public class EPPAccessGrantedTemplateController 
{
    public String ContactId {get; set;}
    public String ResetCode {get; set;}
    public string getUrl() 
    {
        string url = OrgURLHelper.GetSiteUrl('ExternalPartnerPortal') + 'ExternalPartnerCreatePassword?contactId=' + ContactId + '&resetCode=' + ResetCode;
		return url;
	}
}