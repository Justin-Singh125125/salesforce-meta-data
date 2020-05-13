public class CalEPACommunityController 
{
	@AuraEnabled
   	public static boolean isAuthenticated()
    {
    	boolean isAuthenticated = true;
    	if (UserInfo.getUserType() == 'Guest') 
        {
        	isAuthenticated = false;
    	} 
    	return isAuthenticated;
   }
}