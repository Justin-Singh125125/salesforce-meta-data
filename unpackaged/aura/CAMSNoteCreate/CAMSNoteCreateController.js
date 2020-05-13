({
	openModel: function(component, event, helper) 
	{
		console.log('controller.openModal');
		component.set("v.isOpen", true);
	},
  
	closeModel: function(component, event, helper) 
	{
		console.log('controller.closeModal');
	   	component.set("v.isOpen", false);
	},
	save: function (component, event, helper) 
	{
		component.set("v.hasErrors",false);
		console.log('controller.save');
        helper.save(component);
    },
})