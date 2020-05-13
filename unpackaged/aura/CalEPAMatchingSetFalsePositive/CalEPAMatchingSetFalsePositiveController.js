({
 doInit : function(component,event,helper){
   	var action = component.get('c.SetFalsePositive');
     action.setParams({"recordId" : component.get("v.recordId")});
        action.setCallback(this, function(a)
		{
            //
            var eUrl= $A.get("e.force:navigateToURL");
            eUrl.setParams({"url": '/one/one.app?source=aloha#/sObject/CalEPA_Matching__c/home'});
            eUrl.fire();
        });
     $A.enqueueAction(action);
    },
 })