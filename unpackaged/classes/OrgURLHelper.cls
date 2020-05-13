public with sharing class OrgURLHelper 
{
    public static string GetSiteUrl(string siteName)
    {    
        string protocol = 'https://';
        Site site = [SELECT Subdomain,UrlPathPrefix FROM Site WHERE Name=:siteName];
        string subdomain = site.Subdomain;
        Organization organization  = [SELECT IsSandbox,InstanceName FROM Organization];
        if(organization.IsSandbox && site.Subdomain.contains('calepa'))
        {
            string sandboxName = UserInfo.getUserName().substringAfterLast('.');
            string domain = 'force.com';
            String template = '{0}{1}-{2}.{3}.{4}/{5}/';
            List<string> fillers = new List<string> {protocol,sandboxname,subdomain,organization.InstanceName,domain,site.UrlPathPrefix };
            return String.format(template, fillers );
        }
        else
        {
            if(!organization.InstanceName.toUpperCase().contains('CS'))//production
            {
                string domain = '.secure.force.com';
                string template = '{0}{1}{2}/{3}/';
                List<string> fillers = new List<string> {protocol,subdomain,domain,site.UrlPathPrefix };
                return String.format(template, fillers );
            }
            else //scratchorg
            {
                string domain = '.force.com';
                string template = '{0}sandbox-{1}.{2}{3}/{4}/';
                List<string> fillers = new List<string> {protocol,subdomain,organization.InstanceName,domain,site.UrlPathPrefix };
                return String.format(template, fillers );            
            }
        }
    }    
}