({
    init: function (cmp) 
    {        
        var items = [
                {
                    "label": "Air",
                    "name": "Air",
                    "expanded": false,
                    "items": 
                    [{
                        "label": "Vehicle",
                        "name": "Air.Vehicle",
                        "expanded": true,
                        "items" :[
                            {
                                "label": "Car",
                                "name": "Air.Vehicle.Car",
                                "expanded": true,
                                "items" :[]
                            }, 
                            {
                                "label": "Truck",
                                "name": "Air.Vehicle.Truck",
                                "expanded": true,
                                "items" :[]
                            },
                            {
                                "label": "Off-road Equipment",
                                "name": "Air.Vehicle.OffRoadEquipment",
                                "expanded": true,
                                "items" :[]
                            }, 
                            {
                                "label": "Other",
                                "name": "Air.Vehicle.Other",
                                "expanded": true,
                                "items" :[]
                            }]
                    },
                    {
                        "label": "Stationary Source",
                        "name": "Air.StationarySource",
                        "expanded": true,
                        "items" :[
                        {
                            "label": "Dust",
                            "name": "Air.StationarySource.Dust",
                            "expanded": true,
                            "items" :[]
                        }, 
                        {
                            "label": "Smoke",
                            "name": "Air.StationarySource.Smoke",
                            "expanded": true,
                            "items" :[]
                        },
                            {
                            "label": "Odors",
                            "name": "Air.StationarySource.Odors",
                            "expanded": true,
                            "items" :[]
                        }, 
                        {
                            "label": "Gas Station",
                            "name": "Air.StationarySource.GasStation",
                            "expanded": true,
                            "items" :[]
                        },
                            {
                            "label": "Painting",
                            "name": "Air.StationarySource.Painting",
                            "expanded": true,
                            "items" :[]
                        }, 
                        {
                            "label": "Asbestos",
                            "name": "Air.StationarySource.Asbestos",
                            "expanded": true,
                            "items" :[]
                        },
                            {
                            "label": "Other",
                            "name": "Air.StationarySource.Other",
                            "expanded": true,
                            "items" :[]
                        }
                        ]
                    }]
                }, 
                {
                    "label": "Water",
                    "name": "Water",
                    "expanded": false,
                    "items": 
                    [{
                        "label": "Cannabis/Marijuana cultivation",
                        "name": "Water.CannabisMarijuanaCultivation",
                        "expanded": true,
                        "items" :[]
                    },
                    {
                        "label": "Drinking Water",
                        "name": "Water.DrinkingWater",
                        "expanded": true,
                        "items" :[]
                    },
                    {
                        "label": "Water Quality",
                        "name": "Water.WaterQuality",
                        "expanded": true,
                        "items" :[]
                    },
                    {
                        "label": "Water Rights",
                        "name": "Water.WaterRights",
                        "expanded": true,
                        "items" :[]
                    },
                    {
                        "label": "Other",
                        "name": "Water.Other",
                        "expanded": true,
                        "items" :[]
                    }]
                }, 
                {
                    "label": "Hazardous Waste/Materials",
                    "name": "HazardousWasteMaterials",
                    "expanded": false,
                    "items": 
                    [
                    {
                        "label": "Illegal Disposal/Handling",
                        "name": "HazardousWasteMaterials.IllegalDisposalHandling",
                        "expanded": true,
                        "items" :[]
                    }, 
                    {
                        "label": "Management Facilities",
                        "name": "HazardousWasteMaterials.ManagementFacilities",
                        "expanded": false,
                        "items" :[]
                    }, 
                    {
                        "label": "Transporters",
                        "name": "HazardousWasteMaterials.Transporters",
                        "expanded": false,
                        "items" :[]
                    }, 
                    {
                        "label": "Recyclers",
                        "name": "HazardousWasteMaterials.Recyclers",
                        "expanded": false,
                        "items" :[]
                    }, 
                    {
                        "label": "In Consumer Products",
                        "name": "HazardousWasteMaterials.InConsumerProducts",
                        "expanded": false,
                        "items" :[]
                    }, 
                    {
                        "label": "Other",
                        "name": "HazardousWasteMaterials.Other",
                        "expanded": false,
                        "items" :[]
                    }]
                }, 
                {
                    "label": "Pesticides",
                    "name": "9",
                    "expanded": false,
                    "items": 
                    [
                    {
                        "label": "Misuse",
                        "name": "Pesticides.Misuse",
                        "expanded": true,
                        "items" :[]
                    }, 
                    {
                        "label": "Overspray",
                        "name": "Pesticides.Overspray",
                        "expanded": false,
                        "items" :[]
                    }, 
                    {
                        "label": "Violation of Pesticide Sales",
                        "name": "Pesticides.ViolationOfPesticideSales",
                        "expanded": false,
                        "items" :[]
                    }, 
                    {
                        "label": "Other",
                        "name": "Pesticides.Other",
                        "expanded": false,
                        "items" :[]
                    }]
                }, 
                {
                    "label": "Solid Waste/Recycling",
                    "name": "SolidWasteRecycling",
                    "expanded": false,
                    "items": 
                    [
                    {
                        "label": "Bottles and Cans Recycling",
                        "name": "SolidWasteRecycling.BottlesAndCansRecycling",
                        "expanded": true,
                        "items" :[]
                    }, 
                    {
                        "label": "Waste Tires",
                        "name": "SolidWasteRecycling.WasteTires",
                        "expanded": false,
                        "items" :[]
                    }, 
                    {
                        "label": "Other",
                        "name": "SolidWasteRecycling.Other",
                        "expanded": false,
                        "items" :[]
                    }]
                },
                {
                    "label": "Other",
                    "name": "Other",
                    "expanded": false,
                    "items": 
                    []}];
        cmp.set('v.items', items);
    },
    
    afterScriptsLoaded: function(cmp,event)
    {
    	alert('hello');
        myUtil.loadMapScenario();	     
    },
    
    handleSelectComplaintType: function (cmp, event) {
        event.preventDefault();
        var complaintType = event.getParam('name')
        if(complaintType != 'Air' 
          	&& complaintType != 'Air.Vehicle' 
          	&& complaintType != 'Air.StationarySource'  
          	&& complaintType != 'Water'  
			&& complaintType != 'HazardousWateMaterials'             
			&& complaintType != 'Pesticides'                        
			&& complaintType != 'SolidWasteRecycling'                        
          )
        {
        	cmp.set('v.complaintType', complaintType);
            cmp.set('v.typeSelected', true);
        }
        else
        {
            cmp.set('v.complaintType', '');
            cmp.set('v.typeSelected', false);
        }
    },
        
   	moveNext : function(component,event,helper){
     // control the next button based on 'currentStep' attribute value    
     var getCurrentStep = component.get("v.currentStep");
        if(getCurrentStep == "1"){
            component.set("v.currentStep", "2");
        }
        else if(getCurrentStep == 2){
            component.set("v.currentStep", "3");
        }
    },
    
    moveBack : function(component,event,helper){
      // control the back button based on 'currentStep' attribute value    
        var getCurrentStep = component.get("v.currentStep");
         if(getCurrentStep == "2"){
            component.set("v.currentStep", "1");
         }
         else if(getCurrentStep == 3){
            component.set("v.currentStep", "2");
         }
    },
    
    finish : function(component,event,helper){
      // on last step show the alert msg, hide popup modal box and reset the currentStep attribute  
        alert('Thank You !');
        component.set("v.currentStep", "1");
    },
})