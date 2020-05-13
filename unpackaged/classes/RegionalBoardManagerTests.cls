@isTest
public class RegionalBoardManagerTests 
{
    static testMethod void GetRegionalBoard_Success()         
    {
        //Arrange        
        string expected = 'Region 5';
        GeoLocation2 geoLocation = new GeoLocation2();
        geoLocation.Latitude = 34.0;
        geoLocation.Longitude = 34.0;
        
        ICallout2 callout =  new MockCallout2(); 
        
        RegionalBoardManager regionalBoardManager = new RegionalBoardManager(callout);
        
        //Act
        string actual = regionalBoardManager.GetRegionalBoard(geoLocation);
        
        
        //Assert
        System.assertEquals(expected, actual);
    }
}