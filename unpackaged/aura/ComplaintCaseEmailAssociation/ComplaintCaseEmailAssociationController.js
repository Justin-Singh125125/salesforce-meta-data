({
	associate: function(component, event, helper) 
	{   
        console.log('controller.associate');
		var recordId = component.get("v.recordId");
        console.log('recordId:  ' + recordId);
        var complaintId = component.get("v.selectedLookUpRecord.Id");
        console.log('complaintId:  ' + complaintId);
		helper.associate(component,recordId, complaintId);   
	},
    associateAndClose: function(component, event, helper) 
	{        
        console.log('controller.associateAndClose');
		var recordId = component.get("v.recordId");
        console.log('recordId:  ' + recordId);
        var complaintId = component.get("v.selectedLookUpRecord.Id");
        console.log('complaintId:  ' + complaintId);
		helper.associateAndClose(component,recordId, complaintId);           
	},
})