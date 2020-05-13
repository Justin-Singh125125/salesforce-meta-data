@isTest
private class Callout2Tests {
     @isTest static void testCallout() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator2());
        
        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
        HttpResponse res = new Callout2().getInfoFromExternalService('http://api.salesforce.com/foo/bar');
        
        // Verify response received contains fake values
        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');
        String actualValue = res.getBody();
        String expectedValue = '{"foo":"bar"}';
        System.assertEquals(actualValue, expectedValue);
        System.assertEquals(200, res.getStatusCode());
    }
}