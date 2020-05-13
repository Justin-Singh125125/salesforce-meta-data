public interface IGeoLocationManager2
{
    GeoLocation2 GetAddressByLatitudeAndLongitude(GeoLocation2 geoLocation);
    GeoLocation2 StandardizeAddress(GeoLocation2 geoLocation);
}