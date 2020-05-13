public class DashboardComplaintsByBDOChart 
{
    //Comment
    @AuraEnabled
    public static String GetComplaintsByBDOAllTime()
    {
        List<Complaints__c> complaints = [SELECT Id, BDO_For_Report__c FROM Complaints__c WHERE Original_Complaint_ID__c = null];
        Map<String,Integer> mapLeadSource = new Map<String,Integer>();
        
        for(Complaints__c l : complaints)
        {
            if(mapLeadSource.containsKey(l.BDO_For_Report__c))
            {
                mapLeadSource.put(l.BDO_For_Report__c, mapLeadSource.get(l.BDO_For_Report__c)+1) ;
            }
            else
            {
                mapLeadSource.put(l.BDO_For_Report__c, 1) ;        
            }
        }
        list<RadarDataWrapper> radarData = new list<RadarDataWrapper>();
        for(String key : mapLeadSource.keySet())
        {            
            RadarDataWrapper rdw = new RadarDataWrapper();
            rdw.name=key;
            rdw.y=mapLeadSource.get(key);
            radarData.add(rdw);
        }
        for(RadarDataWrapper rdw : radarData)
        {            
            //Take Count
            integer c = rdw.y;
            //Divide By Complaint Count
            decimal d = decimal.ValueOf(c)/decimal.ValueOf(complaints.size());
            //Multiply By 100
            d = d * 100;
            //Take Integer Part
            Long l = d.round(System.RoundingMode.UP);
            rdw.y = l.intValue();

        }
        System.Debug('All Time RadarData:  ' + radarData);
        radarData.sort();
        return System.json.serialize(radarData);
    }

    @AuraEnabled
    public static String GetComplaintsByBDOThisYear()
    {
        List<Complaints__c> complaints = [SELECT Id, BDO_For_Report__c FROM Complaints__c WHERE Original_Complaint_ID__c = null AND Actual_Receive_Date__c = THIS_YEAR];
        Map<String,Integer> mapLeadSource = new Map<String,Integer>();
        
        for(Complaints__c l : complaints)
        {
            if(mapLeadSource.containsKey(l.BDO_For_Report__c))
            {
                mapLeadSource.put(l.BDO_For_Report__c, mapLeadSource.get(l.BDO_For_Report__c)+1) ;
            }
            else
            {
                mapLeadSource.put(l.BDO_For_Report__c, 1) ;        
            }
        }
        list<RadarDataWrapper> radarData = new list<RadarDataWrapper>();
        
        for(String key : mapLeadSource.keySet())
        {            
            RadarDataWrapper rdw = new RadarDataWrapper();
            rdw.name=key;
            rdw.y=mapLeadSource.get(key);
            radarData.add(rdw);
        }
        for(RadarDataWrapper rdw : radarData)
        {            
            //Take Count
            integer c = rdw.y;
            //Divide By Complaint Count
            decimal d = decimal.ValueOf(c)/decimal.ValueOf(complaints.size());
            //Multiply By 100
            d = d * 100;
            //Take Integer Part
            Long l = d.round(System.RoundingMode.UP);
            rdw.y = l.intValue();

        }
		System.Debug('This Year RadarData:  ' + radarData);
        radarData.sort();
        return System.json.serialize(radarData);
    }
    
    class RadarDataWrapper implements Comparable
    {
       @AuraEnabled
       public String name;
       @AuraEnabled
       public integer y;

       public Integer compareTo(Object compareTo) 
       {
            // Cast argument to RadarDataWrapper
            RadarDataWrapper compareTo2 = (RadarDataWrapper)compareTo;
            
            // The return value of 0 indicates that both elements are equal.
            Integer returnValue = 0;
            if (name > compareTo2.Name) 
            {
                // Set return value to a positive value.
                returnValue = 1;
            } 
            else if (name < compareTo2.Name) 
            {
                // Set return value to a negative value.
                returnValue = -1;
            }
            
            return returnValue;       
        }
    }

}