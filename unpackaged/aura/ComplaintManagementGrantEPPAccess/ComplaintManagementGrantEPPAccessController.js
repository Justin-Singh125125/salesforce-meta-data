({
	grantAccess: function(component, event, helper) 
	{        
        console.log('controller.grantAccess');
		var recordId = component.get("v.recordId");
        console.log('recordId:  ' + recordId);
        var accountId = component.get("v.selectedLookUpRecord.Id");
        console.log('accountId:  ' + accountId);
		helper.grantAccess(component,recordId, accountId);   
	},
})