@isTest
public class GeoLocationManagerTests2 
{
    static testMethod void GetAddressByLatitudeAndLongitude_Success()         
    {     
        //Arrange        
        string expected = '1600 Pennsylvania Avenue';
        GeoLocation2 geoLocation = new GeoLocation2();
        geoLocation.Latitude = 34.0;
        geoLocation.Longitude = 34.0;
        
        ICallout2 callout =  new MockCallout2(); 
        
        GeoLocationManager2 geoLocationManager = new GeoLocationManager2(callout);
        
        //Act
        GeoLocation2 geoLocation2 = geoLocationManager.GetAddressByLatitudeAndLongitude(geoLocation);
        string actual = geoLocation2.StreetAddress;
        
        //Assert
        System.assertEquals(expected, actual);
     
    }   
    
    static testMethod void StandardizeAddress_Success()         
    {     
        //Arrange        
        string expected = '1600 Pennsylvania Avenue';
        GeoLocation2 geoLocation = new GeoLocation2();
        //geoLocation.Latitude = 34.0;
        geoLocation.StreetAddress = '101 Main St';
        geoLocation.City = 'Our Town';
        geoLocation.State = 'Illinois';
        geoLocation.ZipCode = '12345';
        
        ICallout2 callout =  new MockCallout2(); 
        
        GeoLocationManager2 geoLocationManager = new GeoLocationManager2(callout);
        
        //Act
        GeoLocation2 geoLocation2 = geoLocationManager.StandardizeAddress(geoLocation);
        string actual = geoLocation2.StreetAddress;
        
        //Assert
        System.assertEquals(expected, actual);
     
    }   
}