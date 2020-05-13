public class CreateComplaintFromCaseController 
{
    @AuraEnabled 
    public static Map<string, string> GetDescription(string caseId) 
	{
        Map<String, String> returnMap = new Map<String, String>();
		Case c = [SELECT Id, Description,Contact.FirstName,Contact.LastName,Contact.Email,Contact.Phone,Contact.MobilePhone,CreatedDate FROM Case WHERE Id=:caseId];
        returnMap.put('Description', c.Description);
        returnMap.put('FirstName', c.Contact.FirstName);
        returnMap.put('LastName', c.Contact.LastName);
        returnMap.put('Email', c.Contact.Email);
        returnMap.put('Phone', c.Contact.Phone);
        returnMap.put('MobilePhone', c.Contact.MobilePhone);
        returnMap.put('CreatedDate', string.valueOfGmt(c.CreatedDate));
        return returnMap;
	}
    
    @AuraEnabled 
    public static string Save(string air,string pesticides,string solidWaste,string toxicSubstances,string water,string firstName,string lastName,string email,string phone,string mobilePhone,string street,string city,string zipCode,string state,string description)	 
	{  
		try 
		{
            Complaints__c complaint = new Complaints__c();
            complaint.Complaint_Source__c = 'Email';
            if(air=='true')
            {
            	complaint.Air__c = true;
            }
            if(pesticides=='true')
            {
            	complaint.Pesticides__c =  true;
            }
			if(solidWaste=='true')
            {                
            	complaint.Solid_Waste__c =  true;
            }
			if(toxicSubstances=='true')
            {                
            	complaint.Toxic_Substances__c =  true;
            }
			if(water=='true')
            {                
            	complaint.Water__c =  true;
            }
            complaint.Complaint_Location_Address__c =  street;
            complaint.Complaint_Location_City__c =  city;
            complaint.Complaint_Location_Zip_Code__c =  zipCode;
            complaint.Complaint_Location_State__c =  state;
            complaint.Description__c =  description;            
            RecordType rt = [SELECT Id FROM RecordType WHERE SObjectType='Account' AND Name='Complainant'];
			if(email != null)
            {
                List<Account> accounts = [SELECT Id FROM Account WHERE RecordTypeId =: rt.Id AND PersonEmail=:email AND IsPersonAccount = true];
                if(accounts.Size() > 0)    
                {
                    complaint.Complainant__c = accounts[0].Id;
                }
            }
            if(complaint.Complainant__c == null && lastName != null)
            {
                Account a = new Account();
                a.RecordTypeId = rt.Id;
                a.PersonEmail = email;
                a.FirstName = firstName;
                a.LastName = lastName;
                a.Phone = phone;
                a.PersonMobilePhone = mobilePhone;
                insert a;
                complaint.Complainant__c = a.Id;
            }
			insert complaint;
            return complaint.Id;
    	}
		catch (DMLException de) 
		{
			String message = de.getDmlMessage(0);
			throw new AuraHandledException(message);    
		} 
		catch (Exception e) 
		{
			throw new AuraHandledException(e.getMessage());    
		}
    	finally 
		{
        	// Something executed whether there was an error or not
    	}       
    }  
}