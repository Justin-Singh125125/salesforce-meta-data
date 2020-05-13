({
	afterRender : function(component, event, helper) 
	{
        var stateTemplateV5Url = $A.get('$Resource.StateTemplateV5');
        var fileref=document.createElement('script');
        fileref.setAttribute("type","text/javascript");
        fileref.setAttribute("src", stateTemplateV5Url + '/js/cagov.core.js');
        document.getElementsByTagName("body")[0].appendChild(fileref);
        this.superAfterRender(); 
    }
})