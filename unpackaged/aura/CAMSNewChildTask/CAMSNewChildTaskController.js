({    
	init : function(component, event, helper) 
	{
		var parentTaskId = component.get("v.recordId")
		var getParentDueDateAction = component.get("c.GetParentDueDate");
		getParentDueDateAction.setParams({ "parentTaskId" : parentTaskId });
		getParentDueDateAction.setCallback(this, function(response) 
		{
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var dateString = response.getReturnValue();
				var dateArray = dateString.split("-");
				var parentDueDate = new Date(dateArray[0], dateArray[1]-1, dateArray[2],0,0,0);
				var dueDate = new Date();
				var numberOfDaysToAdd = 3;
				dueDate.setDate(dueDate.getDate() + numberOfDaysToAdd); 				
				if(dueDate > parentDueDate)
				{
					var dd = parentDueDate.getDate();
					var mm = parentDueDate.getMonth() + 1;
					var y = parentDueDate.getFullYear();
					var formattedParentDueDate = mm + '/'+ dd + '/'+ y;
					component.find("DueDate").set("v.value",formattedParentDueDate);
				}
				else
				{
					var dd = dueDate.getDate();
					var mm = dueDate.getMonth() + 1;
					var y = dueDate.getFullYear();
					var formattedDueDate = mm + '/'+ dd + '/'+ y;
					component.find("DueDate").set("v.value", formattedDueDate);
				}
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
        });
		$A.enqueueAction(getParentDueDateAction);
		var action = component.get("c.GetBDOs");
		action.setParams({ "parentTaskId" : parentTaskId });
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
		
		var statusAction = component.get("c.GetStatuses");
		statusAction.setCallback(this, function(response) 
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
				component.find("Status").set("v.options", picklistOptions);
				component.find("Status").set("v.value",'Delegated');
			}
			else 
			{
				console.log('There was a problem and the state is: '+ state);
			}
        });
        $A.enqueueAction(statusAction);
	},
	updateBDOSuborganization: function (component) 
	{
		var bdo = component.get("v.Task.BDO__c");
		if(bdo != '')
		{
			var action2 = component.get("c.GetBDOSuborganizations");
			action2.setParams({ "bdo" : bdo });
			action2.setCallback(this, function(response) {
				if(component.isValid() && response.getState() === "SUCCESS") {
					var options = response.getReturnValue();
					console.log (options);
					var picklistOptions = [];
					for (var i= 0; i < options.length ; i++)
					{
						picklistOptions[i] = { label: options[i], value: options[i]};
					}
					component.find("Suborganization").set("v.options", picklistOptions);
				}
			});
			$A.enqueueAction(action2);
		}
	},
	updateAssignedTo: function (component) 
	{
		var bdo = component.get("v.Task.BDO__c");		
		var suborganization = component.get("v.Task.BDO_Suborganization__c");
		if(bdo != '' && suborganization != '')
		{
			var action3 = component.get("c.GetQueueUsers");
			action3.setParams({ "bdo" : bdo, "suborganization" : suborganization });
			action3.setCallback(this, function(response) {
				if(component.isValid() && response.getState() === "SUCCESS") {
					var options = response.getReturnValue();
					console.log (options);
					var picklistOptions = [];
					for (var i= 0; i < options.length ; i++)
					{
						picklistOptions[i] = { label: options[i].Name, value: options[i].Id};
					}
					component.find("AssignedTo").set("v.options", picklistOptions);
				}
			});
			$A.enqueueAction(action3);
		}
	},	
	save: function(component, event, helper) 
	{
		var parentTaskId = component.get("v.recordId")
	   	var bdo = component.get("v.Task.BDO__c");
	   	var suborganization = component.get("v.Task.BDO_Suborganization__c");
	   	var assignedTo = component.get("v.Task.Assigned_To__c");
		var dueDateString = component.get("v.Task.Due_Date__c");
		var dueDateTemp = new Date(dueDateString);
		var dd = dueDateTemp.getDate();
		var mm = dueDateTemp.getMonth() + 1;
		var y = dueDateTemp.getFullYear();
		var dueDate = mm + '/'+ dd + '/'+ y;
		var status = component.get("v.Task.Status__c");
		var instructions = component.get("v.Task.Instructions__c");
		console.log(typeof dueDate);
		helper.save(component,parentTaskId, bdo, suborganization, assignedTo, dueDate, status, instructions);         
	},
	cancel : function(component, event, helper) 
	{
	   $A.get("e.force:closeQuickAction").fire();
	}
})