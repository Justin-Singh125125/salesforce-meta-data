public class BingAutoSuggestLookupController 
{
    public static ICallout2 CO { get; set; }

    @AuraEnabled
    public static List<BingAutoSuggestAddress> FetchLookUpValues(String searchKeyWord) 
    {
        try 
		{
            //System.Debug('searchKeyWord:  ' + searchKeyWord);
            string query = EncodingUtil.urlEncode(searchKeyWord, 'UTF-8');
            string key = 'vuAxWmrJSZH602OL5TJC~vr_pv_rBV11EiNwToBe_YQ~Ahz1LVn5di1OTUwbHic_6nxi-fVK8n8HO99z1jBxJ-xSKsEgI72TIyAPdvIRarIt';
            string entityTypes = 'Address';
            string userLocation =  EncodingUtil.urlEncode('38.581845,-121.492026', 'UTF-8');
            String urlTemplate = 'https://dev.virtualearth.net/REST/v1/Autosuggest/?query={0}&key={1}&includeEntityTypes={2}&userLocation={3}';
            List<Object> parameters = new List<Object> {query,key,entityTypes,userLocation};
            String endpoint = String.format(urlTemplate, parameters);
            //system.debug('endpoint:  ' + endpoint);
            HttpRequest req = new HttpRequest();
            req.setHeader('accept', 'application/json');
            req.setEndpoint(endpoint);
            req.setMethod('GET');

            if(Test.isRunningTest())
            {
                CO = new MockCallout2();
            }
            else 
            {
                CO = new Callout2();
            }
            HTTPResponse res = CO.getInfoFromExternalService(req);            
            List<BingAutoSuggestAddress> addresses = BingAutoSuggestAddress.parse(res.getBody());
            List<BingAutoSuggestAddress> addresses2 = new List<BingAutoSuggestAddress>();
            for(BingAutoSuggestAddress a : addresses)
            {
                addresses2.Add(a);
            }
            return addresses2;
        } 
		catch (Exception e) 
		{
			throw new AuraHandledException(e.getMessage());    
		}
    	finally 
		{
        	// Something executed whether there was an error or not
    	}  
    }
}