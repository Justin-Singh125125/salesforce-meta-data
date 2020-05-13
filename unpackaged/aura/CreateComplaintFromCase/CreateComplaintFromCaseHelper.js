({
	save: function (component,air,pesticides,solidWaste,toxicSubstances,water,firstName,lastName,email,phone,mobilePhone,street,city,zipCode,state,description) 
	{        
		var action = component.get("c.Save");
        action.setParams({air: air,pesticides: pesticides,solidWaste: solidWaste,toxicSubstances: toxicSubstances,water: water,firstName: firstName,lastName: lastName,email: email,phone: phone,mobilePhone: mobilePhone,street: street,city: city,zipCode: zipCode,state: state,description: description});
		action.setCallback(this, function (a) 
		{			
            var state = a.getState();
            if(state == "SUCCESS")
            {
				var id = a.getReturnValue();
                console.log(id);
                 var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                  "recordId": id,
                  "slideDevName": "Detail"
                });
                navEvt.fire();
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