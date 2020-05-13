public without sharing class CAMSTaskTriggerHandler extends TriggerHandler 
{
    //Dalden 04/30/2019:  This method is needed because it contains advanced validation
    protected override void beforeInsert()
    {
       
        for(CAMS_Task__c task: (List<CAMS_Task__c>)trigger.new)
        {
            if (task.task_type__c == 'Sequential') 
            {
                List<CAMS_Task__c> initialTasks = [SELECT Id, Status__c FROM CAMS_Task__c WHERE CAMS_Assignment__c =: task.CAMS_Assignment__c AND task_type__c = 'Concurrent'];
        
                if (initialTasks.size() == 0) 
                {
                    task.addError('The first task for an Assignment must be Concurrent'); 
                }
            }
            
            if (task.Related_To__c != null) 
            {
                CAMS_Task__c relatedToTask = [SELECT Id, Related_To__c FROM CAMS_Task__c WHERE Id =: task.Related_To__c];
                if (relatedToTask.Related_To__c != null) 
                {
                    task.addError('You cannot create a child task from a child task.'); 
                }   
            }
        }
    }
    
    //Dalden 04/11/2019:  The BeforeUpdate Method is fully refactored
    protected override void beforeUpdate()
    {    
        System.Debug('beforeUpdate');
        for(CAMS_Task__c task: (List<CAMS_Task__c>)trigger.new)
        {
            if (task.task_type__c == 'Sequential') 
            {
                List<CAMS_Task__c> initialTasks = [SELECT Id, Status__c FROM CAMS_Task__c WHERE CAMS_Assignment__c =: task.CAMS_Assignment__c AND task_type__c = 'Concurrent' AND Id <>: task.Id];
                if (initialTasks.size() == 0) 
                {
                    task.addError('The first task for an Assignment must be Concurrent'); 
                }
            }


            CAMS_Task__c oldTask = ((CAMS_Task__c)Trigger.oldMap.get(task.Id));
            if(oldTask.Status__c != Task.Status__c)
            {
                if(Task.Status__c == 'Completed')
                {
                    List<CAMS_Task__c> childTasks = [SELECT Id, CAMS_Assignment__c, Status__c FROM CAMS_Task__c WHERE Related_to__c = :task.Id AND status__c in ('Pending','Delegated','Governors Office','Back to Requestor','Back to Assigned')];
                    if (childTasks.size() > 0)
                    {
                        task.AddError('You must complete the Subtasks before completing this task.');
                    }
                    task.Completed_Date__c = date.today();
                }
                if(Task.Status__c <> 'Completed')
                {
                    task.Completed_Date__c = null;
                }
            }
        }
    }

    //Dalden 04/30/2019:  This method is needed because there are no other ways to handle deletes
    protected override void afterDelete()
    {  
        List<CAMS_History__c> histories = new List<CAMS_History__c>();
        for (CAMS_Task__c t : (List<CAMS_Task__c>)Trigger.old)
        {
            CAMS_History__c history = new CAMS_History__c();
            history.Action__c = 'Delete';
            history.Assignment__c = t.CAMS_Assignment__c;
            history.Assignment_Name__c = t.CAMS_Assignment__r.Name;
            history.Description__c = 'Deleted';
            history.Name_Id__c = t.Name;
            history.Task_Name__c = t.Name;
            history.Type__c = 'Task';
            history.User__c = UserInfo.getUserId();
            histories.Add(history);
        }
        insert histories;
    }
}