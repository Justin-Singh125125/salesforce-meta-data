public without sharing class CAMSAssignmentTriggerHandler extends TriggerHandler  
{
    //Dalden 04/30/2019:  This method is needed because it contains advanced validation
    protected override void beforeInsert()
    {
        List<Group> queues = [SELECT Id,DeveloperName FROM Group WHERE Type = 'Queue'];
        for(CAMS_Assignment__c assignment: (List<CAMS_Assignment__c>)trigger.new)
        {
            if(assignment.BDO_Suborganization__c==null)
            {
                assignment.AddError('Division, Office or Program is required');
            }
            else
            {
                string bdoPlusSuborganization = assignment.BDO__c + '_' + assignment.BDO_Suborganization__c.Replace(' ','_');            
                boolean exists = false;
                for(Group queue : queues)
                {
                    if(queue.DeveloperName==bdoPlusSuborganization)
                    {
                        exists = true;
                        assignment.OwnerId = queue.Id;
                        break;
                    }
                }
            }
        } 
    }

    //Dalden 04/11/2019:  This method is ok since we are doing advanced validation.  The BeforeUpdate Method is not bulkified.
    protected override void beforeUpdate()
    {
        List<Id> assignmentIds = new List<Id>();
        for(CAMS_Assignment__c assignment: (List<CAMS_Assignment__c>)trigger.new)
        {
            assignmentIds.Add(assignment.Id);
        }
        List<CAMS_Task__c> tasks = [SELECT Id,Status__c,CAMS_Assignment__c FROM CAMS_Task__c WHERE CAMS_Assignment__c in: assignmentIds];
        for(CAMS_Assignment__c assignment: (List<CAMS_Assignment__c>)trigger.new)
        {
            CAMS_Assignment__c oldAssignment = ((CAMS_Assignment__c)Trigger.oldMap.get(assignment.Id));
            if(assignment.Status__c != oldAssignment.Status__c)
            {
                if(assignment.Status__c == 'In Progress')
                {
                    boolean foundATask = false;
                    System.Debug('tasks:  ' + tasks);
                    for(CAMS_Task__c task: tasks)
                    {
                        if(task.CAMS_Assignment__c==assignment.Id)
                        {
                            foundATask = true;
                        }
                    }
                    if (foundATask == false) 
                    {
                        assignment.addError('You cannot delegate an assignment that has no tasks.'); 
                    }
                }
                if(assignment.Status__c == 'Closed')
                {
                    boolean canClose = true;
                    for(CAMS_Task__c task: tasks)
                    {
                        if(task.CAMS_Assignment__c==assignment.Id)
                        {
                            if(task.Status__c <> 'Completed' && task.Status__c <> 'Withdrawn')
                            {
                                canClose = false;
                            }
                        }
                    }
                    if (canClose == false) 
                    {
                        assignment.addError('You cannot close an assignment without all tasks either completed or withdrawn.'); 
                    }
                    assignment.Closed_Withdrawn_Date__c = date.today();
                }
                if(assignment.Status__c == 'Completed')
                {
                    boolean canClose = true;
                    for(CAMS_Task__c task: tasks)
                    {
                        if(task.CAMS_Assignment__c==assignment.Id)
                        {
                            if(task.Status__c <> 'Completed' && task.Status__c <> 'Withdrawn')
                            {
                                canClose = false;
                            }
                        }
                    }
                    if (canClose == false) 
                    {
                        assignment.addError('You cannot complete an assignment without all tasks either completed or withdrawn.'); 
                    }
                    assignment.Closed_Withdrawn_Date__c = date.today();
                }
                if(assignment.Status__c == 'Withdrawn')
                {
                    assignment.Closed_Withdrawn_Date__c = date.today();
                }
                if(assignment.Status__c <> 'Withdrawn' && assignment.Status__c <> 'Closed')
                {
                    assignment.Closed_Withdrawn_Date__c = null;
                }

            }
        }        
    }
    
    //Dalden 04/30/2019:  This method is needed because there are no other ways to handle deletes
    protected override void beforeDelete()
    {
        List<Id> assignmentIds = new List<Id>();
        for(CAMS_Assignment__c assignment: (List<CAMS_Assignment__c>)Trigger.Old) 
        {
            assignmentIds.Add(assignment.Id);
        }
        
        List<CAMS_Task__c> tasksToDelete = [SELECT Id FROM CAMS_Task__c WHERE CAMS_Assignment__c in: assignmentIds];
        delete tasksToDelete;
    }

    //Dalden 04/30/2019:  This method is needed because there are no other ways to handle deletes
    protected override void afterDelete()
    {
        List<Id> assignmentIds = new List<Id>();
        List<CAMS_History__c> histories = new List<CAMS_History__c>();
        for(CAMS_Assignment__c assignment: (List<CAMS_Assignment__c>)Trigger.Old) 
        {
            CAMS_History__c history = new CAMS_History__c();
            history.Action__c = 'Delete';
            history.Description__c = 'Deleted';
            history.Name_Id__c = assignment.Name;
            history.User__c = UserInfo.GetUserId();
            history.Type__c = 'Assignment';
            history.Test_Data__c = assignment.Test_Data__c;
            histories.Add(history);            
        }
        insert histories;
    }
}