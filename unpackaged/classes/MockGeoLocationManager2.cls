public class MockGeoLocationManager2 implements IGeoLocationManager2
{
    public GeoLocation2 GetAddressByLatitudeAndLongitude(GeoLocation2 geoLocation) 
    {        
        geoLocation.StreetAddress = '1600 Pennsylvania Avenue';
        geoLocation.City = 'AnyTown';
        geoLocation.State = 'Florida';
        geoLocation.ZipCode = '90210';
        geoLocation.County = 'Madison County';        
        return geoLocation;
    }

    public GeoLocation2 StandardizeAddress(GeoLocation2 geoLocation) 
    {        
        geoLocation.StreetAddress = '1600 Pennsylvania Avenue';
        geoLocation.City = 'AnyTown';
        geoLocation.State = 'Florida';
        geoLocation.ZipCode = '90210';
        geoLocation.County = 'Madison County';  
        geoLocation.Latitude = 38.0;
        geoLocation.Longitude = 118.0;
        return geoLocation;
    }

}