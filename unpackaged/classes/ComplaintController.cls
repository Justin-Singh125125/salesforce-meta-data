public class ComplaintController{

    public Complaints__c complaint;
    public Account account;
    public Contact contact { get; set; }
    public Contact personContact { get; set; }
    public string currentLanguage { get; set;}
    public string occuranceDateTime { get; set;}
    public string submittedDate  { get; set; }
    public boolean isEmergency { get; set; }
    public boolean emailOptOut { get; set; }
    public boolean displayMessage {get; set; } 
    public boolean displayAttachments { get; set;}
    public boolean descError { get; set; }
    public boolean fNameError { get; set; }
    public boolean lNameError { get; set; }
    public boolean emailError { get; set; }
    public boolean confirmEmailError{ get; set; }
    public boolean referalEmailError { get; set; }
    public string sameAddress { get; set; }
    public boolean contactRequired { get; set; }
    public boolean langaugeEnglish { get; set; }
    public Attachment attachment {get; set; }
    public string contactLastName { get; set; }
    public string lastName { get; set; }
    public string firstName { get; set; }
    public string rAttachmentId { get; set; }
    public string confirmEmail { get; set; }
    public string prop65Url { get; set;}
    public string waterwasteUrl { get; set; }
    public string pesticideUrl { get; set; }
    public Map<Id,string> attachmentMap { get; set; } 
    ApexPages.StandardController sController { get; set; }
    public Map<string,string> helpTextMap { get; set; }
    
    public ComplaintController(ApexPages.StandardController stdController)
    {
        
        sController = stdController;
        emailOptOut = true;
        langaugeEnglish = true;
        displayMessage = false;
        displayAttachments = false;
        isEmergency = false;
        sameAddress = '';
        occuranceDateTime = '';
        confirmEmailError = false;
        referalEmailError = false;
        descError = false;
        fNameError = false;
        lNameError = false;
        emailError = false;
        contactRequired = true;
        rAttachmentId = '';
        prop65Url = '';
        waterwasteUrl = '';
        pesticideUrl = '';
        confirmEmail = '';
        firstName = '';
        lastName = '';
        if(attachment == null){ attachment = new Attachment(); }
        if(attachmentMap == null){ attachmentMap = new Map<Id,string>(); } else { updateAttachmentMap(); }
        if(ApexPages.currentPage() != null && ApexPages.currentPage().getParameters().get('language') != null){
            system.debug('setting language ' + ApexPages.currentPage().getParameters().get('language'));
            if(ApexPages.currentPage().getParameters().get('language') == 'es_MX'){ 
                system.debug('setting spanish');
                currentLanguage = 'es_MX';
                langaugeEnglish = false;
            } else if(ApexPages.currentPage().getParameters().get('language') == 'en_US'){
                system.debug('setting english');
                currentLanguage = 'en_US';
                langaugeEnglish = true;
            }
        }
        if(currentLanguage == null ){
            currentLanguage = 'en_US';
            langaugeEnglish = true;
            if(ApexPages.currentPage() != null && ( ApexPages.currentPage().getParameters().get('language') == null || ApexPages.currentPage().getParameters().get('language') == '')){
                string language = ApexPages.currentPage().getHeaders().get('Accept-Language');
                if(language != null && language.substring(0,5) == 'en-MX'){ 
                        currentLanguage = 'es_MX'; langaugeEnglish = false;
                }
                system.debug('language: ' + language);
            }
            system.debug('currentLanguage: ' + currentLanguage);
        }
        
        getCustomLinks();
        personContact = new Contact();
        account = getAccount();
    }
    
    public pageReference switchLanguage()
    {
        if(!langaugeEnglish){
            currentLanguage = 'es_MX';
            personContact.Language__c = 'Spanish';
            langaugeEnglish = false;
        } else {
            currentLanguage = 'en_US';
            personContact.Language__c = 'English';
            langaugeEnglish = true;
        }
        PageReference pr = Page.Complaint;
        pr.getParameters().put('language',currentLanguage);
        pr.setRedirect(true);
        return pr;
    }
     
    
    
    public void getCustomLinks(){
        List<Custom_Links__c> links = [SELECT Id, Name, Web_Link__c FROM Custom_Links__c];
        for(Custom_Links__c link : links){
            if(link.Name == 'Water Waste'){ waterwasteUrl = link.Web_Link__c; }
            if(link.Name == 'Prop65'){ prop65Url = link.Web_Link__c; }
            if(link.Name == 'Pesticides - CAC Directory'){pesticideUrl = link.Web_Link__c; }
        }
    }
    
    public void updateSameAddress(){
        system.debug('sameAddress: ' + sameAddress);
        complaint.Complaint_Location_State__c = 'California';
        complaint.Responsible_Party_Street__c = null;
        complaint.Responsible_Party_City__c = null;
        complaint.Responsible_Party_State__c = null;
        complaint.Responsible_Party_Zip_Code__c = null;
        if(sameAddress == 'true'){
            complaint.Responsible_Party_Street__c = complaint.Complaint_Location_Address__c;
            complaint.Responsible_Party_City__c = complaint.Complaint_Location_City__c;
            complaint.Responsible_Party_State__c = complaint.Complaint_Location_State__c;
            complaint.Responsible_Party_Zip_Code__c = complaint.Complaint_Location_Zip_Code__c;
        }
    }
    
    public void updateAttachmentMap(){
        if(attachmentMap == null) { 
            attachmentMap = new Map<Id,string>();
         } else { 
            Set<Id> aIds = new Set<Id>();
            
            for(string a : attachmentMap.keySet()){
                aIds.add(a);
            }
            List<Attachment> ats = [SELECT Id, Name FROM Attachment WHERE Id in: aIds];
            Set<Id> tIds = new Set<Id>();
            for(Attachment a : ats){
                tIds.add(a.Id);
            }
            for(string a : aIds){
                if(!tIds.contains(a)){
                    attachmentMap.remove(a);
                }
            }
         }
    }
    
    public Complaints__c getComplaint(){
        if(complaint == null) { 
            complaint = new Complaints__c(); 
            //complaint.Complaint_Location_State__c = 'California'; do not set default so map will use default location of geolocation from browser or mobile
            complaint.Unknown_Date_of_Occurrence__c = 'Exact Date';
            //complaint.Complaint_Location__Latitude__s = 37.1954073;
            //complaint.Complaint_Location__Longitude__s = -119.7742066;
        }
        return complaint;
    }
    
    public Account getAccount(){
        if(account == null) {
            RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Complainant' and SObjectType = 'Account'];
            account = new Account();
            account.RecordType = personAccountRecordType;
            account.PersonMailingState = 'California';
        }
        return account;
    }
    
    public void updateAnonymous(){
        system.debug('anonymous: ' + complaint.Anonymous__c);
    }
    
    public void updateReferring(){
        system.debug('referring: ' + complaint.Referring__c);
    }
    
    public PageReference emeregency(){
        isEmergency = true;
        return Page.Complaint;
    }
    
    public void getContact(){
        if(contact == null) {
            try{
                contact = [SELECT Id, LastName, FirstName FROM Contact WHERE LastName = 'complaint' AND FirstName = 'holder' LIMIT 1];
            } catch(Exception e){
                
            }
            if(contact == null || (contact != null && contact.LastName != 'complaint')){
                Contact tContact = new Contact();
                tContact.LastName = 'complaint';
                tContact.FirstName = 'holder';
                insert tContact;
                contact = tContact;
            }
        }
        system.debug('contact: ' + contact);
    }
    
    // Step 1 = Complaint
    public PageReference step1() {
      system.debug('step1: ' + complaint);
      return Page.Complaint;
    }

    // Step 2 = Complaint Details
    public PageReference step2() {
        boolean passcheck = false;
        displayMessage = false;
        if(complaint.Air__c || complaint.Water__c || complaint.Solid_Waste__c || complaint.Toxic_Substances__c || complaint.Pesticides__c){
            passcheck = true;
        }
        if(!passcheck){
            displayMessage = true;
            ApexPages.addMessage(New ApexPages.Message(ApexPages.Severity.ERROR,'You must select atleast one area for the complaint.'));
            return null;
        }
       
        
       
        displayMessage = false;
        system.debug('step2: ' + complaint);
        return Page.ComplaintDetails;
    }

    // Step 3 = Complaint Contact
    public PageReference step3() 
    {
        Boolean passcheck = true;
        complaint.Complaint_Location_State__c = 'California';
        system.debug('step3: ' + complaint);
        try
        {
            if(attachment != null && attachment.Name != null)
            {
                addAttachment();
            }
            if(complaint.Description__c == null || complaint.Description__c == '')
            {
                descError = true;
                passcheck = false;
            }
            system.debug('descError: ' + descError);
            system.debug('passcheck: ' + passcheck);
            if(!passcheck)
            {
                return null;
            }
            descError = false;
            if(occuranceDateTime != null && complaint.Unknown_Date_of_Occurrence__c == 'Exact Date')
            {
                system.debug('occuranceDateTime: ' + occuranceDateTime);
                DateTime occuranceDT; //DateTime.parse(occuranceDateTime);
                // may need to change from parse to newInstance and split out the values
                string[] parts = occuranceDateTime.split(' ');
                string[] dparts = parts[0].split('/');
                string[] tparts = parts[1].split(':');
                string ampm = parts[2];
                system.debug('parts: ' + parts);
                system.debug('dparts: ' + dparts);
                system.debug('tparts: ' + tparts);
                
                
                integer month = integer.valueOf(dparts[0]);
                integer day = integer.valueOf(dparts[1]);
                integer year = integer.valueOf(dparts[2]);
                
                integer hour = integer.valueOf(tparts[0]);
                integer minute = integer.valueOf(tparts[1]);
                integer second = 0;
                if(hour == 12 && ampm == 'AM'){ hour = 0;}
                if(hour >=1 && hour < 12 && ampm == 'PM'){ hour = hour + 12;}
                
                occuranceDT = DateTime.newInstance(year, month, day, hour, minute, second);
                system.debug('occuranceDT: ' + occuranceDT);
                complaint.Date_and_Time_of_Occurrence__c = occuranceDT;
            }
            system.debug('step3: ' + complaint);
        }
        catch(Exception e)
        {
            return null;  
        }
        return Page.ComplaintContact;
    }

    // Step 4 = Confirmation
    public PageReference step4() 
    {
        fNameError = false;
        lNameError = false;
        emailError = false;
        confirmEmailError = false;
        referalEmailError = false;
        try
        {
            if(!langaugeEnglish)
            {
                personContact.Language__c = 'Spanish';
            } 
            else 
            {
                personContact.Language__c = 'English';
            }
            
            if(!complaint.Anonymous__c)
            {
                if(!emailOptOut)
                { 
                    account.PersonHasOptedOutOfEmail = true; 
                }
                personContact.LastName = contactLastName;
                if(personContact.LastName == null 
                    || personContact.LastName == '' 
                    || personContact.firstName == null 
                    || personContact.FirstName == '')
                {
                    displayMessage = true;
                    if(personContact.LastName == null || personContact.LastName == '')
                    {
                        string lastNameMsg = getLabelValue('COMPLAINT_ERR_Last_Name');
                        personContact.LastName.addError(lastNameMsg);
                        lNameError = true;
                    }
                    if(personContact.FirstName == null || personContact.FirstName == '')
                    {
                        string firstNameMsg = getLabelValue('COMPLAINT_ERR_First_Name');
                        personContact.FirstName.addError(firstNameMsg);
                        fNameError = true;
                    }
                }
    
                if(account.PersonEmail == null 
                    || account.PersonEmail == '' 
                    || complaint.Temp_Contact_Email__c == '' 
                    || complaint.Temp_Contact_Email__c != account.PersonEmail)
                {
                    if((complaint.Temp_Contact_Email__c != null && complaint.Temp_Contact_Email__c != '') 
                        && (account.PersonEmail != null && account.PersonEmail != '') 
                        || complaint.Temp_Contact_Email__c != account.PersonEmail)
                    {
                        string tempConfirmEmailMsg = getLabelValue('COMPLAINT_ERR_Email_Confirm');
                        complaint.Temp_Contact_Email__c.addError(tempConfirmEmailMsg);
                        confirmEmailError = true;
                    }
                    displayMessage = true;
                }
            }
            if(complaint.Referring__c)
            {
                if((complaint.Referring_Agency__c != '' || complaint.Referring_Name__c != '') && complaint.Referring_Email_Address__c == null)
                {
                    system.debug('complaint referer field: ' + complaint);
                    displayMessage = true;
                    string refEmailMsg = getLabelValue('COMPLAINT_ERR_Email_Address');
                    complaint.Referring_Email_Address__c.addError(refEmailMsg);
                    referalEmailError = true;
                }
            }
            else
            {
                complaint.Referring_Agency__c = '';
                complaint.Referring_Name__c = '';
                complaint.Referring_Email_Address__c = '';
            }
            if(emailError || confirmEmailError || fNameError || lNameError || referalEmailError)
            {
                return null;
            }
            account.LastName = personContact.LastName;
            lastName = account.LastName;
            
            if(personContact.FirstName != '') 
            { 
                firstName = personContact.FirstName;
                account.FirstName = personContact.FirstName; 
            }

            if(complaint != null)
            {
                 if(!complaint.Anonymous__c)
                 {
                    RecordType personAccountRecordType =  [SELECT Id FROM RecordType WHERE Name = 'Complainant' and SObjectType = 'Account'];
                    if(account != null && account.PersonEmail != null && account.PersonEmail != '')
                    {
                        account.RecordTypeId = personAccountRecordType.Id;
                        List<Contact> locatedContact = [SELECT Id, AccountId, Email FROM Contact WHERE Email =: account.PersonEmail  AND IsPersonAccount = true LIMIT 1];
                        system.debug('locatedContact: ' + locatedContact);
                        if(!locatedContact.isEmpty() && locatedContact.size() > 0)
                        {
                            complaint.Complainant__c = locatedContact[0].AccountId;
                            system.debug('setting located contact account');
                        } 
                        else if(account.Id == null)
                        {
                            insert account;
                            system.debug('created new account');
                            complaint.Complainant__c = account.Id;
                        }
                        system.debug('account: ' + account);
                    }
                    else
                    {
                        account.RecordTypeId = personAccountRecordType.Id;
                        account.PersonHasOptedOutOfEmail = true; 
                        insert account;
                        system.debug('created new account');
                        complaint.Complainant__c = account.Id;
                    }
                }

                if(complaint.Id != null)
                { 
                    complaint.Complaint_Source__c = 'Web';
                    update complaint;
                    system.debug('updated complaint: ' + complaint);
                } 
                else 
                {
                    system.debug('complaint: ' + complaint);
                    complaint.Complaint_Source__c = 'Web';
                    Id parentRecTypeId = [SELECT Id, Name, SobjectType FROM RecordType WHERE SobjectType = 'Complaints__c' AND Name = 'Parent' ].Id;
                    if(parentRecTypeId != null)
                    {
                        complaint.RecordTypeId = parentRecTypeId;
                    }
                    system.debug('occurance datetime: '+ complaint.Date_and_Time_of_Occurrence__c);
                    if(complaint.Unknown_Date_of_Occurrence__c=='Exact Date')
                    {

                    }
                    insert complaint;
                    system.debug('occurance datetime: '+ complaint.Date_and_Time_of_Occurrence__c);
                    
                    system.debug('inserted complaint: ' + complaint);
                    String query = 'select ';
                    for(String fieldApiName : Schema.SObjectType.Complaints__c.fields.getMap().keySet())
                    {
                        query += fieldApiName + ',';
                    }
                    query = query.substring(0,query.length() - 1);
                    query += ' FROM Complaints__c WHERE Id = \'' + complaint.Id + '\' LIMIT 1';
                    system.debug('query: ' + query);
                    complaint = database.query(query);
                    submittedDate = complaint.CreatedDate.format('yyyy-MM-dd HH:mm:ss', 'PST') + ' PST';
                }
                
                system.debug('attachmentMap: ' + attachmentMap);
                if(!attachmentMap.isEmpty() && attachmentMap.size() > 0)
                {
                    Set<Id> aIds = new Set<Id>();
                    for(string a : attachmentMap.keySet())
                    {
                        aIds.add(a);
                    }
                    List<Attachment> attachments = [SELECT Id, Name,ContentType, Body FROM Attachment WHERE Id in : aIds];
                    system.debug('attachments: ' + attachments);
                    List<Attachment> complaintAttachments = new List<Attachment>();
                    Attachment nAtt = new Attachment();
                    for(Attachment a : attachments)
                    {
                        nAtt = new Attachment();
                        nAtt.ParentId = complaint.Id;
                        nAtt.Name = a.Name;
                        nAtt.ContentType = a.ContentType;
                        nAtt.Body = a.Body;
                        complaintAttachments.add(nAtt);
                    }
                    if(!complaintAttachments.isEmpty() && complaintAttachments.size() > 0)
                    {
                        system.debug(complaintAttachments);
                        insert complaintAttachments;
                    }
                    delete attachments;
                }
            }
            displayMessage = false;
            system.debug('step4: ' + complaint);
        }
        catch(Exception e)
        {
            ApexPages.addMessage(New ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
            return null;
        }
        return Page.Confirmation;
    }
    
    public string getLabelValue(string labelName){
        Component.Apex.OutputText output = new Component.Apex.OutputText();
        output.expressions.value = '{!$Label.' + labelName + '}';
        
        return String.valueOf(output.value);
    }
    
    public PageReference cancel(){
        PageReference pr = new PageReference('');
        pr.setRedirect(true);
        return pr;
    }
    
    public void addAttachment(){
        
        getContact();
        system.debug('attachmentMap:' + attachmentMap);
        updateAttachmentMap();
        system.debug('attachmentMap:' + attachmentMap);
        system.debug('contact: ' + contact);
        system.debug('attachment: ' + attachment);
        if(attachment != null && attachment.Name != null){
            attachment.ParentId = contact.Id;
            insert attachment;
            attachmentMap.put(attachment.Id, attachment.Name);
            displayAttachments = true;
        }
        system.debug('attachmentMap:' + attachmentMap);
        attachment = new Attachment(); 
    }
    
    
    @RemoteAction
    public static String remoteRemoveAttachment(string attachmentId){
        if(attachmentId != ''){
            Attachment rAttachment = [SELECT Id FROM Attachment WHERE Id=:attachmentId];
            delete rAttachment;
        }
        return attachmentId;
    }
    
    public void removeAttachment(){
        system.debug('rAttachmentId: ' + rAttachmentId);
        if(rAttachmentId != null && rAttachmentId != ''){
            for(string a : attachmentMap.keySet()){
                if(attachmentMap.get(a) == rAttachmentId){
                    attachmentMap.remove(a);
                    Attachment rAttachment = [SELECT Id FROM Attachment WHERE Id=:a];
                    delete rAttachment;
                    
                }
            }
        }
        updateAttachmentMap();
        rAttachmentId = '';
    }
    
    public PageReference pageCheck(){
        if(complaint == null ){
             return Page.Complaint;
        }
        boolean passcheck = false;
        if(complaint.Air__c || complaint.Water__c || complaint.Solid_Waste__c || complaint.Toxic_Substances__c || complaint.Pesticides__c){
            passcheck = true;
        }
        if(!passcheck){
            return Page.Complaint;
        }
        
        return null;
    }
    
    public List<SelectOption> getStates(){
        List<SelectOption> states = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Complaints__c.Complaint_Location_State__c.getDescribe();
       List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
            
       for( Schema.PicklistEntry f : ple)
       {
          states.add(new SelectOption(f.getLabel(), f.getValue()));
       }      
        return states;
    }

    public void mapAddressUpdate(){
        ExternalAPIs__c googleMap = [SELECT Id, Name, User_Name__c, Password__c, End_Point__c,API_Key__c FROM ExternalAPIs__c WHERE Name = 'Google Maps' LIMIT 1];
        string url = googleMap.End_Point__c;
        string params = '?address=';
        if(complaint.Complaint_Location_Address__c != null){
            params += complaint.Complaint_Location_Address__c + ', ';
        }
        if(complaint.Complaint_Location_City__c != null){
            params += complaint.Complaint_Location_City__c + ', ';
        }
        if(complaint.Complaint_Location_State__c != null){
            params += complaint.Complaint_Location_State__c + ', ';
        }
        if(complaint.Complaint_Location_Zip_Code__c != null){
            params += complaint.Complaint_Location_Zip_Code__c;
        }
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url + System.EncodingUtil.urlEncode(params, 'UTF-8'));
        req.setMethod('GET');
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());

    }
}