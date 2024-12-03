@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Cube'
@Analytics.dataCategory: #CUBE
define view entity Z_VE_Flight_Cube
  as select from /DMO/I_Flight_R as _Flight
  association to Z_VE_AIRLINE_DIM as _Carrier on _Flight.AirlineID = _Carrier.CarrierId
{
      @ObjectModel.foreignKey.association: '_Carrier'
  key AirlineID,
  key ConnectionID,
  key FlightDate,
      Price,
      CurrencyCode,
      PlaneType,
      MaximumSeats,
      OccupiedSeats,
      @Aggregation.default: #MIN
      MaximumSeats - OccupiedSeats as TotalFreeSeats,
      /* Associations */
      _Carrier

}
