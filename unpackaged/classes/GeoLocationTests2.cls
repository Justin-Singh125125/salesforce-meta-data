@isTest
public class GeoLocationTests2 
{
static testMethod void StreetAddress_get_set()
{
    //Arrange
    string expected = 'Lorem Ipsum';
    GeoLocation2 geolocation = new GeoLocation2();
    //Act
    geolocation.StreetAddress = 'Lorem Ipsum';
    //Assert
    System.assertEquals(expected, geolocation.StreetAddress);
}


static testMethod void City_get_set()
{
    //Arrange
    string expected = 'Lorem Ipsum';
    GeoLocation2 geolocation = new GeoLocation2();
    //Act
    geolocation.City = 'Lorem Ipsum';
    //Assert
    System.assertEquals(expected, geolocation.City);
}


static testMethod void State_get_set()
{
    //Arrange
    string expected = 'Lorem Ipsum';
    GeoLocation2 geolocation = new GeoLocation2();
    //Act
    geolocation.State = 'Lorem Ipsum';
    //Assert
    System.assertEquals(expected, geolocation.State);
}


static testMethod void County_get_set()
{
    //Arrange
    string expected = 'Lorem Ipsum';
    GeoLocation2 geolocation = new GeoLocation2();
    //Act
    geolocation.County = 'Lorem Ipsum';
    //Assert
    System.assertEquals(expected, geolocation.County);
}


static testMethod void ZipCode_get_set()
{
    //Arrange
    string expected = 'Lorem Ipsum';
    GeoLocation2 geolocation = new GeoLocation2();
    //Act
    geolocation.ZipCode = 'Lorem Ipsum';
    //Assert
    System.assertEquals(expected, geolocation.ZipCode);
}


static testMethod void Latitude_get_set()
{
    //Arrange
    double expected = 1.0;
    GeoLocation2 geolocation = new GeoLocation2();
    //Act
    geolocation.Latitude = 1.0;
    //Assert
    System.assertEquals(expected, geolocation.Latitude);
}


static testMethod void Longitude_get_set()
{
    //Arrange
    double expected = 1.0;
    GeoLocation2 geolocation = new GeoLocation2();
    //Act
    geolocation.Longitude = 1.0;
    //Assert
    System.assertEquals(expected, geolocation.Longitude);
}



}