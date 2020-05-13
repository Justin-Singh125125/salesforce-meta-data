({
	init : function(component, event, helper) 
	{
		console.log('CAMSUserByBDO init');
		var action = component.get("c.GetBDOUserCounts");
		action.setCallback(this, function(response) 
		{
			console.log('component.isValid():  ' + component.isValid());
			console.log('response.getState():  ' + response.getState());
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                var bdos = [];
                var conts = response.getReturnValue();
				for(var key in conts)
				{
                    bdos.push({value:conts[key], key:key});
				}
				console.log('bdos:  ' + bdos);
				component.set("v.bdos", bdos);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
        });
		$A.enqueueAction(action);
	},
})