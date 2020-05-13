public class CalEPAMatchingSetFalsePositiveController 
{
    @AuraEnabled
    public static void SetFalsePositive(id recordId) 
    {
     	CalEPA_Matching__c match = [SELECT Id, False_Positive__c FROM CalEPA_Matching__c WHERE Id=:recordId Limit 1];
        match.False_Positive__c = true;
        update match;
    }

}