public class RegionalBoardManager
{
    public ICallout2 CO { get; set; }

    public RegionalBoardManager()
    {        
        CO = new MockCallout2();        
    }

    public RegionalBoardManager(ICallout2 callout)
    {        
        CO = callout;        
    }
    
    public final string BASE_ADDRESS = 'http://services.gis.ca.gov/arcgis/rest/services/Government/AgencyDistAndBound/MapServer/2/query?where=1%3D1&outFields=*&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&outSR=4326&f=json';
       
    public string GetRegionalBoard(Geolocation2 geoLocation) 
    {
        if(!Test.isRunningTest())
        {
            string address= '&geometry=';
            address += geoLocation.Longitude;
            address += ',';
            address += geoLocation.Latitude;
            HTTPResponse res = CO.getInfoFromExternalService(BASE_ADDRESS + address);            
            
            string regionalBoard = ParseResponse(res);        
            return regionalBoard;
        }
        else
        {
            return 'Region 5';
        }
    }
    
    private string ParseResponse(HttpResponse res)
    {
         string jsonResponse = res.getBody();
         WaterboardRegionResponse response = new WaterboardRegionResponse().parse(jsonResponse);
         if(response.features.size() > 0)
         {
             return 'Region ' + string.valueof(response.features[0].attributes.OBJECTID);
         }
         else
         {
             return '';
         }
    }

    public class WaterboardRegionResponse 
    {
        public List<Feature> features { get; set; }
        public WaterboardRegionResponse parse(String json) 
        {
            return (WaterboardRegionResponse) System.JSON.deserialize(json, WaterboardRegionResponse.class);
        }
    }
    public class Feature 
    {
        public Attributes attributes { get; set; }
        public Geometry geometry { get; set; }
    }

    public class Attributes
    {
        public Integer OBJECTID { get; set; }
        public string RB_NAME { get; set; }
    }

    public class Geometry 
    {
        public List<List<List<double>>> rings { get; set; }
    }
}