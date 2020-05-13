({
	save: function(component, event, helper) 
	{
        console.log('Controller.Save');
		var subject = component.get("v.subject")
	   	var description = component.get("v.description");
		helper.save(component,subject, description);   
	},
})