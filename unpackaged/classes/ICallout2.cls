public interface ICallout2 
{
	HttpResponse getInfoFromExternalService(string endpoint);
	HttpResponse getInfoFromExternalService(HttpRequest req);
}