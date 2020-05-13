global class ComplaintV1 
{
    public ComplaintV1() 
    {
        IsAnonymous = false;
        IsAIr = false;
        IsWater = false;
        IsToxicSubstances = false;
        IsPesticides = false;
        IsSolidWaste = false;
        IsSpill = false;
        IsRefinery = false;
        IsCannabisRelated = false;
        IsDrinkingWater = false;
        IsWaterQuality = false;
        IsWaterRights = false;
        IsWaterOther = false;
        IsBottlesAndCansRelated = false;
        IsWasteTireRelated = false;
        IsOtherSolidWaste = false;
        IsOngoingOccurrence = false;
        IsComplainantEmailOptOut = false;
    }
    public string Id { get; set; }
    public string Name { get; set; }
    public string Language { get; set; }
    public boolean IsAir { get; set; }
    public boolean IsWater { get; set; }
    public boolean IsToxicSubstances { get; set; }
    public boolean IsPesticides { get; set; }
    public boolean IsSolidWaste { get; set; }
    public boolean IsSpill { get; set; }
    public boolean IsRefinery { get; set; }
    public string Description { get; set; }
    public string PreviousOrganizations { get; set; }
    public string ComplaintLocationStreetAddress { get; set; }
    public string ComplaintLocationCity { get; set; }
    public string ComplaintLocationState { get; set; }
    public string ComplaintLocationZipCode { get; set; }
    public string ComplaintLocationDescription { get; set; }
    public string ResponsiblePartyName { get; set; }
    public string ResponsiblePartyCompany { get; set; }
    public string ResponsiblePartyStreetAddress { get; set; }
    public string ResponsiblePartyCity { get; set; }
    public string ResponsiblePartyState { get; set; }
    public string ResponsiblePartyZipCode { get; set; }
    public string AirPollutionSourceVehicleOrStationary { get; set; }
    public string AirPollutionSource { get; set; }
    public boolean IsCannabisRelated { get; set; }
    public boolean IsDrinkingWater { get; set; }
    public boolean IsWaterQuality { get; set; }
    public boolean IsWaterRights { get; set; }
    public string WaterRightsOwner { get; set; }
    public string WaterRightsDescription { get; set; }
    public string WaterRightsNumber { get; set; }
    public boolean IsWaterOther { get; set; }
    public string AffectedWaterSource { get; set; }
    public string Watershed { get; set; }
    public string ParcelNumber { get; set; }
    public string HowDidYouBecomeAwareOfTheIncident { get; set; }
    public string SensitiveLocation { get; set; }
    public string OtherSensitiveLocation { get; set; }
    public string RelationshipToResponsibleParty { get; set; }
    public string OtherRelationshipToResponsibleParty { get; set; }
    public string NatureOfPesticidesReport { get; set; }
    public string AgriculturalCommissionerContacted { get; set; }
    public boolean IsBottlesAndCansRelated { get; set; }
    public boolean IsWasteTireRelated { get; set; }
    public boolean IsOtherSolidWaste { get; set; }
    public string Timeframe { get; set; }
    public DateTime DateAndTimeOfOccurrence { get; set; }
    public boolean IsOngoingOccurrence { get; set; }
    public boolean IsAnonymous { get; set; }
    public string ComplainantFirstName { get; set; }
    public string ComplainantLastName { get; set; }
    public string ComplainantStreetAddress { get; set; }
    public string ComplainantCity { get; set; }
    public string ComplainantState { get; set; }
    public string ComplainantZipCode { get; set; }
    public string ComplainantHomePhone { get; set; }
    public string ComplainantMobilePhone { get; set; }
    public string ComplainantEmail { get; set; }
    public boolean IsComplainantEmailOptOut { get; set; }

    //Files
}