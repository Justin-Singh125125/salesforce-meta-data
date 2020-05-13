public class TriggerManager 
{
    public static boolean Run = true;    
    public static boolean RunBeforeInsert = true;    
    public static boolean RunAfterInsert = true;
    public static boolean RunAfterUpdate = true;
    
    public static boolean CanRun()
    {
        return Run;
    }
    
    public static boolean RunOnce()
    {
        if(Run)
        {
            Run = false;
            return true;
        }
        else
        {
            return Run;
        }
    }

    public static boolean runBeforeInsertOnce()
    {
        if(runBeforeInsert)
        {
            runBeforeInsert=false;
            return true;
        }
        else
        {
            return runBeforeInsert;
        }
    }

    
    public static boolean runAfterInsertOnce()
    {
        if(runAfterInsert)
        {
            runAfterInsert=false;
            return true;
        }
        else
        {
            return runAfterInsert;
        }
    }

     
    public static boolean runAfterUpdateOnce()
    {
        if(runAfterUpdate)
        {
            runAfterUpdate=false;
            return true;
        }
        else
        {
            return runAfterUpdate;
        }
    }

    
}