({
	init : function(component, event, helper) 
	{
        var recordId = component.get("v.recordId");
        console.log(recordId);
		var action = component.get("c.GetDescription");
        action.setParams({ "caseId" : recordId });
		action.setCallback(this, function(response) 
		{
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var map = response.getReturnValue();
                console.log(map);
                component.set("v.description",map.Description);
				component.set("v.firstName",map.FirstName);
                component.set("v.lastName",map.LastName);
                component.set("v.email",map.Email);
                component.set("v.phone",map.Phone);
                component.set("v.mobilePhone",map.MobilePhone);                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
        });
		$A.enqueueAction(action);
	},
    clear: function(component, event, helper) 
	{
        component.set("v.air",false);
        component.set("v.pesticides",false);
        component.set("v.solidWaste",false);
        component.set("v.toxicSubstances",false);
        component.set("v.water",false);        
		component.set("v.firstName",'');
		component.set("v.lastName",'');
		component.set("v.email",'');
		component.set("v.phone",'');
		component.set("v.mobilePhone",'');
		component.set("v.description",'');		
        component.set("v.street",'');		
        component.set("v.city",'');		
        component.set("v.zipCode",'');		
        component.set("v.hasErrors",false);
		component.set("v.errors",'');
	},
	save: function(component, event, helper) 
	{        
        console.log('controller.save');
		var air = component.get("v.air");        
        var pesticides = component.get("v.pesticides");
        var solidWaste = component.get("v.solidWaste");
        var toxicSubstances = component.get("v.toxicSubstances");
        var water = component.get("v.water");        
		var firstName = component.get("v.firstName");
		var lastName = component.get("v.lastName");
		var email = component.get("v.email");
		var phone = component.get("v.phone");
		var mobilePhone = component.get("v.mobilePhone");
		var description = component.get("v.description");		
        var street = component.get("v.street");		
        var city = component.get("v.city");		
        var zipCode = component.get("v.zipCode");           	
        var state = component.get("v.state");        
        console.log('controller.save2');
		helper.save(component,air,pesticides,solidWaste,toxicSubstances,water,firstName,lastName,email,phone,mobilePhone,street,city,zipCode,state,description);   
	},
})