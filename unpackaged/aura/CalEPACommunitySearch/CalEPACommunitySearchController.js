({
	gotoURL : function (component, event, helper) 
    {
    	var searchString = document.getElementById("searchTerm").value;
    	//if(event.which == 13)
        //{
        	var urlEvent = $A.get("e.force:navigateToURL");
        	urlEvent.setParams({ "url": "/global-search/" + searchString });
        	urlEvent.fire();
    	//}
    }
})