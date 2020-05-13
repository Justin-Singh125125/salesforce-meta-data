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
                component.set("v.record1Id",record.Record_1__c);
                component.set("v.record2Id",record.Record_2__c);
                component.set("v.recordType",record.Object__c);                
                var picklistOptions = [];
                picklistOptions.push({ label: '', value: ''});
                picklistOptions.push({ label: 'Record 1:  ' + record.Record_1_Name__c, value: record.Record_1__c});
                picklistOptions.push({ label: 'Record 2:  ' + record.Record_2_Name__c, value: record.Record_2__c});
				component.find("MergeOptions").set("v.options", picklistOptions);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
        });
		$A.enqueueAction(action);
    },
	merge: function(component, sourceId,destinationId ) 
    {
        console.log('helper merge');
        console.log(sourceId);
        console.log(destinationId);
        var action = component.get("c.MergeRecords");
        action.setParams({"objectType": component.get("v.recordType"),"sourceId": sourceId, "destinationId": destinationId});
        action.setCallback(this, function(a) 
        {
            console.log('helper merge callback');
            var returnValue = a.getReturnValue();
            var state = a.getState();
            if(component.isValid() && state == "SUCCESS")
            {
                var eUrl= $A.get("e.force:navigateToURL");
            	eUrl.setParams({"url": '/one/one.app?source=aloha#/sObject/CalEPA_Matching__c/home'});
            	eUrl.fire();
            }
            else if (state == "ERROR") 
            {                
                var errors = a.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) 
                    {
                        component.set("v.hasErrors",true);
                        component.set("v.errors",errors[0].message);
                        console.log("Error message: " + errors);
                    }
                } 
                else
                {
                    component.set("v.hasErrors",true);
                    component.set("v.errors","Unknown error");
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
})