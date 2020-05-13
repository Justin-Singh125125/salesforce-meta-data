//Used for External Partner Portal Site.Com Site
public with sharing class ExternalPartnerPortalController 
{ 
    //Start Public Properties    
    public DateTime CurrentDateTime {get;set;}
    public string PageErrorMessage  {get;set;}
    public AuthenticationModel Authentication {get;set;}
    public ExternalPartnerLoginViewModel ExternalPartnerLoginViewModel {get;set;}
    public ExternalPartnerRequestAccessViewModel ExternalPartnerRequestAccessViewModel {get;set;}
    public FindingsResetPasswordViewModel FindingsResetPasswordViewModel {get;set;}
    public ExternalPartnerAccountSelectorViewModel ExternalPartnerAccountSelectorViewModel {get;set;}
    public FindingReferralSelectorViewModel FindingReferralSelectorViewModel {get;set;}
    public ExternalPartnerCreatePasswordViewModel ExternalPartnerCreatePasswordViewModel {get;set;}
    public CompleteExternalPartnerResetPasswordViewModel CompleteExternalPartnerResetPasswordViewModel {get;set;}
    public ExternalPartnerLandingScreenViewModel ExternalPartnerLandingScreenViewModel {get;set;}
    public CreateFindingsViewModel CreateFindingsViewModel {get; set;}
    public FindingCompleteViewModel FindingCompleteViewModel {get;set;}
    public FindingConfirmationEmailViewModel FindingConfirmationEmailViewModel {get; set;}
    public FindingNotificationEmailViewModel FindingNotificationEmailViewModel {get; set;}
    public FindingDetailViewModel FindingDetailViewModel {get;set;}
    public ExternalPartnerAccountCreationViewModel ExternalPartnerAccountCreationViewModel {get;set;}
    public ExternalPartnerContactProfileViewModel ExternalPartnerContactProfileViewModel {get;set;}
    public ExternalPartnerAccountProfileViewModel ExternalPartnerAccountProfileViewModel {get;set;}    
    public ComplaintDetailsViewModel ComplaintDetailsViewModel {get;set;}    
    //End Public Properties 

    public ExternalPartnerPortalController(ApexPages.StandardController controller)
    {
        GetAuthenticationCookie();
        SaveAuthenticationCookie();        
    }    

    public ExternalPartnerPortalController(ApexPages.StandardController controller, DateTime now)
    {
        GetAuthenticationCookie();
        SaveAuthenticationCookie();   
        CurrentDateTime = now;     
    } 

    //Start Findings Form Routing

    public PageReference Routing()
    {
        if(ApexPages.currentPage().getParameters().get('referralId') == null)
        {           
            return GotoLogin();
        }
        string referralId = ApexPages.currentPage().getParameters().get('referralId');
        PageReference CreateFinding = Page.CreateFinding;
        CreateFinding.getParameters().put('referralId', referralId);
        return CreateFinding;
    }

    //End Findings Form Routing

    //Start Findings Layout Functions

    public PageReference ExternalPartnerLandingScreen()
    {
        if(!Authentication.IsLoggedIn)
        {
            return GotoLogin();
        }        
        PageReference ExternalPartnerLandingScreen = Page.ExternalPartnerLandingScreen;
        ExternalPartnerLandingScreen.setRedirect(true);
        return ExternalPartnerLandingScreen;
    }

    public PageReference Logout()
    {
        GetAuthenticationCookie();
        Authentication = new AuthenticationModel();
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(Authentication),null,-1,false);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie});         
        return GotoLogin();
    }

    public void GetAuthenticationCookie() 
    {
        Cookie authenticationModelCookie = ApexPages.currentPage().getCookies().get('AuthenticationModel');
        if (authenticationModelCookie == null) 
        {
            Authentication = new AuthenticationModel();
        } 
        else 
        {
            authenticationModelCookie = ApexPages.currentPage().getCookies().get('AuthenticationModel');
            Authentication = (AuthenticationModel)JSON.deserialize(authenticationModelCookie.getValue(), AuthenticationModel.class);
        }
    }

    public void SaveAuthenticationCookie()
    {
        Cookie authenticationModelCookie = new Cookie('AuthenticationModel', Json.serialize(Authentication),null,1800,true);
        system.debug('authenticationModelCookie:  ' + authenticationModelCookie);
        ApexPages.currentPage().setCookies(new Cookie[]{authenticationModelCookie});         
    }

    //End Findings Layout Functions
    
    //Start Finings Login

    public PageReference GotoLogin()
    {
        PageReference findingStart =  Page.ExternalPartnerLogin;
        findingStart.setRedirect(true);
        return findingStart;
    }

    public PageReference LoadLogin()
    {
        ExternalPartnerLoginViewModel = new ExternalPartnerLoginViewModel();
        return null;
    }

    public PageReference Login()
    {
        string emailAddress = ExternalPartnerLoginViewModel.EmailAddress;        
        string password = ExternalPartnerLoginViewModel.Password;
        List<Contact> contacts = [SELECT Id, Email, PasswordHash__c, IsRegistered__c, AccountId, Account.Name, Name, Is_Locked_Out__c FROM Contact WHERE Email =: emailAddress AND Inactive__c = false ];//OK
        if(contacts.size() == 0)
        {
            ExternalPartnerLoginViewModel.LoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
            return null;                        
        }
        if(contacts[0].Is_Locked_Out__c == true)
        {
            ExternalPartnerLoginViewModel.LoginError = 'Your account is locked out. Please reset your password to continue.';
            return null;                        
        }
        Blob passwordBlob = Blob.valueOf(password);
        Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
        string passwordHashString = EncodingUtil.base64Encode(passwordHash);
        if(passwordHashString == contacts[0].PasswordHash__c)
        {
            GetAuthenticationCookie();
            Authentication = new AuthenticationModel();
            Authentication.IsLoggedIn = true;
            Authentication.UsersName = contacts[0].Name;
            Authentication.UserId = contacts[0].Id;
            IncrementExternalPartnerPortalLoginTracking(contacts[0].Id);
            SaveAuthenticationCookie();
        }
        else
        {
            return HandleIncorrectLogin(contacts[0]);            
        }
        
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id in (Select AccountId FROM AccountContactRelation WHERE ContactId =: contacts[0].Id)];
        
        
        
        
        
        
        if(accounts.size() == 1)
        {

            GetAuthenticationCookie();
            Authentication.ExternalPartners = new Map<Id, String>();
            Authentication.ExternalPartners.Put(contacts[0].AccountId , contacts[0].Account.Name);
            Authentication.ExternalPartnerName = contacts[0].Account.Name;
            Authentication.ExternalPartnerId = contacts[0].AccountId;            
            SaveAuthenticationCookie();
            PageReference ExternalPartnerLandingScreen = Page.ExternalPartnerLandingScreen;
            ExternalPartnerLandingScreen.setRedirect(true);
            return ExternalPartnerLandingScreen;
        }
        else
        {
            PageReference ExternalPartnerAccountSelector = Page.ExternalPartnerAccountSelector;
            ExternalPartnerAccountSelector.setRedirect(true);
            return ExternalPartnerAccountSelector;
        }
    }

    private PageReference HandleIncorrectLogin(Contact contact)
    {
        string emailAddress = contact.Email;
        List<Contact> contacts = [SELECT Id, Email, Incorrect_Attempt_Count__c, Is_Locked_Out__c, Time_of_First_Failed_Attempt__c  FROM Contact WHERE Email =: emailAddress AND Inactive__c = false];//OK
        boolean isLockedOut = false;
        DateTime timeOfFirstFailedAttempt = Date.valueOf('2016-01-01 00:00:00');
        if(contacts[0].Time_of_First_Failed_Attempt__c != null)
        {
            timeOfFirstFailedAttempt = contacts[0].Time_of_First_Failed_Attempt__c;
        }
        decimal incorrectAttemptCount = 0;
        if(contacts[0].Incorrect_Attempt_Count__c != null)
        {
            incorrectAttemptCount = contacts[0].Incorrect_Attempt_Count__c;
        }        
        integer minutes = Integer.valueOf(((CurrentDateTime == null ? System.Now() : CurrentDateTime).getTime() - timeOfFirstFailedAttempt.getTime())/(1000*60));
        system.debug('minutes:  ' + minutes);
        if(minutes < 20)
        {
            incorrectAttemptCount = incorrectAttemptCount + 1;
            ExternalPartnerLoginViewModel.LoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
            if(incorrectAttemptCount > 4)
            {
                isLockedOut = true;
                incorrectAttemptCount = 0;
                timeOfFirstFailedAttempt = Date.valueOf('2016-01-01 00:00:00');
                ExternalPartnerLoginViewModel.LoginError = 'Your account has been locked out. Please wait 20 minutes and try again or reset your password.';
            }
        }
        else
        {
            system.debug('now:  ' + CurrentDateTime);
            timeOfFirstFailedAttempt = (CurrentDateTime == null ? System.Now() : CurrentDateTime);
            incorrectAttemptCount =  1;
            ExternalPartnerLoginViewModel.LoginError = 'There was an error with your Email/Password combination.  Please Try Again.';
            
        }
        List<ContactEdit__c> contactEdits = new List<ContactEdit__c>();
        for(Contact c : contacts)
        {
            ContactEdit__c contactEdit = new ContactEdit__c();
            contactEdit.Contact__c = c.Id;
            contactEdit.Incorrect_Attempt_Count__c = incorrectAttemptCount;
            contactEdit.Incorrect_Attempt_Count_Updated__c = true;
            contactEdit.Is_Locked_Out__c = isLockedOut; 
            contactEdit.Is_Locked_Out_Updated__c = true; 
            contactEdit.Time_of_First_Failed_Attempt__c = timeOfFirstFailedAttempt;
            contactEdit.Time_of_First_Failed_Attempt_Updated__c = true;
            
            contactEdits.Add(contactEdit);
        }
        insert contactEdits;
        return null;                    
    }

    public PageReference RequestAccess()
    {
        PageReference ExternalPartnerRequestAccess = Page.ExternalPartnerRequestAccess;
        ExternalPartnerRequestAccess.setRedirect(true);
        return ExternalPartnerRequestAccess;
    }

    public PageReference ResetPassword()
    {
        PageReference externalPartnerResetPassword = Page.ExternalPartnerResetPassword;
        externalPartnerResetPassword.setRedirect(true);
        return externalPartnerResetPassword;
    }

    public PageReference EnterFindingsWithoutLoggingIn()
    {
        List<Complaints__c> complaints = [SELECT Id, Name FROM Complaints__c WHERE Id =: ExternalPartnerLoginViewModel.ComplaintId];
        if(complaints.size() != 1)
        {
            PageErrorMessage  = 'The number and id do not match our records.';
            return null;
        }
        Complaints__c complaint = complaints[0]; 
        if(complaint.Name != + ExternalPartnerLoginViewModel.ComplaintNumber)
        {
            PageErrorMessage  = 'The number and id do not match our records.';
            return null;                
        }
        PageReference FindingReferralSelector = Page.FindingReferralSelector;
        FindingReferralSelector.getParameters().put('complaintId', ExternalPartnerLoginViewModel.ComplaintId);
        FindingReferralSelector.setRedirect(true);
        return FindingReferralSelector;
    }

    public void IncrementExternalPartnerPortalLoginTracking(Id contactId)
    {
        Date today = Date.Today();
        List<External_Partner_Portal_Login_Tracking__c> logins = [SELECT Id FROM External_Partner_Portal_Login_Tracking__c WHERE Contact__c =: contactId AND Login_Date__c =: today];
        if(logins.size() == 0)
        {
            External_Partner_Portal_Login_Tracking__c login = new External_Partner_Portal_Login_Tracking__c();
            login.Contact__c = contactId;
            login.Login_Date__c = Date.Today();
            insert login;
        }

    }
    //End Findings Login

    //Start Findings Agency Selector

    public PageReference ExternalPartnerAccountSelector()
    {
        PageReference ExternalPartnerAccountSelector = Page.ExternalPartnerAccountSelector;
        ExternalPartnerAccountSelector.setRedirect(true);
        return ExternalPartnerAccountSelector;
    } 

    public PageReference LoadExternalPartnerAccountSelector()
    {
        //look into how to get the accounts associated with the contact!
        GetAuthenticationCookie();
        if(!Authentication.IsLoggedIn)
        {
            return GotoLogin();
        }
        ExternalPartnerAccountSelectorViewModel = new ExternalPartnerAccountSelectorViewModel();
        if(Authentication.UserId == null)
        {
            return GotoLogin();
        }
        List<Contact> loggedInContacts = [SELECT Id, Email FROM Contact WHERE Id =: Authentication.UserId Limit 1];//OK
        if(loggedInContacts.size() == 0)
        {
            return GotoLogin();
        }
        
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id IN (SELECT AccountId FROM AccountContactRelation WHERE ContactId =: loggedInContacts[0].Id) ORDER BY Name];
        
        
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', ''));
        for(Account account : accounts)
        {
            Authentication.ExternalPartners.Put(account.Id , account.Name);            
            options.add(new SelectOption(account.Id , account.Name));
        }        
        ExternalPartnerAccountSelectorViewModel.ExternalPartners = options; 
        SaveAuthenticationCookie();
        return null;    
    }

    public PageReference SelectExternalPartner()
    {
        List<Account> externalPartners = [SELECT Id, Name FROM Account WHERE Id =: Authentication.ExternalPartnerId];        
        if(externalPartners.size() > 0)
        {
            Authentication.ExternalPartnerName = externalPartners[0].Name;
            SaveAuthenticationCookie();
            PageReference ExternalPartnerLandingScreen = Page.ExternalPartnerLandingScreen;
            ExternalPartnerLandingScreen.setRedirect(true);
            return ExternalPartnerLandingScreen;
        }
        PageErrorMessage  = 'There was an issue retrieving your agency.  Please contact complaints@calepa.ca.gov for assistance.';
        return null;
    }

    //End Findings Agency Selector

    //Start Findings Request Access
    
    public PageReference LoadExternalPartnerRequestAccess()
    {
        ExternalPartnerRequestAccessViewModel = new ExternalPartnerRequestAccessViewModel();
        return null;
    }

    public PageReference SubmitAccessRequest()
    {
        PageErrorMessage = '';
        string firstName = ExternalPartnerRequestAccessViewModel.FirstName;
        string lastName = ExternalPartnerRequestAccessViewModel.LastName;
        string emailAddress = ExternalPartnerRequestAccessViewModel.EmailAddress;
        List<Contact> contacts = [SELECT Id, Name,IsRegistered__c,Inactive__c FROM Contact WHERE RecordType.Name = 'CalEPA Partner' AND Email =: emailAddress ];//and IsRegistered__c = false AND Inactive__c = false
        if(contacts.size() > 0 && contacts[0].IsRegistered__c == false && contacts[0].Inactive__c == false)
        {
            string resetCode = GenerateRandomString(12);
            ContactEdit__c contactEdit = new ContactEdit__c();
            contactEdit.Contact__c = contacts[0].Id;
            contactEdit.Reset_Code__c = resetCode;
            contactEdit.Reset_Code_Updated__c = true;
            insert contactEdit;      
            if(!Test.isRunningTest())
            {
                List<Messaging.SingleEmailMessage> emails = SendRegistrationEmail(emailAddress, contacts[0].Id, contacts[0].Name, resetCode);
                try
                {
                    Messaging.SendEmailResult result = Messaging.sendEmail(emails)[0];
                }
                catch(emailexception e) 
                {

                }   
            }                          
        }
        else
        {
            if(contacts.Size() == 0)
            {
                /*
                //Start
                string unidentifiedContactsAccountId = null;
                RecordType businessAccountRecordType = [SELECT Id from RecordType WHERE SObjectType = 'Account' AND Name = 'Business Account'];
                List<Account> accounts = [SELECT Id FROM Account Where Name = 'Unidentified Contacts' AND RecordTypeId =: businessAccountRecordType.Id];
                if(accounts.size() > 0)
                {
                    unidentifiedContactsAccountId = accounts[0].Id;
                }
                else
                {
                    Account unidentifiedContactsAccount = new Account();
                    unidentifiedContactsAccount.RecordTypeId = businessAccountRecordType.Id;
                    unidentifiedContactsAccount.Name = 'Unidentified Contacts';
                    insert unidentifiedContactsAccount;
                    unidentifiedContactsAccountId = unidentifiedContactsAccount.Id;
                }
                Contact unidentifiedContact = new Contact();
                unidentifiedContact.AccountId = unidentifiedContactsAccountId;
                unidentifiedContact.FirstName = firstName;
                unidentifiedContact.LastName = lastName;    
                unidentifiedContact.Email = emailAddress;
                insert unidentifiedContact;
                //End
                RecordType recordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Case' AND  Name = 'Complaint Management'];
                Case c = new Case();
                c.ContactId = unidentifiedContact.Id;
                c.RecordTypeId = recordType.Id;
                c.Subject = 'External Partner Portal access request.';
                c.Description = firstName + ' ' + lastName + ' is requesting access to the External Partner Portal.';
                c.Origin = 'Web';
                insert c;
                */
                return Page.ExternalPartnerRequestAccessContact;        
            }
            
        }  
        return Page.ExternalPartnerRequestAccessCheckEmail;
    }    

    @TestVisible
    private List<Messaging.SingleEmailMessage>  SendRegistrationEmail(string emailAddress, string contactId, string name, string resetCode)
    {
        string url = 'https://' + ApexPages.currentPage().getHeaders().get('Host') + '/ExternalPartnerPortal/ExternalPartnerCreatePassword?contactId=' + contactId + '&resetCode=' + resetCode;
        string htmlBodyText = GetRegistrationEmailBody(name, url);
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setHtmlBody(htmlBodyText);
        message.setSubject('Access Approved:  CalEPA Environmental Complaint System External Partner Portal');
        message.setToAddresses(new String[] { emailAddress});
        message.setUseSignature(false);
        message.setSaveAsActivity(false);
        message.setSenderDisplayName('CalEPA Complaints');
        message.setReplyTo('complaints@calepa.ca.gov');
        List<Messaging.SingleEmailMessage>  emails = new List<Messaging.SingleEmailMessage>();
        emails.Add(message);
        return emails;
    }

    private string GetRegistrationEmailBody(string name, string url)
    {
        string emailBody = '';
        emailBody = emailBody + '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">                                                                                  ';
        emailBody = emailBody + '<html xmlns="http://www.w3.org/1999/xhtml">                                                                                                                                                                ';
        emailBody = emailBody + '  <head>                                                                                                                                                                                                   ';
        emailBody = emailBody + '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />                                                                                                                               ';
        emailBody = emailBody + '    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />                                                                                                                                  ';
        emailBody = emailBody + '    <title>Set up a new password for The CalEPA Environmental Complaint System External Partner Portal</title>                                                                                             ';
        emailBody = emailBody + '    <!--                                                                                                                                                                                                   ';
        emailBody = emailBody + '    The style block is collapsed on page load to save you some scrolling.                                                                                                                                  ';
        emailBody = emailBody + '    Postmark automatically inlines all CSS properties for maximum email client                                                                                                                             ';
        emailBody = emailBody + '    compatibility. You can just update styles here, and Postmark does the rest.                                                                                                                            ';
        emailBody = emailBody + '    -->                                                                                                                                                                                                    ';
        emailBody = emailBody + '    <style type="text/css" rel="stylesheet" media="all">                                                                                                                                                   ';
        emailBody = emailBody + '    /* Base ------------------------------ */                                                                                                                                                              ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    *:not(br):not(tr):not(html) {                                                                                                                                                                          ';
        emailBody = emailBody + '      font-family: Arial, \'Helvetica Neue\', Helvetica, sans-serif;                                                                                                                                       ';
        emailBody = emailBody + '      box-sizing: border-box;                                                                                                                                                                              ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    body {                                                                                                                                                                                                 ';
        emailBody = emailBody + '      width: 100% !important;                                                                                                                                                                              ';
        emailBody = emailBody + '      height: 100%;                                                                                                                                                                                        ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      line-height: 1.4;                                                                                                                                                                                    ';
        emailBody = emailBody + '      background-color: #F2F4F6;                                                                                                                                                                           ';
        emailBody = emailBody + '      color: #74787E;                                                                                                                                                                                      ';
        emailBody = emailBody + '      -webkit-text-size-adjust: none;                                                                                                                                                                      ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    p,                                                                                                                                                                                                     ';
        emailBody = emailBody + '    ul,                                                                                                                                                                                                    ';
        emailBody = emailBody + '    ol,                                                                                                                                                                                                    ';
        emailBody = emailBody + '    blockquote {                                                                                                                                                                                           ';
        emailBody = emailBody + '      line-height: 1.4;                                                                                                                                                                                    ';
        emailBody = emailBody + '      text-align: left;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    a {                                                                                                                                                                                                    ';
        emailBody = emailBody + '      color: #3869D4;                                                                                                                                                                                      ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    a img {                                                                                                                                                                                                ';
        emailBody = emailBody + '      border: none;                                                                                                                                                                                        ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    td {                                                                                                                                                                                                   ';
        emailBody = emailBody + '      word-break: break-word;                                                                                                                                                                              ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Layout ------------------------------ */                                                                                                                                                            ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-wrapper {                                                                                                                                                                                       ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      background-color: #F2F4F6;                                                                                                                                                                           ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-content {                                                                                                                                                                                       ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Masthead ----------------------- */                                                                                                                                                                 ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-masthead {                                                                                                                                                                                      ';
        emailBody = emailBody + '      padding: 25px 0;                                                                                                                                                                                     ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-masthead_logo {                                                                                                                                                                                 ';
        emailBody = emailBody + '      width: 94px;                                                                                                                                                                                         ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-masthead_name {                                                                                                                                                                                 ';
        emailBody = emailBody + '      font-size: 16px;                                                                                                                                                                                     ';
        emailBody = emailBody + '      font-weight: bold;                                                                                                                                                                                   ';
        emailBody = emailBody + '      color: #bbbfc3;                                                                                                                                                                                      ';
        emailBody = emailBody + '      text-decoration: none;                                                                                                                                                                               ';
        emailBody = emailBody + '      text-shadow: 0 1px 0 white;                                                                                                                                                                          ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Body ------------------------------ */                                                                                                                                                              ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-body {                                                                                                                                                                                          ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;                                                                                                                                                                       ';
        emailBody = emailBody + '      border-bottom: 1px solid #EDEFF2;                                                                                                                                                                    ';
        emailBody = emailBody + '      background-color: #FFFFFF;                                                                                                                                                                           ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-body_inner {                                                                                                                                                                                    ';
        emailBody = emailBody + '      width: 570px;                                                                                                                                                                                        ';
        emailBody = emailBody + '      margin: 0 auto;                                                                                                                                                                                      ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      -premailer-width: 570px;                                                                                                                                                                             ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      background-color: #FFFFFF;                                                                                                                                                                           ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-footer {                                                                                                                                                                                        ';
        emailBody = emailBody + '      width: 570px;                                                                                                                                                                                        ';
        emailBody = emailBody + '      margin: 0 auto;                                                                                                                                                                                      ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      -premailer-width: 570px;                                                                                                                                                                             ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .email-footer p {                                                                                                                                                                                      ';
        emailBody = emailBody + '      color: #AEAEAE;                                                                                                                                                                                      ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .body-action {                                                                                                                                                                                         ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 30px auto;                                                                                                                                                                                   ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .body-sub {                                                                                                                                                                                            ';
        emailBody = emailBody + '      margin-top: 25px;                                                                                                                                                                                    ';
        emailBody = emailBody + '      padding-top: 25px;                                                                                                                                                                                   ';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;                                                                                                                                                                       ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .content-cell {                                                                                                                                                                                        ';
        emailBody = emailBody + '      padding: 35px;                                                                                                                                                                                       ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .preheader {                                                                                                                                                                                           ';
        emailBody = emailBody + '      display: none !important;                                                                                                                                                                            ';
        emailBody = emailBody + '      visibility: hidden;                                                                                                                                                                                  ';
        emailBody = emailBody + '      mso-hide: all;                                                                                                                                                                                       ';
        emailBody = emailBody + '      font-size: 1px;                                                                                                                                                                                      ';
        emailBody = emailBody + '      line-height: 1px;                                                                                                                                                                                    ';
        emailBody = emailBody + '      max-height: 0;                                                                                                                                                                                       ';
        emailBody = emailBody + '      max-width: 0;                                                                                                                                                                                        ';
        emailBody = emailBody + '      opacity: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      overflow: hidden;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Attribute list ------------------------------ */                                                                                                                                                    ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .attributes {                                                                                                                                                                                          ';
        emailBody = emailBody + '      margin: 0 0 21px;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .attributes_content {                                                                                                                                                                                  ';
        emailBody = emailBody + '      background-color: #EDEFF2;                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 16px;                                                                                                                                                                                       ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .attributes_item {                                                                                                                                                                                     ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Related Items ------------------------------ */                                                                                                                                                     ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .related {                                                                                                                                                                                             ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 25px 0 0 0;                                                                                                                                                                                 ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .related_item {                                                                                                                                                                                        ';
        emailBody = emailBody + '      padding: 10px 0;                                                                                                                                                                                     ';
        emailBody = emailBody + '      color: #74787E;                                                                                                                                                                                      ';
        emailBody = emailBody + '      font-size: 15px;                                                                                                                                                                                     ';
        emailBody = emailBody + '      line-height: 18px;                                                                                                                                                                                   ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .related_item-title {                                                                                                                                                                                  ';
        emailBody = emailBody + '      display: block;                                                                                                                                                                                      ';
        emailBody = emailBody + '      margin: .5em 0 0;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .related_item-thumb {                                                                                                                                                                                  ';
        emailBody = emailBody + '      display: block;                                                                                                                                                                                      ';
        emailBody = emailBody + '      padding-bottom: 10px;                                                                                                                                                                                ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .related_heading {                                                                                                                                                                                     ';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;                                                                                                                                                                       ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '      padding: 25px 0 10px;                                                                                                                                                                                ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Discount Code ------------------------------ */                                                                                                                                                     ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .discount {                                                                                                                                                                                            ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 24px;                                                                                                                                                                                       ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      background-color: #EDEFF2;                                                                                                                                                                           ';
        emailBody = emailBody + '      border: 2px dashed #9BA2AB;                                                                                                                                                                          ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .discount_heading {                                                                                                                                                                                    ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .discount_body {                                                                                                                                                                                       ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '      font-size: 15px;                                                                                                                                                                                     ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Social Icons ------------------------------ */                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .social {                                                                                                                                                                                              ';
        emailBody = emailBody + '      width: auto;                                                                                                                                                                                         ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .social td {                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '      width: auto;                                                                                                                                                                                         ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .social_icon {                                                                                                                                                                                         ';
        emailBody = emailBody + '      height: 20px;                                                                                                                                                                                        ';
        emailBody = emailBody + '      margin: 0 8px 10px 8px;                                                                                                                                                                              ';
        emailBody = emailBody + '      padding: 0;                                                                                                                                                                                          ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Data table ------------------------------ */                                                                                                                                                        ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase {                                                                                                                                                                                            ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 35px 0;                                                                                                                                                                                     ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase_content {                                                                                                                                                                                    ';
        emailBody = emailBody + '      width: 100%;                                                                                                                                                                                         ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      padding: 25px 0 0 0;                                                                                                                                                                                 ';
        emailBody = emailBody + '      -premailer-width: 100%;                                                                                                                                                                              ';
        emailBody = emailBody + '      -premailer-cellpadding: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '      -premailer-cellspacing: 0;                                                                                                                                                                           ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase_item {                                                                                                                                                                                       ';
        emailBody = emailBody + '      padding: 10px 0;                                                                                                                                                                                     ';
        emailBody = emailBody + '      color: #74787E;                                                                                                                                                                                      ';
        emailBody = emailBody + '      font-size: 15px;                                                                                                                                                                                     ';
        emailBody = emailBody + '      line-height: 18px;                                                                                                                                                                                   ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase_heading {                                                                                                                                                                                    ';
        emailBody = emailBody + '      padding-bottom: 8px;                                                                                                                                                                                 ';
        emailBody = emailBody + '      border-bottom: 1px solid #EDEFF2;                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase_heading p {                                                                                                                                                                                  ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      color: #9BA2AB;                                                                                                                                                                                      ';
        emailBody = emailBody + '      font-size: 12px;                                                                                                                                                                                     ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase_footer {                                                                                                                                                                                     ';
        emailBody = emailBody + '      padding-top: 15px;                                                                                                                                                                                   ';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;                                                                                                                                                                       ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase_total {                                                                                                                                                                                      ';
        emailBody = emailBody + '      margin: 0;                                                                                                                                                                                           ';
        emailBody = emailBody + '      text-align: right;                                                                                                                                                                                   ';
        emailBody = emailBody + '      font-weight: bold;                                                                                                                                                                                   ';
        emailBody = emailBody + '      color: #2F3133;                                                                                                                                                                                      ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .purchase_total--label {                                                                                                                                                                               ';
        emailBody = emailBody + '      padding: 0 15px 0 0;                                                                                                                                                                                 ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Utilities ------------------------------ */                                                                                                                                                         ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .align-right {                                                                                                                                                                                         ';
        emailBody = emailBody + '      text-align: right;                                                                                                                                                                                   ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .align-left {                                                                                                                                                                                          ';
        emailBody = emailBody + '      text-align: left;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .align-center {                                                                                                                                                                                        ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /*Media Queries ------------------------------ */                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    @media only screen and (max-width: 600px) {                                                                                                                                                            ';
        emailBody = emailBody + '      .email-body_inner,                                                                                                                                                                                   ';
        emailBody = emailBody + '      .email-footer {                                                                                                                                                                                      ';
        emailBody = emailBody + '        width: 100% !important;                                                                                                                                                                            ';
        emailBody = emailBody + '      }                                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    @media only screen and (max-width: 500px) {                                                                                                                                                            ';
        emailBody = emailBody + '      .button {                                                                                                                                                                                            ';
        emailBody = emailBody + '        width: 100% !important;                                                                                                                                                                            ';
        emailBody = emailBody + '      }                                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Buttons ------------------------------ */                                                                                                                                                           ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .button {                                                                                                                                                                                              ';
        emailBody = emailBody + '      background-color: #3869D4;                                                                                                                                                                           ';
        emailBody = emailBody + '      border-top: 10px solid #3869D4;                                                                                                                                                                      ';
        emailBody = emailBody + '      border-right: 18px solid #3869D4;                                                                                                                                                                    ';
        emailBody = emailBody + '      border-bottom: 10px solid #3869D4;                                                                                                                                                                   ';
        emailBody = emailBody + '      border-left: 18px solid #3869D4;                                                                                                                                                                     ';
        emailBody = emailBody + '      display: inline-block;                                                                                                                                                                               ';
        emailBody = emailBody + '      color: #FFF;                                                                                                                                                                                         ';
        emailBody = emailBody + '      text-decoration: none;                                                                                                                                                                               ';
        emailBody = emailBody + '      border-radius: 3px;                                                                                                                                                                                  ';
        emailBody = emailBody + '      box-shadow: 0 2px 3px rgba(0, 0, 0, 0.16);                                                                                                                                                           ';
        emailBody = emailBody + '      -webkit-text-size-adjust: none;                                                                                                                                                                      ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .button--green {                                                                                                                                                                                       ';
        emailBody = emailBody + '      background-color: #22BC66;                                                                                                                                                                           ';
        emailBody = emailBody + '      border-top: 10px solid #22BC66;                                                                                                                                                                      ';
        emailBody = emailBody + '      border-right: 18px solid #22BC66;                                                                                                                                                                    ';
        emailBody = emailBody + '      border-bottom: 10px solid #22BC66;                                                                                                                                                                   ';
        emailBody = emailBody + '      border-left: 18px solid #22BC66;                                                                                                                                                                     ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    .button--red {                                                                                                                                                                                         ';
        emailBody = emailBody + '      background-color: #FF6136;                                                                                                                                                                           ';
        emailBody = emailBody + '      border-top: 10px solid #FF6136;                                                                                                                                                                      ';
        emailBody = emailBody + '      border-right: 18px solid #FF6136;                                                                                                                                                                    ';
        emailBody = emailBody + '      border-bottom: 10px solid #FF6136;                                                                                                                                                                   ';
        emailBody = emailBody + '      border-left: 18px solid #FF6136;                                                                                                                                                                     ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    /* Type ------------------------------ */                                                                                                                                                              ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    h1 {                                                                                                                                                                                                   ';
        emailBody = emailBody + '      margin-top: 0;                                                                                                                                                                                       ';
        emailBody = emailBody + '      color: #2F3133;                                                                                                                                                                                      ';
        emailBody = emailBody + '      font-size: 19px;                                                                                                                                                                                     ';
        emailBody = emailBody + '      font-weight: bold;                                                                                                                                                                                   ';
        emailBody = emailBody + '      text-align: left;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    h2 {                                                                                                                                                                                                   ';
        emailBody = emailBody + '      margin-top: 0;                                                                                                                                                                                       ';
        emailBody = emailBody + '      color: #2F3133;                                                                                                                                                                                      ';
        emailBody = emailBody + '      font-size: 16px;                                                                                                                                                                                     ';
        emailBody = emailBody + '      font-weight: bold;                                                                                                                                                                                   ';
        emailBody = emailBody + '      text-align: left;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    h3 {                                                                                                                                                                                                   ';
        emailBody = emailBody + '      margin-top: 0;                                                                                                                                                                                       ';
        emailBody = emailBody + '      color: #2F3133;                                                                                                                                                                                      ';
        emailBody = emailBody + '      font-size: 14px;                                                                                                                                                                                     ';
        emailBody = emailBody + '      font-weight: bold;                                                                                                                                                                                   ';
        emailBody = emailBody + '      text-align: left;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    p {                                                                                                                                                                                                    ';
        emailBody = emailBody + '      margin-top: 0;                                                                                                                                                                                       ';
        emailBody = emailBody + '      color: #74787E;                                                                                                                                                                                      ';
        emailBody = emailBody + '      font-size: 16px;                                                                                                                                                                                     ';
        emailBody = emailBody + '      line-height: 1.5em;                                                                                                                                                                                  ';
        emailBody = emailBody + '      text-align: left;                                                                                                                                                                                    ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    p.sub {                                                                                                                                                                                                ';
        emailBody = emailBody + '      font-size: 12px;                                                                                                                                                                                     ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '                                                                                                                                                                                                           ';
        emailBody = emailBody + '    p.center {                                                                                                                                                                                             ';
        emailBody = emailBody + '      text-align: center;                                                                                                                                                                                  ';
        emailBody = emailBody + '    }                                                                                                                                                                                                      ';
        emailBody = emailBody + '    </style>                                                                                                                                                                                               ';
        emailBody = emailBody + '  </head>                                                                                                                                                                                                  ';
        emailBody = emailBody + '  <body>                                                                                                                                                                                                   ';
        emailBody = emailBody + '    <table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0">                                                                                                                             ';
        emailBody = emailBody + '      <tr>                                                                                                                                                                                                 ';
        emailBody = emailBody + '        <td align="center">                                                                                                                                                                                ';
        emailBody = emailBody + '          <table class="email-content" width="100%" cellpadding="0" cellspacing="0">                                                                                                                       ';
        emailBody = emailBody + '            <!-- Email Body -->                                                                                                                                                                            ';
        emailBody = emailBody + '            <tr>                                                                                                                                                                                           ';
        emailBody = emailBody + '              <td class="email-body" width="100%" cellpadding="0" cellspacing="0">                                                                                                                         ';
        emailBody = emailBody + '                <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0">                                                                                                ';
        emailBody = emailBody + '                  <!-- Body content -->                                                                                                                                                                    ';
        emailBody = emailBody + '                  <tr>                                                                                                                                                                                     ';
        emailBody = emailBody + '                    <td class="content-cell">                                                                                                                                                              ';
        emailBody = emailBody + '                      <h1>Dear ' + name + ',</h1>                                                                                                                                                          ';
        emailBody = emailBody + '                      <p>You recently requested access to the CalEPA Enviromental Complaint System External Partner Portal.  Your access request has been approved.  Use the button below to register.</p> ';
        emailBody = emailBody + '                      <p>If you did not request access, please ignore this email and reply to let us know.</p>                                                                                             ';
        emailBody = emailBody + '                      <!-- Action -->                                                                                                                                                                      ';
        emailBody = emailBody + '                      <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0">                                                                                              ';
        emailBody = emailBody + '                        <tr>                                                                                                                                                                               ';
        emailBody = emailBody + '                          <td align="center">                                                                                                                                                              ';
        emailBody = emailBody + '                            <!-- Border based button                                                                                                                                                       ';
        emailBody = emailBody + '                       https://litmus.com/blog/a-guide-to-bulletproof-buttons-in-email-design -->                                                                                                          ';
        emailBody = emailBody + '                            <table width="100%" border="0" cellspacing="0" cellpadding="0">                                                                                                                ';
        emailBody = emailBody + '                              <tr>                                                                                                                                                                         ';
        emailBody = emailBody + '                                <td align="center">                                                                                                                                                        ';
        emailBody = emailBody + '                                  <table border="0" cellspacing="0" cellpadding="0">                                                                                                                       ';
        emailBody = emailBody + '                                    <tr>                                                                                                                                                                   ';
        emailBody = emailBody + '                                      <td>                                                                                                                                                                 ';
        emailBody = emailBody + '                                        <a href="' + url + '" class="button button--green" target="_blank">Register</a>                                                                            ';
        emailBody = emailBody + '                                      </td>                                                                                                                                                                ';
        emailBody = emailBody + '                                    </tr>                                                                                                                                                                  ';
        emailBody = emailBody + '                                  </table>                                                                                                                                                                 ';
        emailBody = emailBody + '                                </td>                                                                                                                                                                      ';
        emailBody = emailBody + '                              </tr>                                                                                                                                                                        ';
        emailBody = emailBody + '                            </table>                                                                                                                                                                       ';
        emailBody = emailBody + '                          </td>                                                                                                                                                                            ';
        emailBody = emailBody + '                        </tr>                                                                                                                                                                              ';
        emailBody = emailBody + '                      </table>                                                                                                                                                                             ';
        emailBody = emailBody + '                      <p>Thanks,                                                                                                                                                                           ';
        emailBody = emailBody + '                        <br><a href="mailto:complaints@calepa.ca.gov">California Environmental Protection Agency</p>                                                                                       ';
        emailBody = emailBody + '                      <!-- Sub copy -->                                                                                                                                                                    ';
        emailBody = emailBody + '                      <table class="body-sub">                                                                                                                                                             ';
        emailBody = emailBody + '                        <tr>                                                                                                                                                                               ';
        emailBody = emailBody + '                          <td>                                                                                                                                                                             ';
        emailBody = emailBody + '                            <p class="sub">If you’re having trouble with the button above, copy and paste the URL below into your web browser.</p>                                                         ';
        emailBody = emailBody + '                            <p class="sub">' + url + '</p>                                                                                                                                                 ';
        emailBody = emailBody + '                          </td>                                                                                                                                                                            ';
        emailBody = emailBody + '                        </tr>                                                                                                                                                                              ';
        emailBody = emailBody + '                      </table>                                                                                                                                                                             ';
        emailBody = emailBody + '                    </td>                                                                                                                                                                                  ';
        emailBody = emailBody + '                  </tr>                                                                                                                                                                                    ';
        emailBody = emailBody + '                </table>                                                                                                                                                                                   ';
        emailBody = emailBody + '              </td>                                                                                                                                                                                        ';
        emailBody = emailBody + '            </tr>                                                                                                                                                                                          ';
        emailBody = emailBody + '          </table>                                                                                                                                                                                         ';
        emailBody = emailBody + '        </td>                                                                                                                                                                                              ';
        emailBody = emailBody + '      </tr>                                                                                                                                                                                                ';
        emailBody = emailBody + '    </table>                                                                                                                                                                                               ';
        emailBody = emailBody + '  </body>                                                                                                                                                                                                  ';
        emailBody = emailBody + '</html>                                                                                                                                                                                                    ';
        return emailBody;
    }

    //End Findings Request Access

    //Start Findings Create Password

    public PageReference LoadExternalPartnerCreatePassword()
    {
        string contactId = ApexPages.currentPage().getParameters().get('contactId');
        system.debug('contactId:  ' + contactId);
        string resetCode = ApexPages.currentPage().getParameters().get('resetCode');        
        system.debug('resetCode:  ' + resetCode);
        if(String.isBlank(contactId))
        {
            return GotoLogin();
        }
        List<Contact> contacts = [SELECT Id, Email, Reset_Code__c FROM Contact WHERE Id =: contactId];
        if(contacts.size() == 0)
        {
            return GotoLogin();
        }
        if(String.isBlank(resetCode))
        {
            return GotoLogin();
        }
        if(contacts[0].Reset_Code__c == resetCode)
        {
            ExternalPartnerCreatePasswordViewModel = new ExternalPartnerCreatePasswordViewModel();
            ExternalPartnerCreatePasswordViewModel.ContactId = contacts[0].Id;            
            ExternalPartnerCreatePasswordViewModel.EmailAddress = contacts[0].Email; 
            return null;
        }
        else
        {
            return GotoLogin();
        }
    }

    public PageReference SavePassword()
    {
        
        if(String.IsEmpty(ExternalPartnerCreatePasswordViewModel.Password))
        {
            PageErrorMessage  =  'Please Provide a Password.';
            return null;
        }
        if(ExternalPartnerCreatePasswordViewModel.Password.length() < 8)
        {
            PageErrorMessage  =  'Your Password Must Contain At Least 8 Characters.';
            return null;
        }        
        if(!Pattern.matches('.*[A-Z]+.*', ExternalPartnerCreatePasswordViewModel.Password))
        {
            PageErrorMessage  =  'Your Password Must Contain At Least One Uppercase Letter.';
            return null;            
        }
        if(!Pattern.matches('.*[a-z]+.*', ExternalPartnerCreatePasswordViewModel.Password)) 
        {
            PageErrorMessage  =  'Your Password Must Contain At Least One Lowercase Letter.';
            return null;            
        }
        if(!Pattern.matches('.*[0-9]+.*', ExternalPartnerCreatePasswordViewModel.Password))
        {
            PageErrorMessage  =  'Your Password Must Contain At Least One Numeral.';
            return null;            
        }
        if(ExternalPartnerCreatePasswordViewModel.Password.length() > 16)
        {
            PageErrorMessage  =  'Your Password Can Be No More Than 16 Characters.';
            return null;
        }    
        if(ExternalPartnerCreatePasswordViewModel.Password != ExternalPartnerCreatePasswordViewModel.ConfirmPassword)
        {
            PageErrorMessage  =  'Your Passwords Do Not Match';
            return null;
        }
        string contactId = ExternalPartnerCreatePasswordViewModel.ContactId;        
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Id =: contactId];//OK
        string password = ExternalPartnerCreatePasswordViewModel.Password;
        if(contacts.size() > 0)
        {
            ContactEdit__c contactEdit = new ContactEdit__c();
            Blob passwordBlob = Blob.valueOf(password);
            Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
            contactEdit.Contact__c = contacts[0].Id;
            contactEdit.PasswordHash__c = EncodingUtil.base64Encode(passwordHash);//.ToString(); 
            contactEdit.Password_Hash_Updated__c = true; 
            contactEdit.IsRegistered__c = true;
            contactEdit.Is_Registered_Updated__c = true;
            insert contactEdit;
            return GotoLogin();
        }
        PageErrorMessage  =  'There was a problem registering your account, please contact complaints@calepa.ca.gov for assistance.';
        return null;
    }

    //End Findings Create Password

    //Start External Partner Reset Password

    public PageReference LoadExternalPartnerResetPassword()
    { 
        FindingsResetPasswordViewModel = new FindingsResetPasswordViewModel();
        return null;
    }

    public PageReference SubmitPasswordReset()
    {
        string emailAddress = FindingsResetPasswordViewModel.EmailAddress;
        List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE RecordType.Name = 'CalEPA Partner' AND Email =: emailAddress and IsRegistered__c = true AND Inactive__c = false ];//OK
        if(contacts.size() > 0)
        {
            string resetCode = GenerateRandomString(12);
            ContactEdit__c contactEdit = new ContactEdit__c();
            contactEdit.Contact__c = contacts[0].Id;
            contactEdit.Reset_Code__c = resetCode;
            contactEdit.Reset_Code_Updated__c = true;
            insert contactEdit;            
            if(!Test.isRunningTest())
            {
                List<Messaging.SingleEmailMessage> emails = SendResetEmail(emailAddress, contacts[0].Id, contacts[0].Name, resetCode);
                try
                {
                    Messaging.SendEmailResult result = Messaging.sendEmail(emails)[0];
                }
                catch(emailexception e) 
                {

                }  
            }
            return GotoLogin();
        }
        PageErrorMessage  =  FindingsResetPasswordViewModel.EmailAddress + ' could not be found in our system.  Please contact complaints@calepa.ca.gov if you believe this to be a mistake.';
        return null; 
    }

    @TestVisible 
    private string GenerateRandomString(Integer len) 
    {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) 
        {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }

    @TestVisible
    private List<Messaging.SingleEmailMessage>  SendResetEmail(string emailAddress, string contactId, string name, string resetCode)
    {
        string url = 'https://' + ApexPages.currentPage().getHeaders().get('Host') + '/ExternalPartnerPortal/CompleteExternalPartnerResetPassword?contactId=' + contactId + '&resetCode=' + resetCode;
        string htmlBodyText = GetResetEmailBody(name, url);
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setHtmlBody(htmlBodyText);
        message.setSubject('Password Reset:  CalEPA Environmental Complaint System External Partner Portal');
        message.setToAddresses(new String[] { emailAddress});
        message.setUseSignature(false);
        message.setSaveAsActivity(false);
        message.setSenderDisplayName('CalEPA Complaints');
        message.setReplyTo('complaints@calepa.ca.gov');
        List<Messaging.SingleEmailMessage>  emails = new List<Messaging.SingleEmailMessage>();
        emails.Add(message);
        return emails;
    }

    @TestVisible 
    private string GetResetEmailBody(string name, string url)
    {
        string emailBody = '';
        emailBody = emailBody + '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">';
        emailBody = emailBody + '<html xmlns="http://www.w3.org/1999/xhtml">';
        emailBody = emailBody + '  <head>';
        emailBody = emailBody + '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />';
        emailBody = emailBody + '    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />';
        emailBody = emailBody + '    <title>Set up a new password for The CalEPA Environmental Complaint System External Partner Portal</title>';
        emailBody = emailBody + '    <!-- ';
        emailBody = emailBody + '    The style block is collapsed on page load to save you some scrolling.';
        emailBody = emailBody + '    Postmark automatically inlines all CSS properties for maximum email client ';
        emailBody = emailBody + '    compatibility. You can just update styles here, and Postmark does the rest.';
        emailBody = emailBody + '    -->';
        emailBody = emailBody + '    <style type="text/css" rel="stylesheet" media="all">';
        emailBody = emailBody + '    /* Base ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    *:not(br):not(tr):not(html) {';
        emailBody = emailBody + '      font-family: Arial, \'Helvetica Neue\', Helvetica, sans-serif;';
        emailBody = emailBody + '      box-sizing: border-box;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    body {';
        emailBody = emailBody + '      width: 100% !important;';
        emailBody = emailBody + '      height: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      line-height: 1.4;';
        emailBody = emailBody + '      background-color: #F2F4F6;';
        emailBody = emailBody + '      color: #74787E;';
        emailBody = emailBody + '      -webkit-text-size-adjust: none;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    p,';
        emailBody = emailBody + '    ul,';
        emailBody = emailBody + '    ol,';
        emailBody = emailBody + '    blockquote {';
        emailBody = emailBody + '      line-height: 1.4;';
        emailBody = emailBody + '      text-align: left;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    a {';
        emailBody = emailBody + '      color: #3869D4;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    a img {';
        emailBody = emailBody + '      border: none;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    td {';
        emailBody = emailBody + '      word-break: break-word;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Layout ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-wrapper {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '      background-color: #F2F4F6;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-content {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Masthead ----------------------- */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-masthead {';
        emailBody = emailBody + '      padding: 25px 0;';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-masthead_logo {';
        emailBody = emailBody + '      width: 94px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-masthead_name {';
        emailBody = emailBody + '      font-size: 16px;';
        emailBody = emailBody + '      font-weight: bold;';
        emailBody = emailBody + '      color: #bbbfc3;';
        emailBody = emailBody + '      text-decoration: none;';
        emailBody = emailBody + '      text-shadow: 0 1px 0 white;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Body ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-body {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;';
        emailBody = emailBody + '      border-bottom: 1px solid #EDEFF2;';
        emailBody = emailBody + '      background-color: #FFFFFF;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-body_inner {';
        emailBody = emailBody + '      width: 570px;';
        emailBody = emailBody + '      margin: 0 auto;';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '      -premailer-width: 570px;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '      background-color: #FFFFFF;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-footer {';
        emailBody = emailBody + '      width: 570px;';
        emailBody = emailBody + '      margin: 0 auto;';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '      -premailer-width: 570px;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .email-footer p {';
        emailBody = emailBody + '      color: #AEAEAE;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .body-action {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 30px auto;';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .body-sub {';
        emailBody = emailBody + '      margin-top: 25px;';
        emailBody = emailBody + '      padding-top: 25px;';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .content-cell {';
        emailBody = emailBody + '      padding: 35px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .preheader {';
        emailBody = emailBody + '      display: none !important;';
        emailBody = emailBody + '      visibility: hidden;';
        emailBody = emailBody + '      mso-hide: all;';
        emailBody = emailBody + '      font-size: 1px;';
        emailBody = emailBody + '      line-height: 1px;';
        emailBody = emailBody + '      max-height: 0;';
        emailBody = emailBody + '      max-width: 0;';
        emailBody = emailBody + '      opacity: 0;';
        emailBody = emailBody + '      overflow: hidden;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Attribute list ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .attributes {';
        emailBody = emailBody + '      margin: 0 0 21px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .attributes_content {';
        emailBody = emailBody + '      background-color: #EDEFF2;';
        emailBody = emailBody + '      padding: 16px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .attributes_item {';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Related Items ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .related {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      padding: 25px 0 0 0;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .related_item {';
        emailBody = emailBody + '      padding: 10px 0;';
        emailBody = emailBody + '      color: #74787E;';
        emailBody = emailBody + '      font-size: 15px;';
        emailBody = emailBody + '      line-height: 18px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .related_item-title {';
        emailBody = emailBody + '      display: block;';
        emailBody = emailBody + '      margin: .5em 0 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .related_item-thumb {';
        emailBody = emailBody + '      display: block;';
        emailBody = emailBody + '      padding-bottom: 10px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .related_heading {';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '      padding: 25px 0 10px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Discount Code ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .discount {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      padding: 24px;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '      background-color: #EDEFF2;';
        emailBody = emailBody + '      border: 2px dashed #9BA2AB;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .discount_heading {';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .discount_body {';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '      font-size: 15px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Social Icons ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .social {';
        emailBody = emailBody + '      width: auto;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .social td {';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '      width: auto;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .social_icon {';
        emailBody = emailBody + '      height: 20px;';
        emailBody = emailBody + '      margin: 0 8px 10px 8px;';
        emailBody = emailBody + '      padding: 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Data table ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      padding: 35px 0;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase_content {';
        emailBody = emailBody + '      width: 100%;';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      padding: 25px 0 0 0;';
        emailBody = emailBody + '      -premailer-width: 100%;';
        emailBody = emailBody + '      -premailer-cellpadding: 0;';
        emailBody = emailBody + '      -premailer-cellspacing: 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase_item {';
        emailBody = emailBody + '      padding: 10px 0;';
        emailBody = emailBody + '      color: #74787E;';
        emailBody = emailBody + '      font-size: 15px;';
        emailBody = emailBody + '      line-height: 18px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase_heading {';
        emailBody = emailBody + '      padding-bottom: 8px;';
        emailBody = emailBody + '      border-bottom: 1px solid #EDEFF2;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase_heading p {';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      color: #9BA2AB;';
        emailBody = emailBody + '      font-size: 12px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase_footer {';
        emailBody = emailBody + '      padding-top: 15px;';
        emailBody = emailBody + '      border-top: 1px solid #EDEFF2;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase_total {';
        emailBody = emailBody + '      margin: 0;';
        emailBody = emailBody + '      text-align: right;';
        emailBody = emailBody + '      font-weight: bold;';
        emailBody = emailBody + '      color: #2F3133;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .purchase_total--label {';
        emailBody = emailBody + '      padding: 0 15px 0 0;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Utilities ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .align-right {';
        emailBody = emailBody + '      text-align: right;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .align-left {';
        emailBody = emailBody + '      text-align: left;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .align-center {';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /*Media Queries ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    @media only screen and (max-width: 600px) {';
        emailBody = emailBody + '      .email-body_inner,';
        emailBody = emailBody + '      .email-footer {';
        emailBody = emailBody + '        width: 100% !important;';
        emailBody = emailBody + '      }';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    @media only screen and (max-width: 500px) {';
        emailBody = emailBody + '      .button {';
        emailBody = emailBody + '        width: 100% !important;';
        emailBody = emailBody + '      }';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Buttons ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .button {';
        emailBody = emailBody + '      background-color: #3869D4;';
        emailBody = emailBody + '      border-top: 10px solid #3869D4;';
        emailBody = emailBody + '      border-right: 18px solid #3869D4;';
        emailBody = emailBody + '      border-bottom: 10px solid #3869D4;';
        emailBody = emailBody + '      border-left: 18px solid #3869D4;';
        emailBody = emailBody + '      display: inline-block;';
        emailBody = emailBody + '      color: #FFF;';
        emailBody = emailBody + '      text-decoration: none;';
        emailBody = emailBody + '      border-radius: 3px;';
        emailBody = emailBody + '      box-shadow: 0 2px 3px rgba(0, 0, 0, 0.16);';
        emailBody = emailBody + '      -webkit-text-size-adjust: none;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .button--green {';
        emailBody = emailBody + '      background-color: #22BC66;';
        emailBody = emailBody + '      border-top: 10px solid #22BC66;';
        emailBody = emailBody + '      border-right: 18px solid #22BC66;';
        emailBody = emailBody + '      border-bottom: 10px solid #22BC66;';
        emailBody = emailBody + '      border-left: 18px solid #22BC66;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    .button--red {';
        emailBody = emailBody + '      background-color: #FF6136;';
        emailBody = emailBody + '      border-top: 10px solid #FF6136;';
        emailBody = emailBody + '      border-right: 18px solid #FF6136;';
        emailBody = emailBody + '      border-bottom: 10px solid #FF6136;';
        emailBody = emailBody + '      border-left: 18px solid #FF6136;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    /* Type ------------------------------ */';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    h1 {';
        emailBody = emailBody + '      margin-top: 0;';
        emailBody = emailBody + '      color: #2F3133;';
        emailBody = emailBody + '      font-size: 19px;';
        emailBody = emailBody + '      font-weight: bold;';
        emailBody = emailBody + '      text-align: left;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    h2 {';
        emailBody = emailBody + '      margin-top: 0;';
        emailBody = emailBody + '      color: #2F3133;';
        emailBody = emailBody + '      font-size: 16px;';
        emailBody = emailBody + '      font-weight: bold;';
        emailBody = emailBody + '      text-align: left;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    h3 {';
        emailBody = emailBody + '      margin-top: 0;';
        emailBody = emailBody + '      color: #2F3133;';
        emailBody = emailBody + '      font-size: 14px;';
        emailBody = emailBody + '      font-weight: bold;';
        emailBody = emailBody + '      text-align: left;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    p {';
        emailBody = emailBody + '      margin-top: 0;';
        emailBody = emailBody + '      color: #74787E;';
        emailBody = emailBody + '      font-size: 16px;';
        emailBody = emailBody + '      line-height: 1.5em;';
        emailBody = emailBody + '      text-align: left;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    p.sub {';
        emailBody = emailBody + '      font-size: 12px;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    ';
        emailBody = emailBody + '    p.center {';
        emailBody = emailBody + '      text-align: center;';
        emailBody = emailBody + '    }';
        emailBody = emailBody + '    </style>';
        emailBody = emailBody + '  </head>';
        emailBody = emailBody + '  <body>';
        emailBody = emailBody + '    <table class="email-wrapper" width="100%" cellpadding="0" cellspacing="0">';
        emailBody = emailBody + '      <tr>';
        emailBody = emailBody + '        <td align="center">';
        emailBody = emailBody + '          <table class="email-content" width="100%" cellpadding="0" cellspacing="0">';
        emailBody = emailBody + '            <!-- Email Body -->';
        emailBody = emailBody + '            <tr>';
        emailBody = emailBody + '              <td class="email-body" width="100%" cellpadding="0" cellspacing="0">';
        emailBody = emailBody + '                <table class="email-body_inner" align="center" width="570" cellpadding="0" cellspacing="0">';
        emailBody = emailBody + '                  <!-- Body content -->';
        emailBody = emailBody + '                  <tr>';
        emailBody = emailBody + '                    <td class="content-cell">';
        emailBody = emailBody + '                      <h1>Dear ' + name + ',</h1>';
        emailBody = emailBody + '                      <p>You recently requested to reset your password for The CalEPA Environmental Complaint System External Partner Portal account. Use the button below to reset it.</p>'; 
        emailBody = emailBody + '                      <p>If you did not request a password reset, please ignore this email and reply to let us know.</p>'; 
        emailBody = emailBody + '                      <!-- Action -->';
        emailBody = emailBody + '                      <table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0">';
        emailBody = emailBody + '                        <tr>';
        emailBody = emailBody + '                          <td align="center">';
        emailBody = emailBody + '                            <!-- Border based button';
        emailBody = emailBody + '                       https://litmus.com/blog/a-guide-to-bulletproof-buttons-in-email-design -->';
        emailBody = emailBody + '                            <table width="100%" border="0" cellspacing="0" cellpadding="0">';
        emailBody = emailBody + '                              <tr>';
        emailBody = emailBody + '                                <td align="center">';
        emailBody = emailBody + '                                  <table border="0" cellspacing="0" cellpadding="0">';
        emailBody = emailBody + '                                    <tr>';
        emailBody = emailBody + '                                      <td>';
        emailBody = emailBody + '                                        <a href="' + url + '" class="button button--green" target="_blank">Reset your password</a>';
        emailBody = emailBody + '                                      </td>';
        emailBody = emailBody + '                                    </tr>';
        emailBody = emailBody + '                                  </table>';
        emailBody = emailBody + '                                </td>';
        emailBody = emailBody + '                              </tr>';
        emailBody = emailBody + '                            </table>'; 
        emailBody = emailBody + '                          </td>';
        emailBody = emailBody + '                        </tr>';
        emailBody = emailBody + '                      </table>';
        emailBody = emailBody + '                      <p>Thanks,';
        emailBody = emailBody + '                        <br><a href="mailto:complaints@calepa.ca.gov">California Environmental Protection Agency</p>';
        emailBody = emailBody + '                      <!-- Sub copy -->';
        emailBody = emailBody + '                      <table class="body-sub">';
        emailBody = emailBody + '                        <tr>';
        emailBody = emailBody + '                          <td>';
        emailBody = emailBody + '                            <p class="sub">If you’re having trouble with the button above, copy and paste the URL below into your web browser.</p>';
        emailBody = emailBody + '                            <p class="sub">' + url + '</p>';
        emailBody = emailBody + '                          </td>';
        emailBody = emailBody + '                        </tr>';
        emailBody = emailBody + '                      </table>';
        emailBody = emailBody + '                    </td>';
        emailBody = emailBody + '                  </tr>';
        emailBody = emailBody + '                </table>';
        emailBody = emailBody + '              </td>';
        emailBody = emailBody + '            </tr>';
        emailBody = emailBody + '          </table>';
        emailBody = emailBody + '        </td>';
        emailBody = emailBody + '      </tr>';
        emailBody = emailBody + '    </table>';
        emailBody = emailBody + '  </body>';
        emailBody = emailBody + '</html>                                                                                                                                                                                    ';
        return emailBody;
    }

    public PageReference LoadCompleteExternalPartnerResetPassword()
    {
        if(ApexPages.currentPage().getParameters().get('contactId') == null  || ApexPages.currentPage().getParameters().get('resetCode') == null)
        {           
            return GotoLogin();
        }
        CompleteExternalPartnerResetPasswordViewModel = new CompleteExternalPartnerResetPasswordViewModel();
        CompleteExternalPartnerResetPasswordViewModel.ContactId = ApexPages.currentPage().getParameters().get('contactId');
        CompleteExternalPartnerResetPasswordViewModel.ResetCode = ApexPages.currentPage().getParameters().get('resetCode');
        List<Contact> contacts = [SELECT Id, Name, Email, Reset_Code__c FROM Contact WHERE Id =: CompleteExternalPartnerResetPasswordViewModel.ContactId]; //OK
        if(contacts.size() > 0)
        {
            if(contacts[0].Reset_Code__c == CompleteExternalPartnerResetPasswordViewModel.ResetCode)
            {
                CompleteExternalPartnerResetPasswordViewModel.EmailAddress = contacts[0].Email;
                return null;
            }
        }
        return GotoLogin();
    }

    public PageReference CompleteExternalPartnerResetPassword()
    {
        if(CompleteExternalPartnerResetPasswordViewModel.Password == '')
        {            
            PageErrorMessage  =  'Please Provide a Password.';
            return null;
        }
        if(CompleteExternalPartnerResetPasswordViewModel.Password.length() < 8)
        {
            PageErrorMessage  =  'Your Password Must Contain At Least 8 Characters.';
            return null;
        }        
        if(!Pattern.matches('.*[A-Z]+.*', CompleteExternalPartnerResetPasswordViewModel.Password))
        {
            PageErrorMessage  =  'Your Password Must Contain At Least One Uppercase Letter.';
            return null;            
        }
        if(!Pattern.matches('.*[a-z]+.*', CompleteExternalPartnerResetPasswordViewModel.Password)) 
        {
            PageErrorMessage  =  'Your Password Must Contain At Least One Lowercase Letter.';
            return null;            
        }
        if(!Pattern.matches('.*[0-9]+.*', CompleteExternalPartnerResetPasswordViewModel.Password))
        {
            PageErrorMessage  =  'Your Password Must Contain At Least One Numeral.';
            return null;            
        }
        if(CompleteExternalPartnerResetPasswordViewModel.Password.length() > 16)
        {
            PageErrorMessage  =  'Your Password Can Be No More Than 16 Characters.';
            return null;
        }     
        if(CompleteExternalPartnerResetPasswordViewModel.Password != CompleteExternalPartnerResetPasswordViewModel.ConfirmPassword)
        {
            PageErrorMessage  =  'Your Passwords Do Not Match';
            return null;
        }
        string emailAddress = CompleteExternalPartnerResetPasswordViewModel.EmailAddress;        
        List<Contact> contacts = [SELECT Id FROM Contact WHERE RecordType.Name = 'CalEPA Partner' AND Email =: emailAddress and IsRegistered__c = true  AND Inactive__c = false ]; //OK
        if(contacts.size() > 0)
        {
            string password = CompleteExternalPartnerResetPasswordViewModel.Password;
            ContactEdit__c contactEdit = new ContactEdit__c();
            Blob passwordBlob = Blob.valueOf(password);
            Blob passwordHash = Crypto.generateDigest('MD5', passwordBlob);
            contactEdit.Contact__c = contacts[0].Id;
            contactEdit.PasswordHash__c = EncodingUtil.base64Encode(passwordHash);//.ToString(); 
            contactEdit.Password_Hash_Updated__c = true; 
            contactEdit.IsRegistered__c = true;
            contactEdit.Is_Registered_Updated__c = true;
            contactEdit.Reset_Code__c = '';
            contactEdit.Reset_Code_Updated__c = true;
            contactEdit.Is_Locked_Out__c = false; 
            contactEdit.Is_Locked_Out_Updated__c = true; 
            insert contactEdit;
            return GotoLogin();
        }
        PageErrorMessage  =  'There was a problem resetting your password, please contact complaints@calepa.ca.gov for assistance.';
        return null; 
    }

    //End External Partner Reset Password


    //Start Findings Landing Screen

    public PageReference LoadExternalPartnerLandingScreen()
    {
        if(!Authentication.IsLoggedIn)
        {            
            return GotoLogin();            
        }
        else
        {
            ExternalPartnerLandingScreenViewModel = new ExternalPartnerLandingScreenViewModel();
            ExternalPartnerLandingScreenViewModel = new ExternalPartnerLandingScreenViewModel();
            return null;
        }
    }
    
    @RemoteAction
    public static List<ExternalPartnerLandingScreenViewModel> GetReferrals(string externalPartnerId, string status)    
    {
        List<Referral__c> externalPartnerReferrals = new List<Referral__c>();
        if(status == 'Awaiting Findings')
        {
            externalPartnerReferrals = [SELECT Id, Complaint__c, Complaint__r.Name, Name, CreatedDate, Status__c FROM Referral__c WHERE External_Partner__c =: externalPartnerId AND Status__c = 'Awaiting Findings' ];
        }
        else if (status=='Findings Received')
        {
            externalPartnerReferrals = [SELECT Id, Complaint__c, Complaint__r.Name, Name, CreatedDate, Status__c FROM Referral__c WHERE External_Partner__c =: externalPartnerId AND Status__c = 'Findings Received' ];
        }
        else
        {
            externalPartnerReferrals = [SELECT Id, Complaint__c, Complaint__r.Name, Name, CreatedDate, Status__c FROM Referral__c WHERE External_Partner__c =: externalPartnerId ];
        }
        List<ExternalPartnerLandingScreenViewModel> viewModel = new List<ExternalPartnerLandingScreenViewModel>();
        for(Referral__c externalPartnerReferral: externalPartnerReferrals)
        {
            ExternalPartnerLandingScreenViewModel referralDataTableViewModel = new ExternalPartnerLandingScreenViewModel();
            referralDataTableViewModel.ReferralId = externalPartnerReferral.Id;
            referralDataTableViewModel.Name = externalPartnerReferral.Name;
            referralDataTableViewModel.Status = externalPartnerReferral.Status__c;
            referralDataTableViewModel.ComplaintId = externalPartnerReferral.Complaint__c;
            referralDataTableViewModel.ComplaintNumber = externalPartnerReferral.Complaint__r.Name;
            referralDataTableViewModel.CreatedDate = externalPartnerReferral.CreatedDate.format('MM/dd/yyyy');
            viewModel.Add(referralDataTableViewModel);
        }
        return viewModel;
    }

    @RemoteAction
    public static List<Finding__c> GetFindingsByReferral(string referralId)    
    {
        List<Finding__c> findings =  [SELECT Id, Name, CreatedDate FROM Finding__c WHERE Referral__c =: referralId ORDER BY CreatedDate ];//OK
        return findings;
    }

    public PageReference RedirectToCreate() 
    {
        PageReference CreateFinding = Page.CreateFinding;
        CreateFinding.getParameters().put('referralId', ExternalPartnerLandingScreenViewModel.ReferralId);
        CreateFinding.setRedirect(true);
        return CreateFinding;
    }
    //ExternalPartnerLandingScreenViewModel
    


    @RemoteAction
    public static List<Finding__c> GetFindings(string accountId)    
    {        
        List<Finding__c> findings =  [SELECT Id, Name, Complaint__c, Complaint__r.Name, CreatedDate FROM Finding__c WHERE Referral__r.External_Partner__c =: accountId ORDER BY CreatedDate ];//OK
        return findings;
    }
    
    public PageReference ViewLandingScreenComplaintDetails()
    {
        PageReference externalPartnerPortalComplaintDetails =  Page.ExternalPartnerPortalComplaintDetails;
        externalPartnerPortalComplaintDetails.getParameters().put('complaintId', ExternalPartnerLandingScreenViewModel.ComplaintId);
        externalPartnerPortalComplaintDetails.setRedirect(true);
        return externalPartnerPortalComplaintDetails;
    }

    public PageReference ViewLandingScreenFindingDetails() 
    {
        PageReference externalPartnerPortalFindingDetails =  Page.ExternalPartnerPortalFindingDetails;
        externalPartnerPortalFindingDetails.getParameters().put('findingId', ExternalPartnerLandingScreenViewModel.FindingId);
        externalPartnerPortalFindingDetails.setRedirect(true);
        return externalPartnerPortalFindingDetails;
    }

    //End Findings Landing Screen

    //Start Finding Referral Selector

    public PageReference LoadFindingReferralSelector()
    {        
        if(ApexPages.currentPage().getParameters().get('complaintId') == null)
        {           
            return GotoLogin();
        }       
        string complaintId = ApexPages.currentPage().getParameters().get('complaintId');
        List<Complaints__c> complaints =  [SELECT Id, Name, RecordType.Name FROM Complaints__c WHERE Id =: complaintId];
        if(complaints.size() != 1)
        {
            return GotoLogin();
        }
        Complaints__c complaint = complaints[0];
        
        List<Referral__c> referrals = [SELECT Id, External_Partner__r.Name FROM Referral__c WHERE Complaint__c =: complaint.Id ORDER BY External_Partner__r.Name];
        FindingReferralSelectorViewModel = new FindingReferralSelectorViewModel();
        FindingReferralSelectorViewModel.ComplaintNumber = complaint.Name;
        FindingReferralSelectorViewModel.ComplaintId = complaintId;
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', ''));
        for(Referral__c referral : referrals)
        {
            options.add(new SelectOption(referral.Id, referral.External_Partner__r.Name));
        }   
        options.add(new SelectOption('', 'My Agency/Department is Not Listed'));
        FindingReferralSelectorViewModel.ExternalPartners = options; 
        return null;
    }

    public PageReference SelectReferral()
    {
        if(FindingReferralSelectorViewModel.ReferralId == null || FindingReferralSelectorViewModel.ReferralId == '')
        {
            PageReference findingAccountSelector = Page.findingAccountSelector;
            findingAccountSelector.getParameters().put('complaintId', FindingReferralSelectorViewModel.ComplaintId);
            findingAccountSelector.setRedirect(true);
            return findingAccountSelector;
        }
        else
        {
            string referralId = FindingReferralSelectorViewModel.ReferralId;        
            List<Referral__c> referrals = [SELECT Id, Name FROM Referral__c WHERE Id =: referralId];
            if(referrals.size() != 1)
            {
                PageErrorMessage  = 'Referral Id Not Found.';
                return null;
            }
            Referral__c referral = referrals[0];
            PageReference CreateFinding = Page.CreateFinding;
            CreateFinding.getParameters().put('referralId', referralId);
            CreateFinding.setRedirect(true);
            return CreateFinding;
        }
    }

    public PageReference SelectAccount()
    {
        string complaintId = FindingReferralSelectorViewModel.ComplaintId;        
        string accountId = FindingReferralSelectorViewModel.AccountId;        
        if(!string.IsEmpty(complaintId) && !string.IsEmpty(accountId))
        {
            List<Complaints__c> complaints = [SELECT Id, Name FROM Complaints__c WHERE Id =: complaintId];
            if(complaints.size() != 1)
            {
                PageErrorMessage  = 'Complaint Id Not Found.';
                return null;
            }
            List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id =: accountId];
            if(accounts.size() != 1)
            {
                PageErrorMessage  = 'Account Id Not Found.';
                return null;
            }
            Complaints__c complaint = complaints[0];
            Account account = accounts[0];
            PageReference CreateFinding = Page.CreateFinding;
            CreateFinding.getParameters().put('complaintId', complaint.Id);
            CreateFinding.getParameters().put('accountId', account.Id);
            CreateFinding.setRedirect(true);
            return CreateFinding;
        }
        PageErrorMessage  = 'Complaint Id or Account Id Not Found.';
        return null;
    }    

    @RemoteAction
    public static ExternalPartnerAccountListViewModel GetAccounts(string letterFilter, integer pageNumber, string textFilter, string type) 
    {
        ExternalPartnerAccountListViewModel viewModel = new ExternalPartnerAccountListViewModel();
        string soqlQuery = 'SELECT Id, Name FROM Account WHERE RecordType.Name = \'CalEPA Partner Agency\'';
        if(letterFilter != '' && letterFilter != 'All')
        {
            soqlQuery = soqlQuery + ' AND Account.Name LIKE \'' + letterFilter + '%\'';
        }
        if(textFilter != '')
        {
            soqlQuery = soqlQuery + ' AND Account.Name LIKE \'%' + textFilter + '%\''; 
        }
        if(type != '' && type != 'All')
        {
            soqlQuery = soqlQuery + ' AND Account.Multi_Type__c INCLUDES (\'' + type + '\')';
        }
        soqlQuery = soqlQuery + ' ORDER BY Account.Name';
        List<Account> allRecords = Database.query(soqlQuery);
        viewModel.Count = allRecords.Size();
        viewModel.TotalPages = integer.valueOf((decimal.valueOf(viewModel.Count) / 10).round(System.RoundingMode.CEILING));
        integer counter = (pageNumber * 10);
        while(counter < ((pageNumber + 1) * 10) && counter < allRecords.size()) 
        {
            viewModel.Accounts.Add(allRecords[counter++]);
        }
        return viewModel;
    }

    //End Findings Referral Selector
    
    //Start Create Account

    public PageReference RedirectToExternalPartnerAccountCreation()
    {
        string complaintId = FindingReferralSelectorViewModel.ComplaintId;        
        List<Complaints__c> complaints = [SELECT Id, Name FROM Complaints__c WHERE Id =: complaintId];
        if(complaints.size() != 1)
        {
            PageErrorMessage  = 'Complaint Id Not Found.';
            return null;            
        }
        PageReference ExternalPartnerAccountCreation =  Page.ExternalPartnerAccountCreation;
        ExternalPartnerAccountCreation.getParameters().put('complaintId', FindingReferralSelectorViewModel.ComplaintId);
        ExternalPartnerAccountCreation.setRedirect(true);
        return ExternalPartnerAccountCreation;
    }

    public PageReference LoadExternalPartnerAccountCreation()
    {
        if(ApexPages.currentPage().getParameters().get('complaintId') == null)
        {           
            return GotoLogin();     
        }
        string complaintId = ApexPages.currentPage().getParameters().get('complaintId');    
        ExternalPartnerAccountCreationViewModel = new ExternalPartnerAccountCreationViewModel();
        ExternalPartnerAccountCreationViewModel.ComplaintId = complaintId;
        return null;
    }

    @RemoteAction
    public static void CreateAccount(string name)
    {
        try
        {   
            system.debug('name:  ' + name);
            RecordType recordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Account' AND  Name = 'CalEPA Partner Agency'];
            AccountEdit__c accountEdit = new AccountEdit__c();
            accountEdit.Record_Type_Id_Updated__c = true;
            accountEdit.Record_Type_Id__c = recordType.Id;
            accountEdit.AccountName__c = name;
            accountEdit.Account_Name_Updated__c = true;
            insert accountEdit;
        } 
        catch (System.DmlException e)
        {
            system.debug(e.getMessage());
            ApplicationException ex = new ApplicationException();
            ex.setMessage('There was an error creating your agency.  Please contact complaints@calepa.ca.gov for assistance.');
            throw ex;
        }
    }

    @RemoteAction
    public static Account GetAccountByName(string name)
    {
        List<Account> accounts = [SELECT Id, Name, CreatedDate FROM Account WHERE Name =: name ORDER BY CreatedDate DESC];
        if(accounts.size() > 0)
        {
            system.debug('accounts[0]:  ' + accounts[0]);
            return accounts[0];
        }
        system.debug('new account not found');
        ApplicationException ex = new ApplicationException();
        ex.setMessage('There was an error creating your agency.  Please contact complaints@calepa.ca.gov for assistance.');
        throw ex;
    }

    public PageReference SelectNewAccount()
    {        
        string complaintId = ExternalPartnerAccountCreationViewModel.ComplaintId;        
        string accountId = ExternalPartnerAccountCreationViewModel.AccountId;        
        if(!string.IsEmpty(complaintId) && !string.IsEmpty(accountId))
        {
            List<Complaints__c> complaints = [SELECT Id, Name FROM Complaints__c WHERE Id =: complaintId];
            if(complaints.size() != 1)
            {
                PageErrorMessage  = 'Complaint Id Not Found.';
                return null;
            }
            List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id =: accountId];
            if(accounts.size() != 1)
            {
                PageErrorMessage  = 'Account Id Not Found.';
                return null;
            }
            Complaints__c complaint = complaints[0];
            Account account = accounts[0];
            PageReference CreateFinding = Page.CreateFinding;
            CreateFinding.getParameters().put('complaintId', complaint.Id);
            CreateFinding.getParameters().put('accountId', account.Id);
            CreateFinding.setRedirect(true);
            return CreateFinding;
        }
        PageErrorMessage  = 'Complaint Id or Account Id Not Found.';
        return null;
    }  

    //End Create Account

    //Start Findings Create 

    public PageReference LoadCreate()
    {
        string attachmentUploadServiceURL = OrgURLHelper.GetSiteUrl('ExternalPartnerPortal');
        attachmentUploadServiceURL = attachmentUploadServiceURL + 'services/apexrest/AttachmentUploadService';

        CreateFindingsViewModel = new CreateFindingsViewModel();
        CreateFindingsViewModel.AttachmentUploadServiceURL = attachmentUploadServiceURL;
        if(ApexPages.currentPage().getParameters().get('referralId') == null  && (ApexPages.currentPage().getParameters().get('complaintId') == null ||ApexPages.currentPage().getParameters().get('accountId') == null))
        {           
            return GotoLogin();
        }
        
        List<Contact> contacts = new List<Contact>();
        if(ApexPages.currentPage().getParameters().get('referralId') != null)
        {
            string referralId = ApexPages.currentPage().getParameters().get('referralId');
            List<Referral__c> referrals = [SELECT Id, Complaint__c, External_Partner__c, External_Partner__r.Name FROM Referral__c WHERE Id=: referralId];
            if(referrals.size() != 1)
            {
                return GotoLogin();
            }
            Referral__c referral = referrals[0];
            CreateFindingsViewModel.ReferralId = referral.Id; 
            CreateFindingsViewModel.ExternalPartnerId = referral.External_Partner__c;
            CreateFindingsViewModel.ExternalPartnerName = referral.External_Partner__r.Name;
            Complaints__c complaint= [SELECT Id, Name FROM Complaints__c WHERE Id=: referral.Complaint__c];     
            CreateFindingsViewModel.ComplaintId = complaint.Id;
            CreateFindingsViewModel.ComplaintName = complaint.Name;            
            contacts = [SELECT Id, Name FROM Contact Where Inactive__c = false and Id in (SELECT ContactId FROM AccountContactRelation WHERE AccountId =: referral.External_Partner__c )];  //OK        
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('', ''));
            for(Contact contact : contacts)
            {
                options.add(new SelectOption(contact.Id, contact.Name));
            }   
            options.add(new SelectOption('', 'I am a new contact'));
            CreateFindingsViewModel.Contacts = options; 
            return null;
        }
        else
        {
            string complaintId = ApexPages.currentPage().getParameters().get('complaintId');        
            string accountId = ApexPages.currentPage().getParameters().get('accountId');       
            List<Complaints__c> complaints = [SELECT Id, Name FROM Complaints__c WHERE Id =: complaintId];
            if(complaints.size() != 1)
            {
                return GotoLogin();
            }
            Complaints__c complaint = complaints[0];
            List<Account> accounts = [SELECT Id, Name FROM Account WHERE Id =: accountId];
            if(accounts.size() != 1)
            {
                return GotoLogin(); 
            }
            Account account = accounts[0];
            CreateFindingsViewModel.ExternalPartnerId = account.Id;
            CreateFindingsViewModel.ExternalPartnerName = account.Name;
            CreateFindingsViewModel.ComplaintId = complaint.Id;
            CreateFindingsViewModel.ComplaintName = complaint.Name;            
            contacts = [SELECT Id, Name FROM Contact Where Id in (SELECT ContactId FROM AccountContactRelation WHERE AccountId =: account.Id )];//OK
            List<SelectOption> options = new List<SelectOption>();
            options.add(new SelectOption('', ''));
            for(Contact contact : contacts)
            {
                options.add(new SelectOption(contact.Id, contact.Name));
            }   
            options.add(new SelectOption('', 'I am a new contact'));
            CreateFindingsViewModel.Contacts = options; 
            return null;
        }        
    }    

    public PageReference RedirectToFindingAccountSelector()
    {
        PageReference findingAccountSelector = Page.findingAccountSelector;
        findingAccountSelector.getParameters().put('complaintId', CreateFindingsViewModel.ComplaintId);
        findingAccountSelector.setRedirect(true);
        return findingAccountSelector;

    }

    @RemoteAction
    public static Contact GetContact(id contactId) 
    {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, Phone, Title, Account.Name FROM Contact WHERE Id = :contactId];//OK
        if(contacts.size() == 0)
        {
            NoDataFoundException e = new NoDataFoundException();
            e.setMessage('Contact Not Found.  Please contact complaints@calepa.ca.gov for assistance.');
            throw e;
        }
        return contacts[0];
    }   

    @RemoteAction
    public static void UpdateContact(string contactId, string firstName, string lastName, string email, string phone, string title, string accountId) 
    {
        try
        {               
            ContactEdit__c contactEdit = new ContactEdit__c();
            if(string.IsEmpty(contactId))
            {
                RecordType recordType = [SELECT Id FROM RecordType WHERE SobjectType = 'Contact' AND  Name = 'CalEPA Partner'];
                contactEdit.Record_Type_Id__c = recordType.Id;
                contactEdit.Record_Type_Id_Updated__c = true;
                contactEdit.Account__c =  accountId;
                contactEdit.Account_Updated__c =  true ;
            }
            else
            {
                contactEdit.Contact__c = contactId;
            }
            contactEdit.First_Name__c = firstName;
            contactEdit.First_Name_Updated__c = true;
            contactEdit.Last_Name__c = lastName;
            contactEdit.Last_Name_Updated__c = true;
            contactEdit.Email__c = email;
            contactEdit.Email_Updated__c = true;
            contactEdit.Phone__c = phone;
            contactEdit.Phone_Updated__c = true;
            contactEdit.Title__c = title;
            contactEdit.Title_Updated__c = true;
            insert contactEdit;
        } 
        catch (System.DmlException e)
        {
            system.debug('exception:  ' + e.GetMessage());
            throw e;
        }
    }
    /*
    private static Document GetDocument(String documentId) 
    {
        List<Document> documents = [SELECT Id, Body FROM Document WHERE Id =: documentId];
        if(documents.isEmpty()) 
        {
            Document a = new Document();
            a.Description = 'Added as Finding';
            return a;
        } 
        else 
        {
            return documents[0];
        }
    }
    
    private static Complaints__c GetComplaint(string complaintId) 
    {
        List<Complaints__c> complaints = [SELECT Id, Name FROM Complaints__c WHERE Id =:complaintId];
        if(complaints.isEmpty()) 
        {
            return null;
        } 
        else 
        {
            return complaints[0];
        }
    }
    */
    @RemoteAction
    public static List<ContentDocument> GetAttachments(string contentDocumentIds) 
    {
        List<String> contentDocumentIdList = contentDocumentIds.split(',');
        List<ContentDocument> documents = [SELECT Id,Title,ContentSize,FileType,Description FROM ContentDocument WHERE Id in: contentDocumentIdList];
        system.debug('documents:  ' + documents);
        return documents;
    }

    @RemoteAction
    public static void RemoveAttachment(string contentDocumentId) 
    {
        if(!string.IsEmpty(contentDocumentId))
        {
            ContentDocument contentDocument = [SELECT Id FROM ContentDocument WHERE Id =: contentDocumentId];
            delete contentDocument;
        } 
        else 
        {
            ApplicationException e = new ApplicationException();
            e.setMessage('contentDocumentId was null.');
            throw e;
        }
    }

    public PageReference Save()
    {
        try
        {
            Finding__c finding = new Finding__c();
            finding.Contact__c = CreateFindingsViewModel.ContactId;
            finding.Complaint__c = CreateFindingsViewModel.ComplaintId;
            if(!string.IsBlank(CreateFindingsViewModel.ReferralId))
            {
                finding.Referral__c = CreateFindingsViewModel.ReferralId;
            }
            finding.Secondary_Referral__c = CreateFindingsViewModel.SecondaryReferral;
            if(finding.Secondary_Referral__c == 'Yes')
            {
                finding.Referral_Agency__c = CreateFindingsViewModel.ReferralAgency;
                if(CreateFindingsViewModel.DateOfReferral != '')
                {
                    finding.Date_of_Referral__c = Date.Parse(CreateFindingsViewModel.DateOfReferral);
                }
            }
            finding.Site_Visit_Conducted__c = CreateFindingsViewModel.SiteVisitConducted;
            if(finding.Site_Visit_Conducted__c == 'Yes')
            {
                if(CreateFindingsViewModel.DateOfSiteVisit != '')
                {
                    finding.Date_of_Site_Visit__c =  Date.Parse(CreateFindingsViewModel.DateOfSiteVisit);
                }
            }
            else if(finding.Site_Visit_Conducted__c == 'No')
            {
                finding.Reason_for_No_Site_Visit__c = CreateFindingsViewModel.ReasonForNoSiteVisit;
                if(finding.Reason_for_No_Site_Visit__c == 'Other')
                {
                    finding.Other_Reason_for_No_Site_Visit__c = CreateFindingsViewModel.OtherReasonForNoSiteVisit;
                }

            }
            finding.Violations_or_Compliance_Issues__c = CreateFindingsViewModel.ViolationsOrComplianceIssues;
            if(finding.Violations_or_Compliance_Issues__c == 'Yes')
            {
                finding.Summary_of_Violations_and_enforcement__c = CreateFindingsViewModel.SummaryOfViolationsAndEnforcement;
                finding.Violations_Related_to_Complaint__c = CreateFindingsViewModel.ViolationsRelatedToComplaint;
            }
            finding.Is_Enforcement_Complete__c = CreateFindingsViewModel.IsEnforcementComplete;
            if(finding.Is_Enforcement_Complete__c == 'No')
            {
                finding.On_Going_Enforcement__c = CreateFindingsViewModel.OnGoingEnforcement;
            }
            insert finding;
            if(CreateFindingsViewModel.ContentDocumentIds != null && CreateFindingsViewModel.ContentDocumentIds != '')
            {
                List<String> contentDocumentIdList = CreateFindingsViewModel.ContentDocumentIds.split(',');				               
                for(string contentDocumentId : contentDocumentIdList) 
                {                	
                    ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
                    contentDocumentLink.ContentDocumentId = contentDocumentId;
                    contentDocumentLink.LinkedEntityId = finding.Id;
                    contentDocumentLink.ShareType = 'I';
                    contentDocumentLink.Visibility = 'AllUsers';
                    insert contentDocumentLink;
                }
            }
            FindingCompleteViewModel = new FindingCompleteViewModel();
            FindingCompleteViewModel.FindingId = finding.Id;
            PageReference FindingComplete = Page.FindingComplete;
            return FindingComplete;
        }
        catch (Exception e) 
        {
            system.debug('exception:  ' + e);
            PageErrorMessage  = e.getMessage();
            return null;
        } 
    }  

    //End Findings Create

    //Start Complaint Detail
    
    public PageReference ViewComplaintPDF()
    {
        PageReference complaintPDF =  Page.ComplaintPDF;
        complaintPDF.getParameters().put('id', ComplaintDetailsViewModel.Id);
        return complaintPDF;
    }

    //This is called from the CreateFindings Page
    public PageReference ViewComplaintDetails()
    {
        PageReference externalPartnerPortalComplaintDetails =  Page.ExternalPartnerPortalComplaintDetails;
        externalPartnerPortalComplaintDetails.getParameters().put('complaintId', CreateFindingsViewModel.ComplaintId);
        externalPartnerPortalComplaintDetails.setRedirect(true);
        return externalPartnerPortalComplaintDetails;
    }

    public PageReference LoadExternalPartnerPortalComplaintDetails()
    {
        string complaintId = '';
        if(ApexPages.currentPage().getParameters().get('complaintId') != null)
        {
            complaintId = ApexPages.currentPage().getParameters().get('complaintId');
        }
        else
        {
            return GotoLogin();
        }
        ComplaintDetailsViewModel viewModel = new ComplaintDetailsViewModel();        
        Complaints__c complaint = [SELECT   Id, Name, Date_and_Time_of_Occurrence__c, On_going_Occurrence__c,Spill__c,Refinery__c,EJ_Complaint__c,Tribal_Complaint__c,Referring__c,Referring_Agency__c,Referring_Name__c,Referring_Email_Address__c,Anonymous__c,Complainant__r.PersonContact.FirstName,Complainant__r.PersonContact.LastName,Complainant__r.PersonContact.MailingCity,Complainant__r.PersonContact.MailingState,Complainant__r.PersonContact.MailingStreet,Complainant__r.PersonContact.MailingPostalCode,Complainant__r.PersonContact.MobilePhone,Complainant__r.PersonContact.HomePhone,Complainant__r.PersonContact.HasOptedOutOfEmail,Complainant__r.PersonContact.Email,Previous_Organizations__c,Complaint_Location_Address__c,Complaint_Location_City__c,Complaint_Location_County__c,Complaint_Location_State__c,Complaint_Location_Zip_Code__c,Complaint_Location__Latitude__s,Complaint_Location__Longitude__s,Location_Description__c,Responsible_Party_City__c,Responsible_Party_Company__c,Responsible_Party_Name__c,Responsible_Party_Phone__c,Responsible_Party_State__c,Responsible_Party_Street__c,Responsible_Party_Zip_Code__c,Description__c,Number_of_BDOs__c,Air__c,Vehicle_or_Stationary__c,Air_Complaint_Source_Info__c,Solid_Waste__c,Bottles_Cans_Recycling__c,Additional_Solid_Waste_Checkbox__c,Waste_Tires__c,Pesticides__c,Nature_of_Pesticides_Report__c,Reported_to_CAC__c,Toxic_Substances__c,Sensitive_Location__c,How_did_you_become_aware_of_incident__c,Toxics_Other_Location__c,Relationship_to_Responsible_Party__c,Other_Relationship__c,Water__c,Drinking_Water__c,Water_Cannabis_Marijuana__c,Water_Quality__c,Water_Rights__c,Watershed__c,Name_of_Affected_Water_Source__c,Water_Right_Number__c,Water_Rights_Owner__c,Water_Rights_Description__c,Other_Water_Related_Concerns__c from Complaints__c WHERE Id =: complaintId];
        viewModel.Id = complaint.Id;
        viewModel.ComplaintNumber  =   complaint.Name;
        
        if(complaint.Date_and_Time_of_Occurrence__c != null)
        {
            viewModel.DateAndTimeOfOccurrence  =  complaint.Date_and_Time_of_Occurrence__c.format('MM/dd/yyyy hh:mma', 'America/Los_Angeles');
        }
        viewModel.OnGoingOccurrence  = GetYesNo(complaint.On_going_Occurrence__c);

        viewModel.Spill  = GetYesNo(complaint.Spill__c);
        viewModel.Refinery  = GetYesNo(complaint.Refinery__c);
       
        viewModel.TribalComplaint  =  GetYesNo(complaint.Tribal_Complaint__c);
        viewModel.EJComplaint  =  GetYesNo(complaint.EJ_Complaint__c);

        viewModel.ReferredToCalEPA = complaint.Referring_Agency__c != null && complaint.Referring_Agency__c != '';
        viewModel.ReferringAgency  = complaint.Referring_Agency__c; 
        viewModel.ReferringName  = complaint.Referring_Name__c;
        viewModel.ReferringEmailAddress  = complaint.Referring_Email_Address__c;
        
        viewModel.HasPreviousOrganizations = complaint.Previous_Organizations__c != null && complaint.Previous_Organizations__c != '';
        viewModel.PreviousOrganizations = complaint.Previous_Organizations__c;

        viewModel.IsAnonymous = complaint.Anonymous__c;
        if(viewModel.IsAnonymous)
        {
            viewModel.AnonymousSubmission = GetYesNo(complaint.Anonymous__c);
        }
        else
        {
            viewModel.ComplainantFirstName  =   complaint.Complainant__r.PersonContact.FirstName ;
            viewModel.ComplainantLastName  =   complaint.Complainant__r.PersonContact.LastName ;            
            viewModel.ComplainantStreet  =    complaint.Complainant__r.PersonContact.MailingStreet;
            viewModel.ComplainantCity  =    complaint.Complainant__r.PersonContact.MailingCity;
            viewModel.ComplainantState  =    complaint.Complainant__r.PersonContact.MailingState;
            viewModel.ComplainantZipCode  =    complaint.Complainant__r.PersonContact.MailingPostalCode;
            viewModel.ComplainantPhone  =   complaint.Complainant__r.PersonContact.HomePhone ;
            viewModel.ComplainantMobile  =   complaint.Complainant__r.PersonContact.MobilePhone;
            if(complaint.Complainant__r.PersonContact.HasOptedOutOfEmail)
            {
                viewModel.ComplainantEmail  =   'Complainant Opted Out of Email';
            }
            else
            {
                viewModel.ComplainantEmail  =  complaint.Complainant__r.PersonContact.Email;
            }        
        }
        
                                            
        viewModel.ComplaintLocationStreet  =    complaint.Complaint_Location_Address__c;
        viewModel.ComplaintLocationCity  =  complaint.Complaint_Location_City__c  ;
        viewModel.ComplaintLocationCounty  = complaint.Complaint_Location_County__c   ;
        viewModel.ComplaintLocationZipCode  =  complaint.Complaint_Location_Zip_Code__c  ;
        viewModel.ComplaintLocationState = complaint.Complaint_Location_State__c;
        viewModel.Latitude =  String.valueOf(complaint.Complaint_Location__Latitude__s);
        viewModel.Longitude =  String.valueOf(complaint.Complaint_Location__Longitude__s);
        viewModel.LocationDescription     =    complaint.Location_Description__c;
                                            
        viewModel.ResponsiblePartyName  =  complaint.Responsible_Party_Name__c  ;
        viewModel.ResponsiblePartyCompany  =  complaint.Responsible_Party_Company__c  ;
        viewModel.ResponsiblePartyPhone  =    complaint.Responsible_Party_Phone__c;
        viewModel.ResponsiblePartyAddress  =   complaint.Responsible_Party_Street__c ;
        viewModel.ResponsiblePartyCity  =   complaint.Responsible_Party_City__c ;
        viewModel.ResponsiblePartyState  =   complaint.Responsible_Party_State__c ;
        viewModel.ResponsiblePartyZipCode  =   complaint.Responsible_Party_Zip_Code__c ;        
        viewModel.ComplaintDescription  =  complaint.Description__c;
        
        if(complaint.Number_of_BDOs__c > 1)
        {
            viewModel.AreaOfConcernLabel = 'Areas of Concern';
        }
        else
        {
            viewModel.AreaOfConcernLabel = 'Area of Concern';
        }
        viewModel.IsAir =  complaint.Air__c;
        viewModel.VehicleOrStationary  =    complaint.Vehicle_or_Stationary__c;
        viewModel.AirComplaintSourceInfo  =    complaint.Air_Complaint_Source_Info__c;
        viewModel.IsSolidWasteCalRecycle  =  complaint.Solid_Waste__c ;
        viewModel.BottlesCansRecycling  =    GetYesNo(complaint.Bottles_Cans_Recycling__c);
        viewModel.AdditionalSolidWaste  =    GetYesNo(complaint.Additional_Solid_Waste_Checkbox__c);
        viewModel.WasteTires  =    GetYesNo(complaint.Waste_Tires__c);
        viewModel.IsPesticides  =   complaint.Pesticides__c;
        viewModel.NatureOfPesticidesReport  =    complaint.Nature_of_Pesticides_Report__c;
        viewModel.ReportedToCAC  =    complaint.Reported_to_CAC__c;
        viewModel.IsToxicSubstances = complaint.Toxic_Substances__c;
        viewModel.SensitiveLocation  =   complaint.Sensitive_Location__c == 'Other' ? complaint.Toxics_Other_Location__c : complaint.Sensitive_Location__c;
        viewModel.HowDidYouBecomeAwareOfTheIncident  =   complaint.How_did_you_become_aware_of_incident__c;
        viewModel.RelationshipToResponsibleParty  =  complaint.Relationship_to_Responsible_Party__c == 'Other' ?  complaint.Other_Relationship__c : complaint.Relationship_to_Responsible_Party__c;
        viewModel.IsWater  =    complaint.Water__c;
        viewModel.DrinkingWater  =    GetYesNo(complaint.Drinking_Water__c);
        viewModel.WaterCannabisMarijuana  =    GetYesNo(complaint.Water_Cannabis_Marijuana__c);
        viewModel.WaterQuality  =    GetYesNo(complaint.Water_Quality__c);
        viewModel.IsWaterRights  =    complaint.Water_Rights__c;
        viewModel.WaterRights  =    GetYesNo(complaint.Water_Rights__c);
        viewModel.Watershed  =    complaint.Watershed__c;
        viewModel.NameOfAffectedWaterSource  =    complaint.Name_of_Affected_Water_Source__c;
        viewModel.WaterRightsNumber  =    complaint.Water_Right_Number__c;
        viewModel.WaterRightsOwner  =    complaint.Water_Rights_Owner__c;
        viewModel.WaterRightsDescription  =    complaint.Water_Rights_Description__c;
        viewModel.OtherWaterRelatedConcerns  =    GetYesNo(complaint.Other_Water_Related_Concerns__c);
        List<Attachment> attachments = [SELECT Id, Name, BodyLength, ContentType FROM Attachment WHERE ParentID =: complaint.Id];
        viewModel.Attachments = attachments;
        List<Referral__c> referrals = [SELECT Id, External_Partner__r.Name, CreatedDate, CreatedBy.BDO__c FROM Referral__c WHERE Complaint__c =: complaint.Id];
        viewModel.Referrals = referrals;


        ComplaintDetailsViewModel = viewModel;
        return null;
    }

    //End Complaint Detail
   
   
    //Start Finding Detail
   
    public PageReference ViewFindingPDFPage()
    {
        PageReference findingPDF =  Page.FindingPDF;
        findingPDF.getParameters().put('id', FindingDetailViewModel.FindingId);
        return findingPDF;
    }
    
    public PageReference LoadExternalPartnerPortalFindingDetails()
    {
        string findingsId = ApexPages.currentPage().getParameters().get('findingId');
        FindingDetailViewModel = new FindingDetailViewModel();
        Finding__c finding = [SELECT Complaint__c,Completed_By__c,Contact__c,CreatedById,CreatedDate, Date_of_Referral__c,Date_of_Site_Visit__c,External_Id__c,Id,IsDeleted,Is_Enforcement_Complete__c,LastActivityDate,LastModifiedById,LastModifiedDate,LastReferencedDate,LastViewedDate,Name,On_Going_Enforcement__c,Other_Reason_for_No_Site_Visit__c,Reason_for_No_Site_Visit__c,Referral_Agency__c,Referral__c,Secondary_Referral__c,Site_Visit_Conducted__c,Summary_of_Violations_and_enforcement__c,Violations_or_Compliance_Issues__c,Violations_Related_to_Complaint__c,Complaint__r.Name,Contact__r.Email,Contact__r.Title,Contact__r.Phone FROM Finding__c WHERE Id =: findingsId];
        FindingDetailViewModel.FindingId = finding.Id;
        FindingDetailViewModel.FindingName = finding.Name;
        FindingDetailViewModel.CompletedBy = finding.Completed_By__c;
        FindingDetailViewModel.Title = finding.Contact__r.Title;
        FindingDetailViewModel.Email = finding.Contact__r.Email;
        FindingDetailViewModel.Phone = finding.Contact__r.Phone;
        if(finding.Secondary_Referral__c == 'Yes')
        {
            FindingDetailViewModel.IsSecondaryReferral = true;
        }
        else
        {
            FindingDetailViewModel.IsSecondaryReferral = false;
        }
        FindingDetailViewModel.SecondaryReferral = finding.Secondary_Referral__c;
        FindingDetailViewModel.ReferralAgency  = finding.Referral_Agency__c;
        if(finding.Date_of_Referral__c != null)
        {
            FindingDetailViewModel.DateOfReferral  = DateTime.newInstance(finding.Date_of_Referral__c.year(),finding.Date_of_Referral__c.month(),finding.Date_of_Referral__c.day()).format('MM/dd/yyyy');
        }
        else
        {
            FindingDetailViewModel.DateOfReferral = '';
        }
        if(finding.Site_Visit_Conducted__c == 'Yes')
        {
            FindingDetailViewModel.IsSiteVisit = true;
        }
        else
        {
            FindingDetailViewModel.IsSiteVisit = false;
        }
        FindingDetailViewModel.SiteVisitConducted  = finding.Site_Visit_Conducted__c;
        if(finding.Date_of_Site_Visit__c != null)
        {
            FindingDetailViewModel.DateOfSiteVisit  = DateTime.newInstance(finding.Date_of_Site_Visit__c.year(),finding.Date_of_Site_Visit__c.month(),finding.Date_of_Site_Visit__c.day()).format('MM/dd/yyyy');
        }
        else
        {
            FindingDetailViewModel.DateOfSiteVisit = '';
        }
        if(finding.Reason_for_No_Site_Visit__c == 'Other')
        {
            FindingDetailViewModel.ReasonForNoSiteVisit  = finding.Other_Reason_for_No_Site_Visit__c;
        }
        else
        {
            FindingDetailViewModel.ReasonForNoSiteVisit  = finding.Reason_for_No_Site_Visit__c;
        }
        
        FindingDetailViewModel.ViolationsOrComplianceIssues  = finding.Violations_or_Compliance_Issues__c;
        if(finding.Violations_or_Compliance_Issues__c == 'Yes')
        {
            FindingDetailViewModel.IsViolationsOrComplianceIssues  = true;
        }
        else
        {
            FindingDetailViewModel.IsViolationsOrComplianceIssues  = false;
        }
        
        FindingDetailViewModel.SummaryOfViolationsAndEnforcement  = finding.Summary_of_Violations_and_enforcement__c;
        FindingDetailViewModel.ViolationsRelatedToComplaint  = finding.Violations_Related_to_Complaint__c;
        if(finding.Is_Enforcement_Complete__c == 'Yes')
        {
            FindingDetailViewModel.IsIsEnforcementComplete  = true;
        }
        else
        {
            FindingDetailViewModel.IsIsEnforcementComplete  = false;
        }
        FindingDetailViewModel.IsEnforcementComplete  = finding.Is_Enforcement_Complete__c;
        FindingDetailViewModel.OnGoingEnforcement  = finding.On_Going_Enforcement__c;

        List<Attachment> attachments = [SELECT Id, Name, BodyLength, ContentType FROM Attachment WHERE ParentID =: finding.Id];
        FindingDetailViewModel.Attachments = attachments;


        return null;
    }

   
    //End Finding Detail

   

    //Start Findings Complete

    //End Findings Complete


    //Start External Partner Contact Profile
    
    public PageReference ExternalPartnerContactProfile()
    {       
        PageReference externalPartnerContactProfile =  Page.ExternalPartnerContactProfile;
        return externalPartnerContactProfile;  
    }

    public PageReference LoadExternalPartnerContactProfile()
    {
        GetAuthenticationCookie();
        if(!Authentication.IsLoggedIn)
        {
            return GotoLogin();            
        }
        if(Authentication.UserId == null)
        {
            return GotoLogin();            
        }
        string contactId = '';
        if(ApexPages.currentPage().getParameters().get('contactId') != null)
        {
            contactId = ApexPages.currentPage().getParameters().get('contactId');
        }
        else
        {
            contactId = Authentication.UserId;
        }
        Contact contact = [SELECT Id, FirstName, LastName, Email, Phone, Title, Inactive__c FROM Contact WHERE Id =: contactId Limit 1];//OK
        ExternalPartnerContactProfileViewModel = new ExternalPartnerContactProfileViewModel();
        ExternalPartnerContactProfileViewModel.ContactId = contact.Id;
        ExternalPartnerContactProfileViewModel.FirstName = contact.FirstName;
        ExternalPartnerContactProfileViewModel.LastName = contact.LastName;
        ExternalPartnerContactProfileViewModel.Email = contact.Email;
        ExternalPartnerContactProfileViewModel.Phone = contact.Phone;
        ExternalPartnerContactProfileViewModel.Title = contact.Title;
        ExternalPartnerContactProfileViewModel.Inactive = contact.Inactive__c;
        return null;
    }

    public PageReference UpdateExternalPartnerContactProfile()
    {        
        if(ExternalPartnerContactProfileViewModel == null)
        {
            return GotoLogin();             
        }
        if(ExternalPartnerContactProfileViewModel.ContactId == null)
        {
            return GotoLogin();             
        }
        string contactId = ExternalPartnerContactProfileViewModel.ContactId;
        Contact contact = [SELECT Id, FirstName, LastName, Email, Phone, Title FROM Contact Where Id =: contactId Limit 1];//OK
        ContactEdit__c contactEdit = new ContactEdit__c();
        contactEdit.Contact__c = contact.Id;
        contactEdit.First_Name__c = ExternalPartnerContactProfileViewModel.FirstName;
        contactEdit.First_Name_Updated__c = true;
        contactEdit.Last_Name__c = ExternalPartnerContactProfileViewModel.LastName;
        contactEdit.Last_Name_Updated__c = true;
        contactEdit.Email__c = ExternalPartnerContactProfileViewModel.Email;
        contactEdit.Email_Updated__c = true;
        contactEdit.Phone__c = ExternalPartnerContactProfileViewModel.Phone;
        contactEdit.Phone_Updated__c = true;
        contactEdit.Title__c = ExternalPartnerContactProfileViewModel.Title;
        contactEdit.Title_Updated__c = true;
        contactEdit.Inactive__c = ExternalPartnerContactProfileViewModel.Inactive;
        contactEdit.Inactive_Updated__c = true; 
        insert contactEdit;
        if(ExternalPartnerContactProfileViewModel.ContactId == Authentication.UserId)
        {
            PageReference ExternalPartnerLandingScreen = Page.ExternalPartnerLandingScreen;
            ExternalPartnerLandingScreen.setRedirect(true);
            return ExternalPartnerLandingScreen;
        }
        else
        {
            PageReference externalPartnerAccountProfile =  Page.ExternalPartnerAccountProfile;
            return externalPartnerAccountProfile;  
        }
        
    }
    
    //End External Partner Contact Profile


     //Start External Partner Account Profile
    
    public PageReference ExternalPartnerAccountProfile()
    {  
        PageReference externalPartnerAccountProfile =  Page.ExternalPartnerAccountProfile;
        return externalPartnerAccountProfile;  
    }

    public PageReference LoadExternalPartnerAccountProfile()
    {
        GetAuthenticationCookie();
        if(!Authentication.IsLoggedIn)
        {
            return GotoLogin();            
        }
        if(Authentication.UserId == null)
        {
            return GotoLogin();            
        }
        if(Authentication.ExternalPartnerId == null)
        {
            return GotoLogin();            
        }
        Account account = [SELECT Name, Phone, Fax, Website, ShippingCity, ShippingState, ShippingPostalCode, ShippingStreet FROM Account   WHERE Id =: Authentication.ExternalPartnerId];
        ExternalPartnerAccountProfileViewModel = new ExternalPartnerAccountProfileViewModel();
        ExternalPartnerAccountProfileViewModel.AccountId = account.Id;
        ExternalPartnerAccountProfileViewModel.Name = account.Name;
        ExternalPartnerAccountProfileViewModel.Phone = account.Phone;
        ExternalPartnerAccountProfileViewModel.Fax = account.Fax;
        ExternalPartnerAccountProfileViewModel.Website = account.Website;
        ExternalPartnerAccountProfileViewModel.ShippingCity = account.ShippingCity;        
        ExternalPartnerAccountProfileViewModel.ShippingState = account.ShippingState;        
        ExternalPartnerAccountProfileViewModel.ShippingPostalCode = account.ShippingPostalCode;        
        ExternalPartnerAccountProfileViewModel.ShippingStreet = account.ShippingStreet;        
        return null;
    }

    public PageReference UpdateExternalPartnerAccountProfile()
    {        
        if(ExternalPartnerAccountProfileViewModel == null)
        {
            return GotoLogin();             
        }
        if(string.IsEmpty(Authentication.ExternalPartnerId))
        {
            return GotoLogin();             
        }             
        string accountId = Authentication.ExternalPartnerId;
        Account account = [SELECT Name, Phone, Fax, Website, ShippingCity, ShippingPostalCode, ShippingStreet FROM Account   WHERE Id =: accountId];
        AccountEdit__c accountEdit = new AccountEdit__c();
        accountEdit.Account__c = accountId;
        accountEdit.Phone__c = ExternalPartnerAccountProfileViewModel.Phone;
        accountEdit.Phone_Updated__c = true;
        accountEdit.Fax__c = ExternalPartnerAccountProfileViewModel.Fax;
        accountEdit.Fax_Updated__c = true;
        accountEdit.Street_Address__c = ExternalPartnerAccountProfileViewModel.ShippingStreet;
        accountEdit.Street_Address_Updated__c = true;
        accountEdit.City__c = ExternalPartnerAccountProfileViewModel.ShippingCity;
        accountEdit.City_Updated__c = true;
        accountEdit.Zip__c = ExternalPartnerAccountProfileViewModel.ShippingPostalCode;
        accountEdit.Zip_Updated__c = true;
        accountEdit.Website__c = ExternalPartnerAccountProfileViewModel.Website;
        accountEdit.Website_Updated__c = true;
        insert accountEdit;
        ExternalPartnerAccountProfileViewModel.SuccessMessage = 'Agency Updated.';
        return null;
    }

    public PageReference RedirectToExternalPartnerContactProfile()
    {
        PageReference externalPartnerContactProfile =  Page.ExternalPartnerContactProfile;
        externalPartnerContactProfile.getParameters().put('contactId', ExternalPartnerAccountProfileViewModel.ContactId);
        return externalPartnerContactProfile;  
    }

    //End External Partner Account Profile


    

    //Start Shared
    
    @RemoteAction
    public static List<ContactDataTableRowViewModel> GetContactsByAccount(string accountId) 
    {
        List<Account> accounts = [SELECT Id FROM Account WHERE ID =: accountId ];
        if(accounts.size() == 0)
        {
            NoDataFoundException e = new NoDataFoundException();
            e.setMessage('There was an issue retrieving contact information.  Please contact complaints@calepa.ca.gov for assistance.');
            throw e;
        }
        
        List<Contact> contacts = [SELECT Id, Name, Email, Phone, Title, Inactive__c FROM Contact Where Id in (SELECT ContactId FROM AccountContactRelation WHERE AccountId =: accountId )];//OK
        if(contacts.size() == 0)
        {
            NoDataFoundException e = new NoDataFoundException();
            e.setMessage('There was an issue retrieving contact information.  Please contact complaints@calepa.ca.gov for assistance.');
            throw e;
        }
        List<ContactDataTableRowViewModel> contactDataTableRowViewModels = new List<ContactDataTableRowViewModel>();
        for(Contact contact : contacts)
        {
            ContactDataTableRowViewModel contactDataTableRowViewModel = new ContactDataTableRowViewModel();
            contactDataTableRowViewModel.Id = contact.Id;
            contactDataTableRowViewModel.Name = contact.Name;
            if(contact.Title != null)
            {
                contactDataTableRowViewModel.Title = contact.Title;
            }
            else
            {
                contactDataTableRowViewModel.Title = '';
            }            
            if(contact.Phone != null)
            {
                contactDataTableRowViewModel.Phone = contact.Phone;
            }
            else
            {
                contactDataTableRowViewModel.Phone = '';
            }            
            if(contact.Email != null)
            {
                contactDataTableRowViewModel.Email = contact.Email;
            }
            else
            {
                contactDataTableRowViewModel.Email = '';
            }
            if(contact.Inactive__c == null || contact.Inactive__c == false)
            {
                contactDataTableRowViewModel.Inactive = 'No';
            }
            else
            {
                contactDataTableRowViewModel.Inactive = 'Yes';
            }
            contactDataTableRowViewModels.Add(contactDataTableRowViewModel);
        }
        return contactDataTableRowViewModels;
    }

    private string GetYesNo(boolean val)
    {
        if(val)
        {
            return 'Yes';
        }
        return 'No';
    }

    //End Shared

    //Start Sub-Classes
    
    public with sharing class AuthenticationModel
    {
        public AuthenticationModel() 
        {
            ExternalPartners = new Map<Id, String>();
            IsLoggedIn = false;
        }
        public boolean IsLoggedIn {get;set;}
        public integer ExternalPartnerSize
        {
            get
            {
                return ExternalPartners.Size();
            }
            set;
        }
        public Map<ID, string> ExternalPartners {get;set;}
        public string ExternalPartnerName {get;set;}
        public string ExternalPartnerId {get;set;}
        public string UsersName {get;set;}
        public string UserId {get;set;}
    }

    public with sharing class ExternalPartnerLoginViewModel 
    {
        public ExternalPartnerLoginViewModel() 
        {
            
        }

        public string EmailAddress {get;set;}
        public string Password {get;set;}
        //public string CompOrRef {get;set;}
        public string ComplaintNumber {get;set;}
        public string ComplaintId {get;set;}
        public string LoginError {get;set;}
    }

    public with sharing class ExternalPartnerRequestAccessViewModel 
    {
        public ExternalPartnerRequestAccessViewModel() 
        {
            
        }
        public string FirstName {get;set;}
		public string LastName {get;set;}
        public string EmailAddress {get;set;}
    }

    public with sharing class FindingsResetPasswordViewModel 
    {
        public FindingsResetPasswordViewModel() 
        {
            
        }

        public string EmailAddress {get;set;}
    }

    public with sharing class CompleteExternalPartnerResetPasswordViewModel
    {
        public CompleteExternalPartnerResetPasswordViewModel() 
        {
            
        }
        public string ContactId {get;set;}
        public string EmailAddress {get;set;}
        public string ResetCode {get;set;}
        public string Password {get;set;}
        public string ConfirmPassword {get;set;}
    }

    public with sharing class ExternalPartnerCreatePasswordViewModel
    {
        public ExternalPartnerCreatePasswordViewModel() 
        {
            
        }
        public string EmailAddress {get;set;}
        public string ContactId {get;set;}
        public string Password {get;set;}
        public string ConfirmPassword {get;set;}
    }

    public with sharing class ExternalPartnerAccountSelectorViewModel
    {
        public ExternalPartnerAccountSelectorViewModel() 
        {
            ExternalPartners = new List<SelectOption>();
        }
        public List<SelectOption> ExternalPartners {get;set;}
    }

    public with sharing class ExternalPartnerLandingScreenViewModel
    {
        public ExternalPartnerLandingScreenViewModel() 
        {
            
        }
        public string FindingId {get;set;}        
        public string ReferralId {get;set;}        
        public string Name {get;set;}
        public string ComplaintId {get;set;}
        public string ComplaintNumber {get;set;}
        public string CreatedDate {get;set;}
        public string Status {get;set;}
    }

    public with sharing class FindingReferralSelectorViewModel
    {
        public FindingReferralSelectorViewModel() 
        {
            
        }
        public List<SelectOption> ExternalPartners {get;set;}
        public string ReferralId {get;set;}
        public string ComplaintNumber {get;set;}
        public string AccountId {get;set;}
        public string ComplaintId {get;set;}
    }
    
    public with sharing class ExternalPartnerAccountCreationViewModel
    {
        public ExternalPartnerAccountCreationViewModel() 
        {
            
        }
        public string AccountId {get;set;}
        public string ComplaintId {get;set;}
    }

    public with sharing class CreateFindingsViewModel 
    {
        public CreateFindingsViewModel() 
        {
            
        }
        public List<SelectOption> Contacts {get;set;}
        public string AttachmentUploadServiceURL {get;set;}
        public string ComplaintId {get; set;}
        public string ComplaintName {get; set;}
        public string ReferralId {get; set;}
        public string ExternalPartnerId {get;set;}
        public string ExternalPartnerName {get;set;}

        public string ContactId {get; set;}
        public string SecondaryReferral {get; set;}
        
        public string DateOfReferral {get; set;}
        public string DateOfSiteVisit {get; set;}
        public string SiteVisitConducted {get; set;}
        
        public string IsEnforcementComplete {get; set;}
        public string OnGoingEnforcement {get; set;}
        public string OtherReasonForNoSiteVisit {get; set;}
        public string SummaryOfViolationsAndEnforcement {get; set;}
        public string ViolationsOrComplianceIssues {get; set;}
        public string ViolationsRelatedToComplaint {get; set;}
        public string ReferralAgency {get; set;}
        public string ReasonForNoSiteVisit {get; set;}
        public string ContentDocumentIds {get;set;}
    }

    public with sharing class FindingCompleteViewModel 
    {
        public FindingCompleteViewModel() 
        {
            
        }
        public string FindingId {get; set;}
    }

    public with sharing class FindingConfirmationEmailViewModel 
    {
        public string FindingsContactName {get; set;}
        public string ComplaintNumber {get; set;}

        public FindingConfirmationEmailViewModel() 
        {   
            
        }
    }

    public with sharing class FindingNotificationEmailViewModel 
    {
        public string ComplaintNumber {get; set;}
        public string FindingUrl {get; set;}

        public FindingNotificationEmailViewModel() 
        {   
            
        }
    }

    public with sharing class ExternalPartnerAccountListViewModel 
    {
        public ExternalPartnerAccountListViewModel() 
        {
            Accounts = new List<Account>();
        }
        public List<Account> Accounts {get;set;}
        public Integer Count {get;set;}
        public Integer TotalPages {get;set;}
    }

    public with sharing class ExternalPartnerContactProfileViewModel 
    {
        public ExternalPartnerContactProfileViewModel() 
        {
        }
        public string ContactId {get;set;}
        public string FirstName {get;set;}
        public string LastName {get;set;}
        public string Email {get;set;}
        public string Phone {get;set;}
        public string Title {get;set;}
        //public string UpdateError {get;set;}
        public boolean Inactive {get;set;}
    }

    public with sharing class ExternalPartnerAccountProfileViewModel 
    {
        public ExternalPartnerAccountProfileViewModel() 
        {
        }
        public string AccountId {get;set;}
        public string Name {get;set;}
        public string Phone {get;set;}
        public string Fax {get;set;}
        public string Website {get;set;}
        public string ShippingCity {get;set;}
        public string ShippingState {get;set;}
        public string ShippingPostalCode {get;set;}
        public string ShippingStreet {get;set;}
        public string SuccessMessage {get;set;}
        public string ContactId {get;set;}
    }

    public with sharing class ContactDataTableRowViewModel 
    {
        public ContactDataTableRowViewModel() 
        {
        }
        public string Id {get;set;}
        public string Name {get;set;}
        public string Phone {get;set;}
        public string Email {get;set;}
        public string Title {get;set;}
        public string Inactive {get;set;}
    }

    

    //End Sub-Classes
}