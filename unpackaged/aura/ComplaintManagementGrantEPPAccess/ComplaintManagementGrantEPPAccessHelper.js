({
	grantAccess: function (component,recordId, accountId) 
	{
		console.log('helper.grantAccess');        
		var action = component.get("c.GrantAccess");
        action.setParams({caseId: recordId,accountId: accountId});
		action.setCallback(this, function (a) 
		{			
            var state = a.getState();
            if(state == "SUCCESS")
            {
				var id = a.getReturnValue();
                console.log(id);
                $A.get('e.force:refreshView').fire();
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