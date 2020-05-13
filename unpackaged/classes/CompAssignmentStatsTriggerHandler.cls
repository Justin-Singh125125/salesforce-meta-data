public with sharing class CompAssignmentStatsTriggerHandler  extends TriggerHandler 
{
    /*
    protected override void beforeUpdate() //Not Bulkified
    {
        System.Debug('CompAssignmentStatsTriggerHandler.beforeUpdate');
        Map<Id, Complaint_Assignment__c> oldMap = (Map<Id, Complaint_Assignment__c>)trigger.oldMap;
        for(Complaint_Assignment__c assignment: (List<Complaint_Assignment__c>)trigger.new)
        {
            Date assignmentDateCreated = date.newinstance(assignment.CreatedDate.year(), assignment.CreatedDate.month(), assignment.CreatedDate.day());     
            if(assignment.Date_to_Under_Review__c != oldMap.get(assignment.Id).Date_to_Under_Review__c || assignment.Date_Referred__c != oldMap.get(assignment.Id).Date_Referred__c || assignment.Date_Closed__c != oldMap.get(assignment.Id).Date_Closed__c )
            {                
                List<Date> tempDates = new List<Date>();
                tempDates.Add(Date.Today());
                if(assignment.Date_Closed__c != null)
                {
                    tempDates.Add(assignment.Date_Closed__c);
                }
                if(assignment.Date_Referred__c != null)
                {
                    tempDates.Add(assignment.Date_Referred__c);
                }
                if(assignment.Date_to_Under_Review__c != null)
                {
                    tempDates.Add(assignment.Date_to_Under_Review__c);
                }
                tempDates.sort();
                date minDate = tempDates.get(0);
                assignment.Days_to_First_Process__c  = BusinessDaysBetween(assignmentDateCreated, minDate);
            }
        }
    }

    public integer BusinessDaysBetween(Date startDate, Date lastDate )
    {

        Integer totalNumberOfDays = lastDate.daysBetween(startDate);
        //Find Number of Weekend Days and Holidays

        //Counter
        integer count = 0;

        integer differenceBetTwoDate = startDate.DaysBetween(lastDate);
        //Loop 
        for(integer i = 0; i <= differenceBetTwoDate; i++) 
        {
            date iDay = startDate.addDays(i);
            Date startOfWeek   = iDay.toStartOfWeek();
            Integer dayOfWeek  = startOfWeek.DaysBetween(iDay);
            if(dayOfWeek == 0 || dayOfWeek == 6)
            {
                count += 1;
            }
        }

        //Get Holidays
        List<Holiday> holidays = [SELECT Id,Name,ActivityDate FROM Holiday WHERE ActivityDate >=: startDate AND ActivityDate <=: lastDate];
        //Loop
        for (Holiday holiday : holidays) 
        {
            Date startOfWeek   = holiday.ActivityDate.toStartOfWeek();
            Integer dayOfWeek  = startOfWeek.DaysBetween(holiday.ActivityDate);
            if(dayOfWeek != 0 && dayOfWeek != 6)
            {
                count += 1;
            }
        }

        integer numberOfBusinessDays = totalNumberOfDays - count;
        return numberOfBusinessDays;
    }
    */
}