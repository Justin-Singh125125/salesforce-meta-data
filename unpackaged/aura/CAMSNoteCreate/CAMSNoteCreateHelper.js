({
	save: function (component) 
	{
		console.log('helper.save');
		var action = component.get("c.SaveCAMSNote");
		action.setParams({recordId: component.get("v.recordId"), subject: component.get("v.subject"), content: component.get("v.content")});
		action.setCallback(this, function (a) 
		{
			var returnValue = a.getReturnValue();
            var state = a.getState();
            if(state == "SUCCESS")
            {
				component.set("v.subject", null);
				component.set("v.content", null);
				component.set("v.isOpen", false);
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