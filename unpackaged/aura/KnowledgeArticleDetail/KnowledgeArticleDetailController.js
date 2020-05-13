({
	init : function(component, event, helper) 
    {
        var articleId = component.get("v.recordId")
		helper.getData(component, articleId);
	},
})