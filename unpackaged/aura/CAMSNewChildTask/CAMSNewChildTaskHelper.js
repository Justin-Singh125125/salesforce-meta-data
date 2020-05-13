({
    save: function(component, parentTaskId, bdo, suborganization, assignedTo, dueDate, status, instructions ) 
    {
        //Save and close the panel
        var action = component.get("c.SaveChildTask");
        console.log(dueDate);
        action.setParams({"parentTaskId": parentTaskId, "bdo": bdo, "suborganization": suborganization, "assignedTo": assignedTo, "dueDate": dueDate, "status": status, "instructions": instructions});
        action.setCallback(this, function(a) 
        {
            var returnValue = a.getReturnValue();
            var state = a.getState();
            if(component.isValid() && state == "SUCCESS")
            {
                $A.get("e.force:closeQuickAction").fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({"title": "Success!","message": "The child task has been created."});
                toastEvent.fire();
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