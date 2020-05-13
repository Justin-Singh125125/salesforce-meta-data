public class CalEPAMatchingRecordDetailController 
{
    @AuraEnabled 
    public static CalEPA_Matching__c GetMatchingRecord(id recordId)	 
	{ 
        CalEPA_Matching__c match = [SELECT Id, Record_1__c,Record_2__c,Object__c FROM CalEPA_Matching__c WHERE Id=:recordId Limit 1];
        return match;
    }

}