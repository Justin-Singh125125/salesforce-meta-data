trigger CalEPAContentVersionTrigger on ContentVersion (before insert) 
{
    new CalEPAContentVersionTriggerHandler().execute();   
}