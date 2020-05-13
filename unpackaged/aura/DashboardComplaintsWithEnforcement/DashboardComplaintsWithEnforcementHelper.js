({
	fetchData: function (component, numberOfRecords) 
	{
		var action = component.get("c.GetComplaintsWithEnforcementAction"); 
        action.setCallback(this, function(response) { 
            var state = response.getState(); 
            if (state === "SUCCESS") { 
				var dataObj= response.getReturnValue(); 
				console.log(dataObj);
				var obj = JSON.parse(dataObj);
				console.log(obj);
				component.set('v.data', obj);
            } 
            else
            {
                console.log(state);
            } 
        });
		$A.enqueueAction(action);
    }
})