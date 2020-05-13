({
	getData : function(component,articleId) 
    {
		var getArticleAction = component.get("c.GetArticle");		
		getArticleAction.setParams({"articleId" : articleId});
		getArticleAction.setCallback(this, function(response) 
		{
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var article = response.getReturnValue();
                component.set("v.title", article.Title);
                component.set("v.body", article.Body__c);
                component.set("v.CreatedDate", article.CreatedDate);
                component.set("v.LastModifiedDate", article.LastModifiedDate);
                component.set("v.CreatedBy", article.CreatedBy.Name);
                component.set("v.LastModifiedBy", article.LastModifiedBy.Name);                
			}
			else
			{
				console.log(response);
			}
		});
		$A.enqueueAction(getArticleAction);        
	},
})