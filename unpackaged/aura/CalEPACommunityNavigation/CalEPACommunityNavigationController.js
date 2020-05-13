({
    onNavMenuItemsChange : function(component, event, helper) 
    {
        var items = component.get("v.menuItems");
        var calEPAMenuItems = new Array();
        items.forEach(function(element) 
        {
            if(element.label == 'Home')
            {
                var calEPAMenuItem = 
                {
                    id: element.id,
                    text: element.label,
                    icon: 'ca-gov-icon-home'
                };
				calEPAMenuItems.push(calEPAMenuItem);
            }
            else
            {
                var temp = element.label.split("|");
                var calEPAMenuItem = 
                {
                    id: element.id,
                    text: temp[0],
                    icon: temp[1]
    
                };
				calEPAMenuItems.push(calEPAMenuItem);
            }            
		});
        component.set("v.calEPAMenuItems", calEPAMenuItems);
	},
    onMenuItemClick : function(component, event, helper) 
    {
       var id = event.currentTarget.getAttribute('data-menu-item-id');
       //console.log(id);
       if (id) 
       {
           component.getSuper().navigate(id);
       }
  	}
})