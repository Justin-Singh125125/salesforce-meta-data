({
    doInit : function(component, event, helper) 
    {
        console.log('doInit');
        var allTimeAction = component.get("c.GetComplaintsByBDOAllTime"); 
        console.log('allTimeAction');
        allTimeAction.setCallback(this, function(response) { 
            console.log('allTimeCallback');
            var state = response.getState(); 
            if (state === "SUCCESS") { 
                var dataObj= response.getReturnValue(); 
                component.set("v.allTimeData",dataObj);
                helper.allTimePieChart(component,event,helper);
            } 
            else
            {
                console.log(state);
            } 
        });
        $A.enqueueAction(allTimeAction);
    },
    allTimePieChart : function(component,event,helper) {
        console.log('allTimePieChart');
        var jsonData = component.get("v.allTimeData");
        var dataObj = JSON.parse(jsonData);
        
        new Highcharts.Chart({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                renderTo: component.find("complaintsByBDOAllTime").getElement(),
                type: 'pie'
            },
            title: {
                text: component.get("v.allTimeChartTitle")
            },
            subtitle: {
                text: component.get("v.allTimeChartSubTitle")
            },
            xAxis: {
                categories: component.get("v.xAxisCategories"),
                crosshair: true
            },
            yAxis: {
                min: 0,
                title: 
                {
                    text: component.get("v.yAxisParameter")
                }
            },
            tooltip: {
                pointFormat: '{series.name}: <b>{point.y}</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: true,
                        format: '<b>{point.name}</b>: {point.y}% ',
                        style: {
                            color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                        }
                    }
                }
            },
            series: [{
                name:'StageName',
                data:dataObj
            }]
            
        });
        
    },
})