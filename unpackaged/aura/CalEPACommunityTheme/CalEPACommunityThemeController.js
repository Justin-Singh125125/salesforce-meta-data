({
	afterScriptsLoaded : function(component, event, helper) 
    {
              
	},
    init : function(component, event, helper) 
	{
        var colorscheme = component.get("v.Colorscheme");
        //console.log(colorscheme);
        
		var fileref=document.createElement("link");
        fileref.setAttribute("rel", "stylesheet");
        fileref.setAttribute("type", "text/css");
        var stateTemplateV5Url = $A.get('$Resource.StateTemplateV5');
        switch(colorscheme) 
        {
  			case 'Eureka':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-eureka.css');
    			break;
  			case 'Mono':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-mono.css');
    			break;
  			case 'Oceanside':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-oceanside.css');
    			break;
  			case 'Orange County':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-orangecounty.css');
    			break;
  			case 'Paso Robles':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-pasorobles.css');
    			break;
  			case 'Santa Barbara':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-santabarbara.css');
    			break;
  			case 'Sacramento':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-sacramento.css');
    			break;
  			case 'Sierra':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-sierra.css');
    			break;                
  			case 'Trinity':
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-trinity.css');
    			break;                    
  			default:
    			fileref.setAttribute("href", stateTemplateV5Url + '/css/colorscheme-oceanside.css');
                break;
		}
        document.getElementsByTagName("head")[0].appendChild(fileref); 
    },
    
})