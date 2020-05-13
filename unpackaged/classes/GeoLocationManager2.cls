public class GeoLocationManager2 implements IGeoLocationManager2
{
    public ICallout2 CO { get; set; }
        
    public GeoLocationManager2(ICallout2 callout)
    {        
        CO = callout;        
    }
    
    public final string BASE_ADDRESS = 'https://maps.googleapis.com/maps/api/geocode/json?';
    public final string GOOGLE_API_KEY = 'AIzaSyA3IptgC32vR5qIbFbngP9yJjMKzSguUQk';                                         

    public GeoLocation2 GetAddressByLatitudeAndLongitude(GeoLocation2 geoLocation) 
    {        
        string address= 'latlng=';
        if(geoLocation.Latitude != null && geoLocation.Longitude != null)
        { 
            address = address + EncodingUtil.urlEncode(geoLocation.Latitude + ', ' + geoLocation.Longitude, 'UTF-8');
        }      
        
        HTTPResponse res = CO.getInfoFromExternalService(BASE_ADDRESS + address + '&key=' + GOOGLE_API_KEY);            
        
        geoLocation = ParseResponse(res);        
        return geoLocation;
    }

    public GeoLocation2 StandardizeAddress(GeoLocation2 geoLocation) 
    {        
        string address= 'address=';
        if(geoLocation.StreetAddress != null)
        { 
            address = address += EncodingUtil.urlEncode(geoLocation.StreetAddress, 'UTF-8');
        }
        if(geoLocation.City != null)
        {
            address += '+' + EncodingUtil.urlEncode(geoLocation.City, 'UTF-8');
        }
        if(geoLocation.State != null)
        { 
            address += '+' + EncodingUtil.urlEncode(geoLocation.State, 'UTF-8');
        }
        if(geoLocation.ZipCode != null)
        { 
            address += '+' + EncodingUtil.urlEncode(geoLocation.ZipCode, 'UTF-8');
        }        
        system.debug(BASE_ADDRESS + address + '&key=' + GOOGLE_API_KEY);
        HTTPResponse res = CO.getInfoFromExternalService(BASE_ADDRESS + address + '&key=' + GOOGLE_API_KEY);            
        
        geoLocation = ParseResponse(res);                
        return geoLocation;
    }
    
    private GeoLocation2 ParseResponse(HttpResponse res)
    {
        GeoLocation2 geoLocation = new GeoLocation2();
        string jsonResponse = res.getBody();
        system.debug(jsonResponse);
        GoogleMapResponse2 mapRes = GoogleMapResponse2.parse(jsonResponse);
        if(mapRes.results.size() > 0)
        {
            GoogleMapResponse2.Results result = mapRes.results[0];
            GoogleMapResponse2.Geometry geometry = result.geometry;
            GoogleMapResponse2.Northeast latitudeAndLongitude = geometry.location;
            geoLocation.Latitude = latitudeAndLongitude.lat;
            geoLocation.Longitude = latitudeAndLongitude.lng;
            string street = '';
            string route = '';
            for(GoogleMapResponse2.Address_components ac : result.address_components)
            {
                for(String locType : ac.Types)
                {
                     if(locType == 'administrative_area_level_1')
                     {
                        geoLocation.State = ac.long_name;
                     } 
                    if(locType == 'administrative_area_level_2')
                    {
                        geoLocation.County = ac.long_name;
                    } 
                    else if(locType == 'postal_code' )
                    {
                        geoLocation.ZipCode = ac.long_name;
                    } 
                    else if(locType == 'locality' )
                    {
                        geoLocation.City = ac.long_name;
                    } 
                    else if(locType == 'route')
                    {
                        route = ac.long_name;
                    }     
                    else if(locType == 'street_number')
                    {
                        street = ac.long_name;
                    }
                }    
            }
            if(street != '' && route != '')
            {
                geoLocation.StreetAddress = street + ' ' + route;
            }
        }
        return geoLocation;
    }   
}