@isTest
public class BingAutoSuggestAddressTests 
{
    static testMethod void ParseTest()
    {
        //Arrange        
        string expectedCountryRegion = 'United States';
        string expectedLocality = 'Sacramento';
        string expectedAdminDistrict = 'California';
        string expectedAdminDistrict2 = 'Sacramento County';
        string expectedCountryRegionIso2 = 'US';
        string expectedHouseNumber = '1001';
        string expectedPostalCode = '95814';
        string expectedAddressLine = '1001 I St';
        string expectedStreetName = 'I St';
        string expectedFormattedAddress = '1001 I St, Sacramento, California 95814';

        string jsonString = '{"authenticationResultCode":"ValidCredentials","brandLogoUri":"http://dev.virtualearth.net/Branding/logo_powered_by.png","copyright":"Copyright © 2019 Microsoft and its suppliers. All rights reserved. This API cannot be accessed and the content and any results may not be used, reproduced or transmitted in any manner without express written permission from Microsoft Corporation.","resourceSets":[{"estimatedTotal":1,"resources":[{"__type":"Autosuggest:http://schemas.microsoft.com/search/local/ws/rest/v1","value":[{"__type":"Address","address":{"countryRegion":"United States","locality":"Sacramento","adminDistrict":"California","adminDistrict2":"Sacramento County","countryRegionIso2":"US","houseNumber":"1001","postalCode":"95814","addressLine":"1001 I St","streetName":"I St","formattedAddress":"1001 I St, Sacramento, California 95814"}}]}]}],"statusCode":200,"statusDescription":"OK","traceId":"bef536c159f545eba7d8e9d9a04cc38f|CO000010E5|7.7.0.0"}';
        //Act
        Test.startTest();
        List<BingAutoSuggestAddress> addresses = BingAutoSuggestAddress.parse(jsonString);
        Test.stopTest();
        BingAutoSuggestAddress actual = addresses[0];

        //Assert
        System.assertEquals(expectedCountryRegion, actual.CountryRegion);                          
        System.assertEquals(expectedLocality, actual.Locality); 
        System.assertEquals(expectedAdminDistrict, actual.AdminDistrict); 
        System.assertEquals(expectedAdminDistrict2, actual.AdminDistrict2); 
        System.assertEquals(expectedCountryRegionIso2, actual.CountryRegionIso2); 
        System.assertEquals(expectedHouseNumber, actual.HouseNumber); 
        System.assertEquals(expectedPostalCode, actual.PostalCode); 
        System.assertEquals(expectedAddressLine, actual.AddressLine); 
        System.assertEquals(expectedStreetName, actual.StreetName); 
        System.assertEquals(expectedFormattedAddress, actual.FormattedAddress); 
    }

}