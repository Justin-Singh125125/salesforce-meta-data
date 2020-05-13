({
	login: function (component, event, helper) 
    {
        component.set("v.Spinner", true);
        console.log('Controller.login');
        var username = component.get("v.Username");
		//console.log(username);
        var password = component.get("v.Password");
        //console.log(password);
		helper.handleLogin(component,username, password);
	},

	
    /*
	resetPass: function (cmp) 
    {
		cmp.set("v.mylabel1", "");
		cmp.set("v.isVisible", false);
	},
	cancelReset: function (cmp) 
    {
		cmp.set("v.mylabel", "");
		cmp.set("v.isVisible", true);
	},
	submitResetPass: function (component, event, helper) 
    {
		component.set("v.mylabel", "");
		var validResetForm1 = component.find("FormReset").get("v.validity");
		
        // If we pass error checking, do some real work
		if (validResetForm1.valid) 
        {
			var reuser1 = component.get("v.ResetUsername");
			var action = component.get("c.forgotPassowrd");
			action.setParams({username: reuser1});
			action.setCallback(this,function (a) 
			{
					var rtnValue = a.getReturnValue();
					console.log('<<my return value>>>>>' + 	rtnValue);
					
                	// component.set("v.mylabel1",'We’ve sent you an email with a link to finish resetting your password.');

					if (rtnValue !== null) 
                    {
						component.set("v.mylabel1", rtnValue);
						
                        // component.set("v.showError",true);
					}
			});
			$A.enqueueAction(action);
		}
	}
    */
})