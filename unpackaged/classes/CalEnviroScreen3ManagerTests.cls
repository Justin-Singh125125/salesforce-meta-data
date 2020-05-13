@isTest
private class CalEnviroScreen3ManagerTests {
    
    
    @isTest static void TestGetCalEnvroScreen3Result() 
    {
        //Arrange
        double expectedCIscore = 82.0303235707931;
        double expectedCIscoreP = 99.9495522764535;
        string expectedPCTLrange = '96 - 100%';
        string expectedTract = '6019001500'; 

        double latitude = 34.0;
        double longitude = 34.0;
        
        ICallout2 callout =  new MockCallout2(); 
        
        CalEnviroScreen3Manager calEnviroScreen3Manager = new CalEnviroScreen3Manager(callout);
        
        //Act
        CalEnviroScreen3Manager.CalEnviroScreen3Result calEnviroScreen3Result = calEnviroScreen3Manager.GetCalEnvroScreen3Result(latitude, longitude);
        double actualCIscore = calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_CIscore;
        double actualCIscoreP = calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_CIscoreP;
        string actualPCTLrange = calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_PCTLrange;
        string actualTract = calEnviroScreen3Result.Features[0].Attributes.L0CalEnviroScreen_3_0_tract;
        
        //Assert
        System.assertEquals(expectedCIscore, actualCIscore);
        System.assertEquals(expectedCIscoreP, actualCIscoreP);
        System.assertEquals(expectedPCTLrange, actualPCTLrange);
        System.assertEquals(expectedTract, actualTract);
     }
}