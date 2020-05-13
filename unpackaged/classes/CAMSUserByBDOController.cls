public class CAMSUserByBDOController 
{
    @AuraEnabled 
    public static map<String,integer> GetBDOUserCounts() 
	{
        Map<String,integer> bdos = new Map<String,integer>();
        List<User> users = [SELECT Id, Name, BDO__c FROM User WHERE Profile.Name like 'CAMS%'];
        for(User user : users)
        {
            if(!bdos.containsKey(user.BDO__c))
            {
                bdos.put(user.BDO__c, 1);
            }
            else 
            {
                integer count = bdos.get(user.BDO__c);
                count = count + 1;
                bdos.put(user.BDO__c, count);
            }
        }
        return bdos;
	}
}