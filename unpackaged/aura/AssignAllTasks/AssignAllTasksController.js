({
 doInit : function(component,event,helper){
     //alert(component.get("v.recordId"));
   var action = component.get('c.AssignTasks2');
     action.setParams({
            "aatParam" : component.get("v.recordId") 
        });
        action.setCallback(this, function(a){
            $A.get("e.force:closeQuickAction").fire();
            $A.get('e.force:refreshView').fire();
        });
     $A.enqueueAction(action);
    },
 })