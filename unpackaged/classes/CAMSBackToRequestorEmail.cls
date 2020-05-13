//dalden 3/29/2019:  This class is needed because there isn't a good way to send an email alert to 
//assignment level users from a task.
public class CAMSBackToRequestorEmail 
{
    @InvocableMethod
    public static void ProcessSendEmail(List<Id> taskIds) 
    {
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        messages = RetrieveEmailMessages(taskIds);
        if(!test.isRunningTest())
        {
            if(messages.size() > 0)
            {
                List<Messaging.SendEmailResult> results = Messaging.sendEmail(messages);
            }
        }
    }
    private static List<Messaging.SingleEmailMessage> RetrieveEmailMessages(List<Id> taskIds) 
    {
        List<Messaging.SingleEmailMessage> emailMessages = new List<Messaging.SingleEmailMessage>();
        EmailTemplate template = [Select id from EmailTemplate where Name =: 'CAMS Task Back to Requester']; 
        Map<Id, CAMS_Task__c> taskMap = new Map<Id, CAMS_Task__c>([SELECT Id, CAMS_Assignment__c FROM CAMS_Task__c WHERE Id in: taskIds]);
        List<Id> assignmentIds = new List<Id>();
        for (ID idKey : taskMap.keyset()) 
        {
            CAMS_Task__c task = taskMap.get(idKey);
            assignmentIds.Add(task.CAMS_Assignment__c);
        }
        Map<Id, CAMS_Assignment__c> assignmentMap = new Map<Id, CAMS_Assignment__c>([SELECT Id, OwnerId, Assigned_To__c FROM CAMS_Assignment__c WHERE Id in: assignmentIds]);
        List<Id> groupIds = new List<Id>();
        List<Id> userIds = new List<Id>();
        for (ID idKey : assignmentMap.keyset()) 
        {
            CAMS_Assignment__c assignment = assignmentMap.get(idKey);
            groupIds.Add(assignment.OwnerId);
            if(assignment.Assigned_To__c != null)
            {
                userIds.Add(assignment.Assigned_To__c);
            }
        }
        Map<Id, GroupMember> groupMemberMap = new Map<Id, GroupMember>([SELECT Id, GroupId, UserOrGroupId FROM GroupMember WHERE GroupId  in: groupIds]);        
        for (ID idKey : groupMemberMap.keyset()) 
        {
            GroupMember groupMember = groupMemberMap.get(idKey);
            if(string.ValueOf(groupMember.UserOrGroupId).StartsWith('005'))
            {
                userIds.Add(groupMember.UserOrGroupId);
            }
        }
        Map<Id, User> userMap = new Map<Id, User>([SELECT Id, Email FROM User WHERE Id  in: userIds]);                
        for (ID taskIdKey : taskMap.keyset()) 
        {
            Map<string,string> recipients = new Map<string,string>();
            CAMS_Task__c task = taskMap.get(taskIdKey);
            CAMS_Assignment__c assignment = assignmentMap.get(task.CAMS_Assignment__c);
            for (ID groupMemberIdKey : groupMemberMap.keyset()) 
            {
                GroupMember groupMember = groupMemberMap.get(groupMemberIdKey);
                if(groupMember.GroupId == assignment.OwnerId)
                {
                    if(string.ValueOf(groupMember.UserOrGroupId).StartsWith('005'))
                    {
                        User user = userMap.get(groupMember.UserOrGroupId);
                        recipients.put(user.Id, user.Email);
                    }
                }
            }
            if(assignment.Assigned_To__c != null)
            {
                User user = userMap.get(assignment.Assigned_To__c);
                recipients.put(assignment.Assigned_To__c,user.Email);   
            }
            if(recipients.size() > 0)
            {
                for (String recipient : recipients.keySet())
                {
                    Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();             
                    emailMessage.setSenderDisplayName(UserInfo.getName()); 
                    emailMessage.setUseSignature(false); 
                    emailMessage.setBccSender(false); 
                    emailMessage.setSaveAsActivity(false);             
                    emailMessage.setTemplateId(template.id);             
                    emailMessage.setWhatId(taskIdKey);
                    emailMessage.setTargetObjectId(recipient);
                    List<string> recipientList = new List<string>();
                    recipientList.Add(recipients.get(recipient));
                    emailMessage.setToAddresses(recipientList);
                    //emailMessage.setorgWideEmailAddressId(orgWideEmailId);
                    emailMessage.setReplyTo(UserInfo.getUserEmail());
                    emailMessages.Add(emailMessage);
                }
            }
        }
        return emailMessages;
    }
}