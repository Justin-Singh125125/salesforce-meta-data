({	
	getData : function(component,bdo) 
    {
		var maximumDaysOpenAction = component.get("c.GetMaximumDaysOpen");		
		maximumDaysOpenAction.setParams({"bdo" : bdo});
		maximumDaysOpenAction.setCallback(this, function(response) 
		{
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var maximumDaysOpen = response.getReturnValue();
				var averageDaysOpenAction = component.get("c.GetAverageDaysOpen");		
				averageDaysOpenAction.setParams({"bdo" : bdo});
				averageDaysOpenAction.setCallback(this, function(response) 
				{
					console.log('averageDaysOpenAction');
					if(component.isValid() && response.getState() === "SUCCESS") 
					{
						var averageDaysOpen = response.getReturnValue();
						var opts = {
							angle: -0.2, // The span of the gauge arc
							lineWidth: 0.2, // The line thickness
							radiusScale: 1, // Relative radius
							pointer: {
							length: 0.6, // // Relative to gauge radius
							strokeWidth: 0.035, // The thickness
							color: '#000000' // Fill color
							},
							limitMax: false,     // If false, max value increases automatically if value > maxValue
							limitMin: false,     // If true, the min value of the gauge will be fixed
							colorStart: '#6FADCF',   // Colors
							colorStop: '#8FC0DA',    // just experiment with them
							strokeColor: '#E0E0E0',  // to see which ones work best for you
							generateGradient: true,
							highDpiSupport: true,     // High resolution support
							staticZones: [
								{strokeStyle: "#30B32D", min: 0, max: 10}, // Green
								{strokeStyle: "#FFDD00", min: 11, max: 30}, // Yellow
								{strokeStyle: "#F03E3E", min: 31, max: 1000}  // Red
							],
							
						};
						var target = document.getElementById('foo'); // your canvas element
						var gauge = new Gauge(target).setOptions(opts); // create sexy gauge!
						gauge.maxValue = 1000; // set max gauge value
						gauge.setMinValue(0);  // Prefer setter over gauge.minValue = 0
						gauge.animationSpeed = 32; // set animation speed (32 is default value)
						gauge.setTextField(document.getElementById("preview-textfield"));
						gauge.set(averageDaysOpen); // set actual value
					}
					else if (response.getState() === "ERROR") {
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
				$A.enqueueAction(averageDaysOpenAction);
			}
			else
			{
				console.log(response);
			}
		});
		$A.enqueueAction(maximumDaysOpenAction);        
	},
	getCookie: function(component,name)
	{
		var name = name + "=";
  		var decodedCookie = decodeURIComponent(document.cookie);
  		var ca = decodedCookie.split(';');
		for(var i = 0; i <ca.length; i++) 
		{
    		var c = ca[i];
			while (c.charAt(0) == ' ') 
			{
      			c = c.substring(1);
    		}
			if (c.indexOf(name) == 0) 
			{
      			return c.substring(name.length, c.length);
    		}
  		}
  		return null;
	},
	setCookie:  function (cname, cvalue, exdays) 
	{
		var d = new Date();
		d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
		var expires = "expires="+d.toUTCString();
		document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
	}

})