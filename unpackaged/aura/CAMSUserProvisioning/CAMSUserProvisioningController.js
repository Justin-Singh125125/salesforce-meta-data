({
	init : function(component, event, helper) 
	{
		var action = component.get("c.GetBDOs");
		action.setCallback(this, function(response) 
		{
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var options = response.getReturnValue();
				console.log (options);
				var picklistOptions = [];
				for (var i= 0; i < options.length ; i++)
				{
					picklistOptions[i] = { label: options[i], value: options[i]};
				}
				component.find("BDO").set("v.options", picklistOptions);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
        });
		$A.enqueueAction(action);
	},
	setDefaultUsername : function(component, event, helper) 
	{
		component.set("v.userName",component.get("v.email"));
	},
	bdoChange : function(component, event, helper) 
	{
		var bdo = component.get("v.bdo");
		var action = component.get("c.GetBDOSuborganizations");
		action.setParams({ "bdo" : bdo });
		action.setCallback(this, function(response) 
		{
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var options = response.getReturnValue();
				console.log (options);
				var picklistOptions = [];
				for (var i= 0; i < options.length ; i++)
				{
					picklistOptions[i] = { label: options[i], value: options[i]};
				}
				component.find("Division").set("v.options", picklistOptions);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
		});
		$A.enqueueAction(action);
	},
	clearForm: function(component, event, helper) 
	{
		component.set("v.firstName",'');
		component.set("v.lastName",'');
		component.set("v.email",'');
		component.set("v.userName",'');
		component.set("v.jobFunction",'');
		component.set("v.bdo",'');
		component.set("v.division",'');
		component.set("v.hasErrors",false);
		component.set("v.errors",'');
	},
	save: function(component, event, helper) 
	{
		var firstName = component.get("v.firstName")
	   	var lastName = component.get("v.lastName");
	   	var email = component.get("v.email");
	   	var userName = component.get("v.userName");
		var jobFunction = component.get("v.jobFunction");
		var bdo = component.get("v.bdo");
	   	var division = component.get("v.division");
		helper.save(component,firstName, lastName, email, userName, jobFunction, bdo, division);   
	},
})