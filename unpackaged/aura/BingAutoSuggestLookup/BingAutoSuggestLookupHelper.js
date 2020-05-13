({
	searchHelper : function(component,event,getInputkeyWord) 
    {
       	//console.log('LightningLookupHelper.SearchHelper1');
		// call the apex class method 
     	var action = component.get("c.FetchLookUpValues");
      	// set param to method  
        action.setParams
        (
            {
            	'searchKeyWord': getInputkeyWord,
        	}
        );
      	// set a callBack    
        action.setCallback(this, function(response) 
        {
            //console.log('LightningLookupHelper.SearchHelperCallback1');
        	$A.util.removeClass(component.find("mySpinner"), "slds-show");
            var state = response.getState();
            //console.log('state:  ' + state);
            if (state === "SUCCESS") 
            {
                var storeResponse = response.getReturnValue();                
				for (var i = 0; i < storeResponse.length; i++) 
                {
    				//console.log(storeResponse[i].FormattedAddress);//[i]
    				//Do something
				}
                
              	// if storeResponse size is equal 0 ,display No Result Found... message on screen.                }
                if (storeResponse.length == 0) 
                {
                    component.set("v.Message", 'No Result Found...');
                } 
                else 
                {
                    component.set("v.Message", '');
                }
                // set searchResult list with return value from server.
                component.set("v.listOfSearchRecords", storeResponse);
            }
            else
            {
                //console.log('LightningLookupHelper.SearchHelperCallback2.0');
                if (state === "ERROR") 
                {
                    //console.log('LightningLookupHelper.SearchHelperCallback2.1');                    
                    var errors = response.getError();
                    console.log(errors);                
                    if (errors) {
                        if (errors[0] && errors[0].message) 
                        {
                            component.set("v.hasErrors",true);
                            component.set("v.errors",errors[0].message);
                            console.log("Error message: " + errors);
                        }
                    } 
                    else
                    {
                        component.set("v.hasErrors",true);
                        component.set("v.errors","Unknown error");
                        console.log("Unknown error");
                    }
                }
        	}
     	});
      	// enqueue the Action  
        $A.enqueueAction(action);
	},
})