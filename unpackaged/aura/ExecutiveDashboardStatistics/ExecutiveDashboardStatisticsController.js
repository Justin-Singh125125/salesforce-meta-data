({
	init : function(component, event, helper) 
	{
        helper.loadBDO(component);
		helper.loadYear(component);
        helper.loadQuarter(component);
 		helper.loadDashboard(component, event);
	},
    loadDashboard : function(component,event,helper)
    {
      helper.loadDashboard(component, event);
    },
    reloadQuarter : function(component, event, helper) 
	{
		helper.loadQuarter(component);	
	},
	loadNewComplaintsHelp : function(component, event, helper) 
	{
        alert('All complaints received for the given time period.');
    },
    loadEnforcementActionsHelp : function(component, event, helper) 
	{
        alert('Complaints where the findings indicated that there were Violations or Compliance Issues.');
    },
    loadReferredHelp : function(component, event, helper) 
	{
        alert('Complaints that were referred.');
    },
    loadCalEPAHandledOpenHelp : function(component, event, helper) 
	{
        alert('Open Complaints that CalEPA or its BDOs are handling internally.');
    },
    loadCalEPAHandledClosedHelp : function(component, event, helper) 
	{
        alert('Closed Complaints that CalEPA or its BDOs are handled internally.');
    },
    loadAverageDaysOpenHelp : function(component, event, helper) 
	{
        alert('Average Days Open');
    },
    loadAverageDaysToCloseHelp : function(component, event, helper) 
	{
        alert('For Complaints that CalEPA or its BDOs are handled internally and closed; the average number of days it took to close.');
    },
    loadNewComplaintsReport : function(component, event, helper) 
	{
        helper.loadNewComplaintsReport(component);
    },
    loadComplaintsWithViolationsReport : function(component, event, helper) 
	{
        helper.loadComplaintsWithViolationsReport(component);
    },    
    loadReferredComplaintsReport : function(component, event, helper) 
	{
        helper.loadReferredComplaintsReport(component);
    },
    loadCalEPAHandledOpenComplaintsReport : function(component, event, helper) 
	{
        helper.loadCalEPAHandledOpenComplaintsReport(component);
    },
    loadCalEPAHandledClosedComplaintsReport : function(component, event, helper) 
	{
        helper.loadCalEPAHandledClosedComplaintsReport(component);
    },
    loadPreviousNewComplaintsReport : function(component, event, helper) 
	{
        helper.loadPreviousNewComplaintsReport(component);
    },
    loadPreviousComplaintsWithViolationsReport : function(component, event, helper) 
	{
        helper.loadPreviousComplaintsWithViolationsReport(component);
    },    
    loadPreviousReferredComplaintsReport : function(component, event, helper) 
	{
        helper.loadPreviousReferredComplaintsReport(component);
    },
    loadPreviousCalEPAHandledOpenComplaintsReport : function(component, event, helper) 
	{
        helper.loadPreviousCalEPAHandledOpenComplaintsReport(component);
    },
    loadPreviousCalEPAHandledClosedComplaintsReport : function(component, event, helper) 
	{
        helper.loadPreviousCalEPAHandledClosedComplaintsReport(component);
    },
    loadReport : function(component, event, helper) 
	{
        alert('Report');
    }, 
})