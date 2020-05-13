({
	associate: function (component,recordId, complaintId) 
	{
		console.log('helper.associate');        
        var action = component.get("c.Associate");
        action.setParams({caseId: recordId,complaintId: complaintId});
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
    associateAndClose: function (component,recordId, complaintId) 
	{
		console.log('helper.associateAndClose');
		var action = component.get("c.AssociateAndClose");
        action.setParams({caseId: recordId,complaintId: complaintId});
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