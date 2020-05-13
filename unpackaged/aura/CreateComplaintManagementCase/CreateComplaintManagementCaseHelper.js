({
	save: function(component, subject, description) 
    {
        console.log('Helper.Save 1');
        //Save and close the panel
        var action = component.get("c.Save");
        console.log('Helper.Save 2');
        action.setParams({"subject": subject, "description": description});
        console.log('Helper.Save 3');
        action.setCallback(this, function(a) 
        {
            console.log('Helper.Save 4');
            var state = a.getState();
            if(component.isValid() && state == "SUCCESS")
            {
                console.log('Helper.Save 5');
         		var returnValue = a.getReturnValue();   
                component.set("v.subject",'');
				component.set("v.description",'');
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
        console.log('Helper.Save 6');
        $A.enqueueAction(action);
        },
})