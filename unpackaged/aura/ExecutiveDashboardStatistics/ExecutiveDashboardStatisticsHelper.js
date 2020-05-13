({
	loadBDO : function(component)
	{
		var bdoCookie = this.getCookie(component,'executiveDashboardStatisticesBDO');
		if(bdoCookie == null)
		{
			component.find('bdo').set('v.value','All');
		}
		else
		{
			component.find('bdo').set('v.value',bdoCookie);
		}
		var bdo = component.find('bdo').get('v.value');		
		if(!window.location.href.includes("calepa.lightning.force.com"))
		{
			component.set("v.isTestEnvironment",true);
		}
	},
	loadYear : function(component)
	{
		var yearOpts = [];
		var currentYear = parseInt(new Date().getFullYear(), 10);
		for (var i = 2016; i <= currentYear; i++) 
		{ 
			yearOpts.push({ value: i.toString(), label: i.toString() });
		}
        component.set("v.years", yearOpts);
		var yearCookie = this.getCookie(component,'executiveDashboardStatisticsYear');
		if(yearCookie == null)
		{
			component.find('year').set('v.value','All Time');
		}
		else
		{
			component.find('year').set('v.value',yearCookie);
		}	
	},
	loadQuarter : function(component)
	{		
		var currentYear = parseInt(new Date().getFullYear(), 10);
		var quarterOpts = [];
		if(component.get("v.selectedYear") == "All Time")
		{
			//Leave Blank
		}
		else 
		{
			if(component.get("v.selectedYear") == "2016")
			{
				quarterOpts.push({ value: "Q2", label: "Q2" });
				quarterOpts.push({ value: "Q3", label: "Q3" });
				quarterOpts.push({ value: "Q4", label: "Q4" });
			}
			else 
			{
				if(component.get("v.selectedYear") == currentYear)
				{
					var d = new Date();
					var currentMonth = d.getMonth();
					//console.log(currentMonth);
					quarterOpts.push({ value: "Q1", label: "Q1" });
					if(currentMonth >= 5)
					{
						quarterOpts.push({ value: "Q2", label: "Q2" });
					}
					if(currentMonth >= 8)
					{
						quarterOpts.push({ value: "Q3", label: "Q3" });
					}
				}
				else
				{
					quarterOpts.push({ value: "Q1", label: "Q1" });
					quarterOpts.push({ value: "Q2", label: "Q2" });
					quarterOpts.push({ value: "Q3", label: "Q3" });
					quarterOpts.push({ value: "Q4", label: "Q4" });
				}
			}						
		}
		component.set("v.quarters", quarterOpts);
		var quarterCookie = this.getCookie(component,'executiveDashboardStatisticsQuarter');
		if(quarterCookie == null)
		{
			component.find('quarter').set('v.value','');
		}
		else
		{
			component.find('quarter').set('v.value',quarterCookie);
		}	
		component.find('quarter').set('v.value','');
	},
	loadDashboard: function (component, event) 
    {
		var bdo = component.find('bdo').get('v.value');
		this.setCookie("executiveDashboardStatisticesBDO", bdo, 180);		
		var year = component.find('year').get('v.value');				
		this.setCookie("executiveDashboardStatisticsYear", year, 180);
		var quarter = component.find('quarter').get('v.value');				
		this.setCookie("executiveDashboardStatisticsQuarter", quarter, 180);
		var beginDate = this.getBeginDate(year,quarter);
		var endDate = this.getEndDate(year,quarter);
		var previousBeginDate = this.getPreviousBeginDate(year,quarter);
		var previousEndDate = this.getPreviousEndDate(year,quarter);
		if(year=='All Time' || (year==2016 && (quarter=='' || quarter=='Q2')))
		{
			component.set("v.showPreviousPeriod", false);
		}
		else
		{
			component.set("v.showPreviousPeriod", true);
		}
		this.getTotalComplaints(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate);
		this.getWithEnforcementAction(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate);
        this.getReferred(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate);
		this.getCalEPAOpen(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate);
		this.getCalEPAClosed(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate);

		this.getAverageDaysOpen(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate);
		this.getAverageDaysToClose(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate);
		
		this.loadTitle(component, bdo, year, quarter, beginDate, endDate);
	},
	getTotalComplaints : function(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate) 
	{
        component.set("v.totalComplaintsThisPeriodLoaded", false);
		var totalComplaintsThisPeriodAction = component.get("c.GetTotalComplaints");		
		totalComplaintsThisPeriodAction.setParams({"bdo" : bdo, "beginDate" : beginDate, "endDate" : endDate});
		totalComplaintsThisPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var totalComplaintsThisPeriodCount = response.getReturnValue();
                component.set("v.totalComplaintsThisPeriod", totalComplaintsThisPeriodCount);
                component.set("v.totalComplaintsThisPeriodLoaded", true);
			}
			else 
			{
				//console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsThisPeriodAction);

        component.set("v.totalComplaintsPreviousPeriodLoaded", false);
		var totalComplaintsPreviousPeriodAction = component.get("c.GetTotalComplaints");		
		totalComplaintsPreviousPeriodAction.setParams({"bdo" : bdo, "beginDate" : previousBeginDate, "endDate" : previousEndDate});
		totalComplaintsPreviousPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var totalComplaintsPreviousPeriodCount = response.getReturnValue();
                component.set("v.totalComplaintsPreviousPeriod", totalComplaintsPreviousPeriodCount);
                component.set("v.totalComplaintsPreviousPeriodLoaded", true);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsPreviousPeriodAction);
	},
	getWithEnforcementAction : function(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate) 
	{
        component.set("v.totalEnforcementActionsThisPeriodLoaded", false);
		var totalEnforcementActionsThisPeriodAction = component.get("c.GetTotalEnforcementActions");		
		totalEnforcementActionsThisPeriodAction.setParams({"bdo" : bdo, "beginDate" : beginDate, "endDate" : endDate});
		totalEnforcementActionsThisPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var totalEnforcementActionsThisPeriodCount = response.getReturnValue();
                component.set("v.totalEnforcementActionsThisPeriod", totalEnforcementActionsThisPeriodCount);
                component.set("v.totalEnforcementActionsThisPeriodLoaded", true);
			}
			else 
			{
				//console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalEnforcementActionsThisPeriodAction);
		
        component.set("v.totalEnforcementActionsPreviousPeriodLoaded", false);
		var totalEnforcementActionsPreviousPeriodAction = component.get("c.GetTotalEnforcementActions");		
		totalEnforcementActionsPreviousPeriodAction.setParams({"bdo" : bdo, "beginDate" : previousBeginDate, "endDate" : previousEndDate});
		totalEnforcementActionsPreviousPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var totalEnforcementActionsPreviousPeriodCount = response.getReturnValue();
                component.set("v.totalEnforcementActionsPreviousPeriod", totalEnforcementActionsPreviousPeriodCount);
                component.set("v.totalEnforcementActionsPreviousPeriodLoaded", true);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalEnforcementActionsPreviousPeriodAction);
	},
    getReferred : function(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate) 
	{
        component.set("v.totalReferredThisPeriodLoaded", false);
		var totalComplaintsThisPeriodAction = component.get("c.GetReferredComplaints");		
		totalComplaintsThisPeriodAction.setParams({"bdo" : bdo, "beginDate" : beginDate, "endDate" : endDate});
		totalComplaintsThisPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var totalComplaintsThisPeriodCount = response.getReturnValue();
                component.set("v.totalReferredThisPeriod", totalComplaintsThisPeriodCount);
                component.set("v.totalReferredThisPeriodLoaded", true);
			}
			else 
			{
				//console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsThisPeriodAction);

        component.set("v.totalReferredPreviousPeriodLoaded", false);
		var totalComplaintsPreviousPeriodAction = component.get("c.GetReferredComplaints");		
		totalComplaintsPreviousPeriodAction.setParams({"bdo" : bdo, "beginDate" : previousBeginDate, "endDate" : previousEndDate});
		totalComplaintsPreviousPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var totalComplaintsPreviousPeriodCount = response.getReturnValue();
                component.set("v.totalReferredPreviousPeriod", totalComplaintsPreviousPeriodCount);
                component.set("v.totalReferredPreviousPeriodLoaded", true);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsPreviousPeriodAction);
	},
	getCalEPAOpen : function(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate) 
	{
        component.set("v.calEPAHandledOpenComplaintsThisPeriodLoaded", false);
		var totalComplaintsThisPeriodAction = component.get("c.GetCalEPAOpenComplaints");		
		totalComplaintsThisPeriodAction.setParams({"bdo" : bdo, "beginDate" : beginDate, "endDate" : endDate});
		totalComplaintsThisPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.calEPAHandledOpenComplaintsThisPeriod", complaintCount);
                component.set("v.calEPAHandledOpenComplaintsThisPeriodLoaded", true);
			}
			else 
			{
				//console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsThisPeriodAction);

        component.set("v.calEPAHandledOpenComplaintsPreviousPeriodLoaded", false);
		var totalComplaintsPreviousPeriodAction = component.get("c.GetCalEPAOpenComplaints");		
		totalComplaintsPreviousPeriodAction.setParams({"bdo" : bdo, "beginDate" : previousBeginDate, "endDate" : previousEndDate});
		totalComplaintsPreviousPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.calEPAHandledOpenComplaintsPreviousPeriod", complaintCount);
                component.set("v.calEPAHandledOpenComplaintsPreviousPeriodLoaded", true);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsPreviousPeriodAction);
	},
	getCalEPAClosed : function(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate) 
	{
        component.set("v.calEPAHandledClosedComplaintsThisPeriodLoaded", false);
		var totalComplaintsThisPeriodAction = component.get("c.GetCalEPAClosedComplaints");		
		totalComplaintsThisPeriodAction.setParams({"bdo" : bdo, "beginDate" : beginDate, "endDate" : endDate});
		totalComplaintsThisPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.calEPAHandledClosedComplaintsThisPeriod", complaintCount);
                component.set("v.calEPAHandledClosedComplaintsThisPeriodLoaded", true);
			}
			else 
			{
				//console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsThisPeriodAction);

        component.set("v.calEPAHandledClosedComplaintsPreviousPeriodLoaded", false);
		var totalComplaintsPreviousPeriodAction = component.get("c.GetCalEPAClosedComplaints");		
		totalComplaintsPreviousPeriodAction.setParams({"bdo" : bdo, "beginDate" : previousBeginDate, "endDate" : previousEndDate});
		totalComplaintsPreviousPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.calEPAHandledClosedComplaintsPreviousPeriod", complaintCount);
                component.set("v.calEPAHandledClosedComplaintsPreviousPeriodLoaded", true);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsPreviousPeriodAction);
	},
	getAverageDaysOpen : function(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate) 
	{		
        component.set("v.averageDaysOpenThisPeriodLoaded", false);
		var totalComplaintsThisPeriodAction = component.get("c.GetAverageDaysOpen");		
		totalComplaintsThisPeriodAction.setParams({"bdo" : bdo, "beginDate" : beginDate, "endDate" : endDate});
		totalComplaintsThisPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.averageDaysOpenThisPeriod", complaintCount);
                component.set("v.averageDaysOpenThisPeriodLoaded", true);
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
                component.set("v.averageDaysOpenThisPeriod", -1);
                component.set("v.averageDaysOpenThisPeriodLoaded", true);
			}
        });
		$A.enqueueAction(totalComplaintsThisPeriodAction);

        component.set("v.averageDaysOpenPreviousPeriodLoaded", false);
		var totalComplaintsPreviousPeriodAction = component.get("c.GetAverageDaysOpen");		
		totalComplaintsPreviousPeriodAction.setParams({"bdo" : bdo, "beginDate" : previousBeginDate, "endDate" : previousEndDate});
		totalComplaintsPreviousPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.averageDaysOpenPreviousPeriod", complaintCount);
                component.set("v.averageDaysOpenPreviousPeriodLoaded", true);
			}
			else 
			{
                component.set("v.averageDaysOpenPreviousPeriod", -1);
                component.set("v.averageDaysOpenPreviousPeriodLoaded", true);
				console.log('There was a problem and the state is: '+ response.getState());
				console.log(response.getError());
			}
        });
		$A.enqueueAction(totalComplaintsPreviousPeriodAction);
	},
	getAverageDaysToClose : function(component, bdo, beginDate,endDate,previousBeginDate,previousEndDate) 
	{
		console.log('bdo:  ' + bdo);
		console.log('beginDate:  ' + beginDate);
		console.log('endDate:  ' + endDate);
        component.set("v.averageDaysToCloseThisPeriodLoaded", false);
		var totalComplaintsThisPeriodAction = component.get("c.GetAverageDaysToClose");		
		totalComplaintsThisPeriodAction.setParams({"bdo" : bdo, "beginDate" : beginDate, "endDate" : endDate});
		totalComplaintsThisPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.averageDaysToCloseThisPeriod", complaintCount);
                component.set("v.averageDaysToCloseThisPeriodLoaded", true);
			}
			else 
			{
                component.set("v.averageDaysToCloseThisPeriod", -1);
                component.set("v.averageDaysToCloseThisPeriodLoaded", true);
				console.log('There was a problem and the state is: '+ response.getState());
				console.log(response.getError());
			}
        });
		$A.enqueueAction(totalComplaintsThisPeriodAction);

        component.set("v.averageDaysToClosePreviousPeriodLoaded", false);
		var totalComplaintsPreviousPeriodAction = component.get("c.GetAverageDaysToClose");		
		totalComplaintsPreviousPeriodAction.setParams({"bdo" : bdo, "beginDate" : previousBeginDate, "endDate" : previousEndDate});
		totalComplaintsPreviousPeriodAction.setCallback(this, function(response) 
		{
        	if(component.isValid() && response.getState() === "SUCCESS") 
			{
				var complaintCount = response.getReturnValue();
                component.set("v.averageDaysToClosePreviousPeriod", complaintCount);
                component.set("v.averageDaysToClosePreviousPeriodLoaded", true);
			}
			else 
			{
                component.set("v.averageDaysToClosePreviousPeriod", -1);
                component.set("v.averageDaysToClosePreviousPeriodLoaded", true);
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
		$A.enqueueAction(totalComplaintsPreviousPeriodAction);
	},
	loadTitle: function(component, bdo, year, quarter, beginDate, endDate)
	{
		var title1 = '';
		var title2 = '';
		switch(bdo) 
		{
			case 'All':
				title1 = 'All BDOs';
				title2 = 'All BDOs';
			  	break;
			case 'Air':
				title1 = 'ARB';
				title2 = 'ARB';
				break;
			case 'Solid Waste':
				title1 = 'CalRecycle';
				title2 = 'CalRecycle';
				break;				  
			case 'Pesticides':
				title1 = 'DPR';
				title2 = 'DPR';
				break;
			case 'Toxic Substances':
				title1 = 'DTSC';
				title2 = 'DTSC';
				break;
			case 'Water':
				title1 = 'SWRCB';
				title2 = 'SWRCB';
				break;																		
			case 'Multi-BDO':
				title1 = 'Cross-BDO';
				title2 = 'Cross-BDO';
				break;					
		}
		if(year=='All Time')
		{
			title1 = title1 + ' All Time (';
			title1 = title1 + beginDate.toLocaleDateString("en-US") + ' to ' + endDate.toLocaleDateString("en-US") + ')';			
			component.set("v.title1", title1);
			title2='';
			component.set("v.title2", title2);
		}
		else
		{
			if(quarter=='')
			{
				title1 = title1 + ' for the Year ';
				title1 = title1 + year;
				component.set("v.title1", title1);
				title2 = title2 + ' for the Year ';
				title2 = title2 + (parseInt(year, 10) - 1).toString();
				component.set("v.title2", title2);
			}
			else
			{
				title1 = title1 + ' for the Quarter ';
				title1 = title1 + year;
				title1 = title1 + ' ' + quarter;
				component.set("v.title1", title1);
				if(quarter=='Q1')
				{
					title2 = title2 + ' for the Quarter ';
					title2 = title2 + (parseInt(year, 10) - 1).toString();
					title2 = title2 + ' Q4';
				}
				else
				{
					if(quarter=='Q2')
					{
						title2 = title2 + ' for the Quarter ';
						title2 = title2 + year;
						title2 = title2 + ' Q1';
					}
					else
					{
						if(quarter=='Q3')
						{
							title2 = title2 + ' for the Quarter ';
							title2 = title2 + year;
							title2 = title2 + ' Q2';
						}
						else
						{
							title2 = title2 + ' for the Quarter ';
							title2 = title2 + year;
							title2 = title2 + ' Q3';
						}
					}
				}
				component.set("v.title2", title2);
			}
		}
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
	},        
    getBeginDate  : function(year, quarter)
    {
        var month;
        var day;
    	if(year=='All Time')
        {
        	return new Date(2016, 3, 1, 0, 0, 0);
        }
        if(quarter=='')
        {
           	month=0;
            day=1;
        }
        else
        {
            if(quarter=='Q1')        
            {
                month = 0;
                day = 1;
            }
            if(quarter=='Q2')        
            {
                month = 3;
                day = 1;
            }
            if(quarter=='Q3')        
            {
                month = 6;
                day = 1;
            }
            if(quarter=='Q4')        
            {
                month = 9;
                day = 1;
            }
        }
        //console.log('begin year:  ' + year);
        //console.log('begin month:  ' + month);
        //console.log('begin day:  ' + day);
        return new Date(year, month, day, 0, 0, 0);
	},        
    getEndDate  : function(year, quarter)
    {
        var month;
        var day;
        if(year=='All Time')
        {
        	return new Date();
        }
       	if(quarter=='')
        {
           	month=11;
            day=31;
        }
        else
        {
            if(quarter=='Q1')        
            {
                month = 2;
                day = 31;
            }
            if(quarter=='Q2')        
            {
                month = 5;
                day = 30;
            }
            if(quarter=='Q3')        
            {
                month = 8;
                day = 30;
            }
            if(quarter=='Q4')        
            {
                month = 11;
                day = 31;
            }
        }
        //console.log('end year:  ' + year);
        //console.log('end month:  ' + month);
        //console.log('end day:  ' + day);
        return new Date(year, month, day, 23, 59, 59);
	},
	getPreviousBeginDate  : function(year, quarter)
    {
        var month;
		var day;
    	if(year=='All Time')
        {
        	return new Date();
        }
        if(quarter=='')
        {
           	month=0;
			day=1;
			year = parseInt(year, 10) - 1;
        }
        else
        {
            if(quarter=='Q1')        
            {
                month = 9;
				day = 1;
				year = (parseInt(year, 10) - 1).toString();
            }
            if(quarter=='Q2')        
            {
                month = 0;
				day = 1;
            }
            if(quarter=='Q3')        
            {
                month = 3;
                day = 1;
            }
            if(quarter=='Q4')        
            {
                month = 6;
                day = 1;
            }
        }
        //console.log('begin year:  ' + year);
        //console.log('begin month:  ' + month);
        //console.log('begin day:  ' + day);
        return new Date(year, month, day, 0, 0, 0);
	},        
    getPreviousEndDate  : function(year, quarter)
    {
        var month;
        var day;
        if(year=='All Time')
        {
        	return new Date();
        }
       	if(quarter=='')
        {
           	month=11;
			day=31;
			year = (parseInt(year, 10) - 1).toString();
        }
        else
        {
            if(quarter=='Q1')        
            {
                month = 11;
				day = 31;
				year = (parseInt(year, 10) - 1).toString();
            }
            if(quarter=='Q2')        
            {
                month = 2;
                day = 31;
            }
            if(quarter=='Q3')        
            {
                month = 5;
                day = 30;
            }
            if(quarter=='Q4')        
            {
                month = 8;
                day = 30;
            }
        }
        //console.log('end year:  ' + year);
        //console.log('end month:  ' + month);
        //console.log('end day:  ' + day);
        return new Date(year, month, day, 23, 59, 59);
	},
	loadNewComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getBeginDate(year,quarter);
		var endDate = this.getEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetNewComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },
    loadComplaintsWithViolationsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getBeginDate(year,quarter);
		var endDate = this.getEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetComplaintsWithViolationsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },
    loadReferredComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getBeginDate(year,quarter);
		var endDate = this.getEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetReferredComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },    
    loadCalEPAHandledOpenComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getBeginDate(year,quarter);
		var endDate = this.getEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetCalEPAHandledOpenComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },    
    loadCalEPAHandledClosedComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getBeginDate(year,quarter);
		var endDate = this.getEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetCalEPAHandledClosedComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },    
    loadPreviousNewComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getPreviousBeginDate(year,quarter);
		var endDate = this.getPreviousEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetNewComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },
    loadPreviousComplaintsWithViolationsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getPreviousBeginDate(year,quarter);
		var endDate = this.getPreviousEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetComplaintsWithViolationsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },
    loadPreviousReferredComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getPreviousBeginDate(year,quarter);
		var endDate = this.getPreviousEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetReferredComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },    
    loadPreviousCalEPAHandledOpenComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getPreviousBeginDate(year,quarter);
		var endDate = this.getPreviousEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetCalEPAHandledOpenComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },    
    loadPreviousCalEPAHandledClosedComplaintsReport : function(component)
    {
        console.log('A');
        var bdo = component.find('bdo').get('v.value');
        if(bdo=='All')
        {
            bdo='Air,Pesticides,Solid Waste,Pesticides,Toxic Substances,Water,Multi-BDO';
        }
        console.log('B');
		var year = component.find('year').get('v.value');				
		var quarter = component.find('quarter').get('v.value');				
		var beginDate = this.getPreviousBeginDate(year,quarter);
		var endDate = this.getPreviousEndDate(year,quarter);
        console.log('C');
        var getHomePageReportUrlAction = component.get("c.GetCalEPAHandledClosedComplaintsReportUrl");		
        console.log('D');
        getHomePageReportUrlAction.setParams({"bdo" : bdo, "startDate" : beginDate, "endDate": endDate});
        console.log('E');
		getHomePageReportUrlAction.setCallback(this, function(response) 
		{
            console.log('F.1');
			if(component.isValid() && response.getState() === "SUCCESS") 
			{
                console.log('F.2');
				var url = response.getReturnValue();
                console.log('F.2');
                //console.log(url);				
                var eUrl= $A.get("e.force:navigateToURL");
                console.log('F.4');
                eUrl.setParams({
                  "url": url
                });
                console.log('F.5');
                eUrl.fire();                
			}
			else 
			{
				console.log('There was a problem and the state is: '+ response.getState());
			}
        });
        console.log('G');
		$A.enqueueAction(getHomePageReportUrlAction);
    },
})