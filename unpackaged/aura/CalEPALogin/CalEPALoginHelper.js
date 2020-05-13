({
	helperMethod : function() 
    {
		
	},
    handleLogin: function (component,username,password) 
    {
        console.log('helper.handleLogin');
        var action = component.get("c.Login");
        action.setParams({username: username, password: password});
        
        // Add callback behavior for when response is received
        action.setCallback(this, function (response) 
		{
			var state = response.getState();
			var rtnValue = response.getReturnValue();
			if (rtnValue !== null) 
			{
				component.set("v.mylabel", rtnValue);
				//component.set("v.showError",true);
				component.set("v.Spinner", false);
			}
		});

        // Send action off to be executed
        $A.enqueueAction(action);
	},
})