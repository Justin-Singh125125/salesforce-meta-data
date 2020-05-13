@isTest
public class MockCallout2Tests
{
    static testMethod void getInfoFromExternalService_NullOrEmptyBody_Google()         
    {     
        //Arrange        
        string expected = '{"results":[{"address_components":[{"long_name":"1600","short_name":"1600","types":["street_number"]},{"long_name":"Pennsylvania Avenue","short_name":';
        expected = expected.substring(0, 100);
        MockCallout2 mockCallout = new MockCallout2();
        //Act
        HttpResponse response = mockCallout.getInfoFromExternalService('google');
        string actual = response.getBody().substring(0, 100);
        //Assert
        System.assertEquals(expected, actual);
    }   
    
   
    static testMethod void getInfoFromExternalService_NullOrEmptyBody_TAMU()         
    {     
        //Arrange        
        string expected = '{"version":"4.10","TransactionId":"0416d2ce-88cb-4594-88aa-36002745a1df","Version":"4.1","QueryStatusCodeValue":"200","FeatureMatchingResultType":"Success","FeatureMatchingResultCount":"1","TimeTaken":"0.0120012","ExceptionOccured":"False","Exception":"","InputAddress":{"StreetAddress":"308 W BRAYTON RD Mount Morris IL 61054","City":"Mount Morris","State":"IL","Zip":"61054"},"OutputGeocodes":[{"OutputGeocode":{"Latitude":"42.0450418730812","Longitude":"-89.4374406716704","NAACCRGISCoordinateQualityCode":"03","NAACCRGISCoordinateQualityType":"StreetSegmentInterpolation","MatchScore":"100","MatchType":"Exact","FeatureMatchingResultType":"Success","FeatureMatchingResultCount":"1","FeatureMatchingGeographyType":"StreetSegment","RegionSize":"3539.77894405805","RegionSizeUnits":"Meters","MatchedLocationType":"LOCATION_TYPE_STREET_ADDRESS","ExceptionOccured":"False","Exception":"","ErrorMessage":""},"CensusValues":[{"CensusValue2":{"CensusYear":"TwoThousand","CensusTimeTaken":"0","NAACCRCensusTractCertaintyCode":"1","NAACCRCensusTractCertaintyType":"ResidenceStreetAddress","CensusBlock":"3024","CensusBlockGroup":"3","CensusTract":"9609.00","CensusCountyFips":"141","CensusStateFips":"17","CensusCbsaFips":"40300","CensusCbsaMicro":"1","CensusMcdFips":"51011","CensusMetDivFips":"","CensusMsaFips":"6880","CensusPlaceFips":"50998","ExceptionOccured":"False","Exception":"","ErrorMessage":""},"CensusValue1":{"CensusYear":"TwoThousandTen","CensusTimeTaken":"0","NAACCRCensusTractCertaintyCode":"1","NAACCRCensusTractCertaintyType":"ResidenceStreetAddress","CensusBlock":"3027","CensusBlockGroup":"3","CensusTract":"9609.00","CensusCountyFips":"141","CensusStateFips":"17","CensusCbsaFips":"40300","CensusCbsaMicro":"1","CensusMcdFips":"51011","CensusMetDivFips":"","CensusMsaFips":"6880","CensusPlaceFips":"50998","ExceptionOccured":"False","Exception":"","ErrorMessage":""}}]}]}';
        
        MockCallout2 mockCallout = new MockCallout2();
        //Act
        HttpResponse response = mockCallout.getInfoFromExternalService('tamu');
        string actual = response.getBody();
        //Assert
        System.assertEquals(expected, actual);
    }
    
    static testMethod void getInfoFromExternalService_NullOrEmptyBody_GISServicesCA()         
    {     
        //Arrange        
        string expected = '{"displayFieldName":"RB_NAME","fieldAliases":{"OBJECTID":"OBJECTID","RB_NAME":"Name"},"geometryType":"esriGeometryPolygon","spatialReference":{"wkid":4326,"latestWkid":4326},"fields":[{"name":"OBJECTID","type":"esriFieldTypeOID","alias":"OBJECTID"},{"name":"RB_NAME","type":"esriFieldTypeString","alias":"Name","length":20}],"features":[{"attributes":{"OBJECTID":5,"RB_NAME":"Central Valley"}}]}';
        
        MockCallout2 mockCallout = new MockCallout2();
        //Act
        HttpResponse response = mockCallout.getInfoFromExternalService('services.gis.ca.gov');
        string actual = response.getBody();
        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void getInfoFromExternalService_NullOrEmptyBody_GeoCensusGov()         
    {     
        //Arrange        
        string expected = '{"result":{"addressMatches":[{"geographies":{"Census Tracts":[{"GEOID":"06067009630"}]}}]}}';
        
        MockCallout2 mockCallout = new MockCallout2();
        //Act
        HttpResponse response = mockCallout.getInfoFromExternalService('geocoding.geo.census.gov');
        string actual = response.getBody();
        //Assert
        System.assertEquals(expected, actual);
    }

    static testMethod void getInfoFromExternalService_NullOrEmptyBody_Services1ArcgisCom()         
    {     
        //Arrange        
        string expected = '{"objectIdFieldName":"OBJECTID","globalIdFieldName":"","geometryType":"esriGeometryPolygon","spatialReference":{"wkid":3310,"latestWkid":3310},"fields":[{"name":"CIscore","type":"esriFieldTypeDouble","alias":"CIscore","sqlType":"sqlTypeOther","domain":null,"defaultValue":null},{"name":"CIscoreP","type":"esriFieldTypeDouble","alias":"CIscoreP","sqlType":"sqlTypeOther","domain":null,"defaultValue":null},{"name":"PCTLrange","type":"esriFieldTypeString","alias":"PercentileRange","sqlType":"sqlTypeOther","length":256,"domain":null,"defaultValue":null},{"name":"tract","type":"esriFieldTypeDouble","alias":"tract","sqlType":"sqlTypeOther","domain":null,"defaultValue":null}],"features":[{"attributes":{"CIscore":82.0303235707931,"CIscoreP":99.9495522764535,"PCTLrange":"96 - 100%","tract":6019001500}}]}';
        
        MockCallout2 mockCallout = new MockCallout2();
        //Act
        HttpResponse response = mockCallout.getInfoFromExternalService('services1.arcgis.com');
        string actual = response.getBody();
        //Assert
        System.assertEquals(expected, actual);
    }
    
    static testMethod void getInfoFromExternalService_NotNullBody()
    {     
        //Arrange        
        string expected = 'Lorem Ipsum';
        
        MockCallout2 mockCallout = new MockCallout2();
        mockCallout.Body = 'Lorem Ipsum';
        //Act
        HttpResponse response = mockCallout.getInfoFromExternalService('services.gis.ca.gov');
        string actual = response.getBody();
        //Assert
        System.assertEquals(expected, actual);
    }   
}