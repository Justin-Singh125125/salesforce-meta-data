({
    afterScriptsLoaded : function(component, event, helper) 
    {
        //Comment
        var d = new Date();
        //var n = d.getFullYear();
        //component.set("v.thisYearChartSubTitle", n);
        helper.doInit(component,event,helper);
    }    
    
})