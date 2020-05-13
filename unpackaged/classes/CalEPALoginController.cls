global class CalEPALoginController 
{

    @AuraEnabled
    global static String Login(string username, string password) 
    {
	    try 
        {
            ApexPages.PageReference lgn = Site.login(username, password, '');
            aura.redirect(lgn);
            return null;
        } 
        catch (Exception ex) 
        {
            return ex.getMessage();
        }
    }

    @AuraEnabled
    global static String forgotPassowrd(string username) 
    {
        String procesMsg = '';
        if (Site.isValidUsername(username)) 
        {
            Site.forgotPassword(username);
            procesMsg = 'Reset Success'; //Label.LoginResetSuccess;
        } 
        else 
        {
            procesMsg = 'Reset Warning'; //Label.LoginResetWarning;
        }
        return procesMsg;
    }
}