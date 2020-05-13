({
    doInit : function(component, event, helper)
    {
    	var action = component.get('c.isAuthenticated');
    	action.setCallback(this,function(result)
		{
        	component.set('v.isAuthenticated',result.getReturnValue());
         	//console.log(result.getReturnValue());
    	});
      	$A.enqueueAction(action);
    },
    handleClick : function(component, event, helper) 
    {
        var userId = $A.get("$SObjectType.CurrentUser.Id");
        var source = event.currentTarget.getAttribute('data-link-name');
        var address = '';
        switch(source) 
        {
  			case 'Home':
    			address='/';
    			break;
  			case 'My Profile':
    			address='/profile/' + userId;
    			break;
  			case 'My Messages':
    			address='/messages/' + userId;
    			break;
  			case 'Settings':
    			address='/settings/' + userId;
    			break;
  			case 'LogOut':
    			window.location.href='../../secure/logout.jsp?retUrl=http://google.com'
                return;
  			default:
    			address='/profile/' + userId;
                break;
		}
        var urlEvent = $A.get("e.force:navigateToURL");
    	urlEvent.setParams({"url": address });
    	urlEvent.fire();
    }
})