@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Query for flight'

define transient view entity Z_VE_Flight_AnaProj_Query
  provider contract analytical_query

  as projection on Z_VE_Flight_Cube
{
  @AnalyticsDetails.query.axis: #ROWS
  AirlineID,
  @AnalyticsDetails.query.axis: #ROWS
  ConnectionID,
  @AnalyticsDetails.query.axis: #ROWS
  FlightDate,
  @AnalyticsDetails.query.axis: #ROWS
  Price,
  @AnalyticsDetails.query.axis: #ROWS
  CurrencyCode,
  @AnalyticsDetails.query.axis: #ROWS
  PlaneType,
  @AnalyticsDetails.query.axis: #ROWS
  MaximumSeats,
  @AnalyticsDetails.query.axis: #ROWS
  OccupiedSeats,
  @AnalyticsDetails.query.axis: #ROWS
  TotalFreeSeats
}
