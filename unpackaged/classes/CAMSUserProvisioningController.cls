public class CAMSUserProvisioningController 
{
    @AuraEnabled 
    public static List<String> GetBDOs() 
	{
		List<String> bdos = new List<String>();
        bdos.Add('');
        Schema.DescribeFieldResult fieldResult = User.BDO__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple)
        {
            bdos.add(pickListVal.getLabel());
        }     
        return bdos;
	}
    
    @AuraEnabled 
    public static List<String> GetBDOSuborganizations(string bdo) 
	{
        List<String> suborganizations = new List<String>();
		suborganizations.Add('');
        PicklistFieldController controller = new PicklistFieldController();
        Map<String,List<String>> valueMap = controller.getDependentOptionsImpl('CAMS_Task__c','BDO__c','BDO_Suborganization__c');
        System.Debug('valueMap:  ' + valueMap);
        for(String contr : valueMap.keySet())
        {
            if(contr==bdo)
            {
                for(String v : valueMap.get(contr))
                {
                    suborganizations.Add(v);
                }
            }
        }
        return suborganizations;
	}	

    @AuraEnabled 
    public static boolean SaveCAMSUser(string firstName, string lastName, string email, string userName, string jobFunction, string bdo, string division)	 
	{  
		try 
		{
            User user = new User();
            user.FirstName = firstName;
            user.LastName = lastName;
            user.Email = email;
            user.UserName = userName;
            user.BDO__c = bdo;
            if(lastName.length() > 7)
            {
                user.Alias = firstName.Left(1) + lastName.Left(7);
            }
            else 
            {
                user.Alias = firstName.Left(1) + lastName;
            }
            
            string nickname = firstName + '.' + lastName;
            List<User> nickNameUsers = [SELECT Id FROM User WHERE CommunityNickname like: nickname + '%'];
            if(nickNameUsers.size() == 0)
            {
                user.CommunityNickname = nickname;
            }
            else
            {
                nickname = nickName + string.valueOf(nickNameUsers.size());
                user.CommunityNickname = nickname;
            }
            user.Division = division;
            string roleName = (bdo + '_' + division).Replace(' ','_');
            if(roleName=='Agency_Law_Enforcement_and_Counsel')
            {
                roleName='Agency_Law_Enforcement_Counsel';
            }
            System.Debug('roleName:  ' + roleName);
            
            
            
            UserRole role = [SELECT Id FROM UserRole WHERE DeveloperName =: roleName Limit 1];
            user.UserRoleId = role.Id;
            string profileName = '';
            if(bdo == 'Agency')
            {
                switch on jobFunction 
                {
                    when 'Assigner' 
                    {
                        profileName = 'CAMS Agency Assigner Platform User';                        
                    }	
                    when 'Coordinator' 
                    {
                        profileName = 'CAMS Agency Coordinator Platform User';                        
                    }
                    when 'Executive' 
                    {
                        profileName = 'CAMS Agency Executive Platform User';                        
                    }
                    when 'Reviewer' 
                    {
                        profileName = 'CAMS Agency Reviewer Platform User';                        
                    }
                    when else 
                    {
                    }
                }
            }
            else
            {
                switch on jobFunction 
                {
                    when 'Assigner' 
                    {
                        profileName = 'CAMS BDO Assigner Platform User';                        
                    }	
                    when 'Coordinator' 
                    {
                        profileName = 'CAMS BDO Coordinator Platform User';                        
                    }
                    when 'Executive' 
                    {
                        profileName = 'CAMS BDO Executive Platform User';                        
                    }
                    when 'Reviewer' 
                    {
                        profileName = 'CAMS BDO Reviewer Platform User';                        
                    }
                    when else 
                    {
                    }
                }
            }
            user.LocaleSidKey = 'en_US';
            user.TimeZoneSidKey = 'America/Los_Angeles';
            user.LanguageLocaleKey = 'en_US';
            user.EmailEncodingKey = 'ISO-8859-1';
            Profile profile = [SELECT Id FROM Profile WHERE Name =: profileName Limit 1];
            user.ProfileId = profile.Id;
            System.Debug('user:  ' + user);
            insert user;

            string publicGroupName = '';
            switch on jobFunction 
            {
                when 'Assigner' 
                {
                    publicGroupName = (bdo + '_' + division).Replace(' ','_');
                }	
                when 'Coordinator' 
                {
                    publicGroupName = bdo + '_Coordinators';                    
                }
                when 'Executive' 
                {
                    publicGroupName = bdo + '_Executives_CAMS';                    
                }
                when 'Reviewer' 
                {
                    publicGroupName = (bdo + '_' + division).Replace(' ','_');
                }
                when else 
                {
                }
            }
            if(publicGroupName != '')
            {
                Group publicGroup = [SELECT Id FROM Group WHERE DeveloperName =: publicGroupName AND Type = 'Regular' Limit 1];
                GroupMember groupMember = new GroupMember();
                groupMember.GroupId = publicGroup.Id;
                groupMember.UserOrGroupId = user.Id;
                System.Debug('groupMember:  ' + groupMember);
                insert groupMember;
            }
            if(jobFunction == 'Assigner')
            {
                string queueName = (bdo + '_' + division).Replace(' ','_');
                Group queue = [SELECT Id FROM Group WHERE DeveloperName =: queueName AND Type = 'Queue' Limit 1];
                GroupMember queueMember = new GroupMember();
                queueMember.GroupId = queue.Id;
                queueMember.UserOrGroupId = user.Id;
                System.Debug('queueMember:  ' + queueMember);
                insert queueMember;
            }
            return true;
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