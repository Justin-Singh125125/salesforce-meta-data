public with sharing class CalEnviroScreen3Manager //implements ICalEnviroScreen3Manager
{
    public ICallout2 CO { get; set; }
    
    public CalEnviroScreen3Manager()
    {        
        CO = new MockCallout2();        
    }
        
    public CalEnviroScreen3Manager(ICallout2 callout)
    {        
        CO = callout;        
    }

    public CalEnviroScreen3Result GetCalEnvroScreen3Result(double latitude, double longitude)
    {    
        if(!Test.isRunningTest())
        {
            string url = 'http://services1.arcgis.com/PCHfdHz4GlDNAhBb/ArcGIS/rest/services/CES3FINAL_AGOL/FeatureServer/1/query?where=&objectIds=&time=&geometry=%7B%0D%0A+%22x%22%3A{0}%2C%0D%0A+%22y%22%3A{1}%2C%0D%0A+%22spatialReference%22%3A%7B%22wkid%22%3A4269%7D%0D%0A%7D&geometryType=esriGeometryPoint&inSR=&spatialRel=esriSpatialRelIntersects&resultType=none&distance=0.0&units=esriSRUnit_Meter&returnGeodetic=false&outFields=L0CalEnviroScreen_3_0_CIscore%2CL0CalEnviroScreen_3_0_CIscoreP%2CL0CalEnviroScreen_3_0_PCTLrange%2CL0CalEnviroScreen_3_0_tract&returnGeometry=true&returnCentroid=false&multipatchOption=xyFootprint&maxAllowableOffset=&geometryPrecision=&outSR=3857&datumTransformation=&applyVCSProjection=false&returnIdsOnly=false&returnUniqueIdsOnly=false&returnCountOnly=false&returnExtentOnly=false&returnDistinctValues=false&orderByFields=&groupByFieldsForStatistics=&outStatistics=&having=&resultOffset=&resultRecordCount=&returnZ=false&returnM=false&returnExceededLimitFeatures=true&quantizationParameters=&sqlFormat=none&f=pjson&token=';        
            List<String> fillers = new String[]{String.valueOf(longitude),String.valueOf(latitude) };
            url = string.format(url, fillers);
            HTTPResponse res = CO.getInfoFromExternalService(url);            
            if(res.getStatusCode() == 200)
            {
                string jsonResponse = '';       
                jsonResponse = res.getBody();
                CalEnviroScreen3Result response = new CalEnviroScreen3Result().parse(jsonResponse);
                return response; 
            }
            return null;
        }
        else
        {
            Attributes attributes = new Attributes();
            attributes.L0CalEnviroScreen_3_0_CIscore= 82.0303235707931;
            attributes.L0CalEnviroScreen_3_0_CIscoreP= 99.9495522764535;
            attributes.L0CalEnviroScreen_3_0_PCTLrange= '96 - 100%';
            attributes.L0CalEnviroScreen_3_0_tract= '6019001500'; 
            Feature feature = new Feature();
            feature.Attributes = attributes;
            List<Feature> features = new List<Feature>();
            features.Add(feature);
            CalEnviroScreen3Result calEnviroScreen3Result = new CalEnviroScreen3Result();
            calEnviroScreen3Result.Features = features;
            return calEnviroScreen3Result;
        }
    }
    
    public class CalEnviroScreen3Result
    {
        public List<Feature> Features { get; set; }
    
        public CalEnviroScreen3Result() 
        {
            
        }   

        public CalEnviroScreen3Result parse(String json) 
        {
            return (CalEnviroScreen3Result) System.JSON.deserialize(json, CalEnviroScreen3Result.class);
        }
    }
    
    
    public class Feature
    {
        public Attributes Attributes { get; set; }
    }
    
    public class Attributes
    {
        public double L0CalEnviroScreen_3_0_CIscore{ get; set; }
        public double L0CalEnviroScreen_3_0_CIscoreP{ get; set; }
        public string L0CalEnviroScreen_3_0_PCTLrange{ get; set; }
        public string L0CalEnviroScreen_3_0_tract{ get; set; }   
    }
}