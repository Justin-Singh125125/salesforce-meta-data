({
	getDataCategories : function(component,parentCategory) 
    {
		var getParentCategoriesAction = component.get("c.GetChildCategories");		
		getParentCategoriesAction.setParams({"parentCategory" : parentCategory});
		getParentCategoriesAction.setCallback(this, function(response) 
		{
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                var cats = [];
                var ret = response.getReturnValue();
				for(var key in ret)
                {
                    var arts = [];
                    for(var key2 in ret[key])
                	{
                       arts.push({value:ret[key][key2], key:key2});
                    }
                    cats.push({value:arts, key:key});
                }
                console.log(cats);
                component.set("v.parentCategories", cats);
			}
			else if (response.getState() === "ERROR") 
            {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
		});
		$A.enqueueAction(getParentCategoriesAction);        
	},
})