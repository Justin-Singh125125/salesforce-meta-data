({
	openModel: function(component, event, helper) 
	{
		console.log('controller.openModal');
		component.set("v.isOpen", true);
	},
  
	closeModel: function(component, event, helper) 
	{
		console.log('controller.closeModal');
		component.set("v.Document.Title", null);
		component.set("v.Document.Description", null);
		component.set("v.FileName", null);
		component.set("v.isOpen", false);
		component.set("v.hasErrors", false);
		component.set("v.final", false);
		component.set("v.errors", '');		   
	},
	save: function (component, event, helper) 
	{
		component.set("v.uploading", true);
		component.set("v.hasErrors",false);
		console.log('controller.save');
        helper.save(component);
    },
 })