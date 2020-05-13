public class CalepaPartnerCommunityResetPasswordCtrlr {
    
    public String oldPassword {get; set;}
    public String newPassword {get; set;}
    public String verifyNewPassword {get; set;}
 
    
    public PageReference changePassword() {        
        return Site.changePassword(newPassword, verifyNewPassword, oldPassword);    
    }     
    
   	public CalepaPartnerCommunityResetPasswordCtrlr() {}
}