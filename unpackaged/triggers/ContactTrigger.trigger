trigger ContactTrigger on Contact (before insert, after insert) 
{
    new ContactTriggerHandler().execute();
}