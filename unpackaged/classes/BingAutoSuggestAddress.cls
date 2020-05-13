public class BingAutoSuggestAddress 
{
    @AuraEnabled
	public string CountryRegion {get; set;}
    @AuraEnabled
    public string Locality {get; set;}
    @AuraEnabled
    public string AdminDistrict {get; set;}
    @AuraEnabled
    public string AdminDistrict2 {get; set;}
    @AuraEnabled
    public string CountryRegionIso2 {get; set;}
    @AuraEnabled
    public string HouseNumber {get; set;}
    @AuraEnabled
    public string PostalCode {get; set;}
    @AuraEnabled
    public string AddressLine {get; set;}
    @AuraEnabled
    public string StreetName {get; set;}
    @AuraEnabled
    public string FormattedAddress {get; set;}
        
    
    public static List<BingAutoSuggestAddress> parse(string jsonInput) 
	{
    	JSONParser parser = JSON.createParser(jsonInput);
    	List<BingAutoSuggestAddress> addressList = new List<BingAutoSuggestAddress>();
    	while(parser.nextToken() != JSONToken.END_ARRAY) // we started with an array of objects
        { 
        	
        	if(parser.getCurrentToken() == JSONToken.FIELD_NAME) //token should be field name
            { 
          		string attr = parser.getText(); //get the text of the field name
                parser.nextToken(); // move the pointer
                if(attr == 'resourceSets') 
                { 
                    while(parser.nextToken() != JSONToken.END_OBJECT) 
                    {
                        if(parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                        {
                            string resourceSetAttr = parser.getText();
                            parser.nextToken();
                			if(resourceSetAttr == 'resources') 
                			{ 
                    			while(parser.nextToken() != JSONToken.END_OBJECT) 
                    			{
                        			if(parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                        			{
                            			string resourcesAttr = parser.getText();
                            			parser.nextToken();
                    					//system.debug('resourcesAttr:  ' + resourcesAttr);                                        
                                        if(resourcesAttr == 'value') 
                                        { 
                                            while(parser.nextToken() != JSONToken.END_ARRAY) 
                                            {
                                                if(parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                                                {
                                                    string valueAttr = parser.getText();                                                    
                                                    //system.debug('valueAttr:  ' + valueAttr);
                                                    if(valueAttr == 'address') 
                                                    { 
                                                        BingAutoSuggestAddress addr = new BingAutoSuggestAddress();
                                                        while(parser.nextToken() != JSONToken.END_OBJECT) 
                                                        {
                                                            if(parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                                                            {
                                                                string addressAttr = parser.getText();  
                                                                parser.nextToken();
                                                                //system.debug('addressAttr:  ' + addressAttr);
                                                                if(addressAttr == 'countryRegion') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.CountryRegion = parser.getText();                                                                    
                                                                }                                                                                          
                                                                if(addressAttr == 'locality') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.locality = parser.getText();                                                                    
                                                                }    
                                                                if(addressAttr == 'adminDistrict') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.adminDistrict = parser.getText();                                                                    
                                                                }                                  
                                                                if(addressAttr == 'adminDistrict2') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.adminDistrict2 = parser.getText();                                                                    
                                                                }                                  
                                                                if(addressAttr == 'countryRegionIso2') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.countryRegionIso2 = parser.getText();                                                                    
                                                                }                                  
                                                                if(addressAttr == 'houseNumber') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.houseNumber = parser.getText();                                                                    
                                                                }                                  
                                                                if(addressAttr == 'postalCode') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.postalCode = parser.getText();                                                                    
                                                                }                                  
                                                                if(addressAttr == 'addressLine') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.addressLine = parser.getText();                                                                    
                                                                }                                  
                                                                if(addressAttr == 'streetName') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.streetName = parser.getText();                                                                    
                                                                }                                  
                                                                if(addressAttr == 'formattedAddress') 
                                                                { 
                                                                    //system.debug(parser.getText());
                                                                	addr.formattedAddress = parser.getText();                                                                    
                                                                }                                                                                                  
                                                            }
                                                        }
                                                        addressList.add(addr);
                                                    }                                                                                
                                                }
                                            }
                                        }                            
                        			}
                    			}
                			}                            
                        }
                    }
                }
            }                        
    	}
    	return addressList;   
   	}  
}