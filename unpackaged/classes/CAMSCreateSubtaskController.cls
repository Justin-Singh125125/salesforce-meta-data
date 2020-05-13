public class CAMSCreateSubtaskController 
{
	@AuraEnabled 
    public static Date GetParentDueDate(id parentTaskId) 
	{
		CAMS_Task__c task = [SELECT ID, Due_Date__c FROM CAMS_Task__c WHERE Id=:parentTaskId];
		return task.Due_Date__c;
	}

	@AuraEnabled 
    public static List<String> GetBDOs(id parentTaskId) 
	{
		List<String> bdos = new List<String>();
		CAMS_Task__c task = [SELECT ID, BDO__c FROM CAMS_Task__c WHERE Id=:parentTaskId];
		bdos.Add(task.BDO__c);
		return bdos;
		/*
		List<String> bdos = new List<String>();
		Id userId = UserInfo.getUserId();
		User user = [SELECT ID, BDO__c FROM User WHERE Id=:userId];
		if(user.BDO__c == 'Agency')
		{
			bdos.Add('');
			Schema.DescribeFieldResult fieldResult = CAMS_Task__c.BDO__c.getDescribe();
			List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
			for( Schema.PicklistEntry pickListVal : ple)
			{
				bdos.add(pickListVal.getLabel());
			}     
			return bdos;
		}
		else 
		{
			bdos.Add(user.BDO__c);
			bdos.Add('Agency');
			return bdos;
		}
		*/
	}
	
	@AuraEnabled 
    public static List<String> GetStatuses() 
	{
		List<String> statuses = new List<String>();		
		Schema.DescribeFieldResult fieldResult = CAMS_Task__c.Status__c.getDescribe();
		List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
		for( Schema.PicklistEntry pickListVal : ple)
		{
			statuses.add(pickListVal.getLabel());
		}     
		return statuses;
	}
	
	@AuraEnabled 
    public static List<String> GetBDOSuborganizations(string bdo) 
	{
		Id userId = UserInfo.getUserId();
		User user = [SELECT ID, BDO__c FROM User WHERE Id=:userId];
		List<String> suborganizations = new List<String>();
		suborganizations.Add('');
		if(user.BDO__c != 'Agency' && bdo == 'Agency')
		{
			suborganizations.Add('Executive Office');
			suborganizations.Add('Fiscal and Admin Programs');
			return suborganizations;
		}
		else
		{
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
	}	  
	
	@AuraEnabled 
    public static List<User> GetQueueUsers(string bdo, string suborganization) 
	{
		string groupName = bdo + '_' + suborganization.Replace(' ','_');
		List<Group> groups = [SELECT Id FROM Group WHERE DeveloperName =: groupName AND (Type='Queue' OR Type='Regular')];
		List<Id> groupIds = new List<Id>();
		for(Group g : groups)
		{
			groupIds.Add(g.Id);
		}
		List<GroupMember> members = new List<GroupMember>(); 
		for(GroupMember sgm : [SELECT UserOrGroupId FROM GroupMember WHERE GroupId in: groupIds ])
		{
			members.Add(sgm);			
		}
		List<Id> userIds = new List<Id>();
		for(GroupMember groupMember : members)
		{
			if(string.ValueOf(groupMember.UserOrGroupId).StartsWith('005'))
			{
				if(!userIds.contains(groupMember.UserOrGroupId))
				{
					userIds.Add(groupMember.UserOrGroupId);
				}
			}
		}
		List<User> users = new List<User>();
		users.Add(new User());
		List<User> retrievedUsers = [SELECT Id, Name FROM User WHERE Id in: userIds];
		for(User user : retrievedUsers)
		{
			users.Add(user);
		}
		return users;
	}

	@AuraEnabled 
    public static CAMS_Task__c SaveChildTask(id parentTaskId, string bdo, string suborganization, id assignedTo, string dueDate, string status, string instructions)	 
	{  
		try 
		{
			CAMS_Task__c parentTask = [SELECT ID, CAMS_Assignment__c FROM CAMS_Task__c WHERE Id =: parentTaskId];
			CAMS_Task__c task = new CAMS_Task__c();
			task.CAMS_Assignment__c = parentTask.CAMS_Assignment__c;
			task.Related_To__c = parentTask.Id;
			task.BDO__c = bdo;
			task.BDO_Suborganization__c = suborganization;
			task.Assigned_To__c = assignedTo; 
			if(!string.IsBlank(dueDate))
			{
				task.Due_Date__c = date.parse(dueDate);
			}
			task.Status__c = status;
			task.Instructions__c = instructions;
			task.Task_Type__c = 'Concurrent';
			upsert task;
			return task;
    	}
		catch (DMLException de) 
		{
			System.Debug('de:  ' + de);
			throw new AuraHandledException(de.getMessage());    
		} 
		catch (Exception e) 
		{
			System.Debug('e:  ' + e);
			throw new AuraHandledException(e.getMessage());    
		}
   }
}