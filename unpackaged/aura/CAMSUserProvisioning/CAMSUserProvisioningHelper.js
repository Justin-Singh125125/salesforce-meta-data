({
    save: function(component, firstName, lastName, email, userName, jobFunction, bdo, division) 
    {
        //Save and close the panel
        var action = component.get("c.SaveCAMSUser");
        action.setParams({"firstName": firstName, "lastName": lastName, "email": email, "userName": userName, "jobFunction": jobFunction, "bdo": bdo, "division": division});
        action.setCallback(this, function(a) 
        {
            var returnValue = a.getReturnValue();
            var state = a.getState();
            if(component.isValid() && state == "SUCCESS")
            {
                $A.get("e.force:closeQuickAction").fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({"title": "Success!","message": "User has been created."});
                toastEvent.fire();
				$A.get('e.force:refreshView').fire();
				component.set("v.firstName",'');
				component.set("v.lastName",'');
				component.set("v.email",'');
				component.set("v.userName",'');
				component.set("v.jobFunction",'');
				component.set("v.bdo",'');
				component.set("v.division",'');
				component.set("v.hasErrors",false);
				component.set("v.errors",'');
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