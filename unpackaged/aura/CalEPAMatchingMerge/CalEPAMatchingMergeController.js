({
	init : function(component, event, helper) 
	{
        console.log('controller.init');
        helper.GetRecord(component);    
	},
    merge: function(component, event, helper) 
	{
        
		var destinationId = component.get("v.destinationId")
        var record1Id = component.get("v.record1Id")
        var record2Id = component.get("v.record2Id")
        var sourceId = '';
        if(destinationId == record1Id)
        {
            sourceId=record2Id;
        }
        else
        {
            sourceId=record1Id;
        }        
		helper.merge(component,sourceId,destinationId);         
	},
	cancel : function(component, event, helper) 
	{
	   $A.get("e.force:closeQuickAction").fire();
	}
})