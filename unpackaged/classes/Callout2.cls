public class Callout2 implements ICallout2
{    
    //This is a comment!
    public HttpResponse getInfoFromExternalService(string endpoint) 
    {
        system.debug('endpoint:  ' + endpoint);
        HttpRequest req = new HttpRequest();
        req.setHeader('accept', 'application/json');
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }

    public HttpResponse getInfoFromExternalService(HttpRequest req) 
    {
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }
}