({
	init : function(component, event, helper) 
    {
		var bdoCookie = helper.getCookie(component,'dashboardAvgDaysOpenBDO');		
		if(bdoCookie == null)
		{
			component.find('bdo').set('v.value','All');
		}
		else
		{
			component.find('bdo').set('v.value',bdoCookie);
		}
		var bdo = component.find('bdo').get('v.value');
		helper.getData(component, bdo);
	},
	reloadStats: function (component, event, helper) 
	{
		console.log('reloadStats');
		var bdo = component.find('bdo').get('v.value');
		helper.getData(component, bdo);
		helper.setCookie("dashboardAvgDaysOpenBDO", bdo, 180);
	}
})