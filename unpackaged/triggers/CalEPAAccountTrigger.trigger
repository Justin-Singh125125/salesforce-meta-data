trigger CalEPAAccountTrigger on Account (before insert, before update) 
{
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {
        for(Account a : (List<Account>)trigger.new)
        {
            //a.Normalized_Name__c = a.Name.replaceAll('[^a-zA-Z0-9]', '');
        }
    }
}