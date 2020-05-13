({
	GetRecord: function(component) 
    {
        console.log('helper GetRecord')
        var action = component.get("c.GetMatchingRecord");
        action.setParams({recordId: component.get("v.recordId")});
		action.setCallback(this, function(response) 
		{
            console.log('helper GetDuplicateCount callback')
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var record = response.getReturnValue();
                //,,
                component.set("v.record1Id",record.Record_1__c);
                component.set("v.record2Id",record.Record_2__c);
                if(record.Object__c=='Account')
                {
                	component.set("v.isAccount",true);
                }
                else
                {
                    component.set("v.isAccount",false);
                }
				
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
        });
		$A.enqueueAction(action);
    }
})