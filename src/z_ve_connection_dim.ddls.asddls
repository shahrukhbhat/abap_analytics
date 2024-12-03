@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Dimension for Connection'
@Metadata.ignorePropagatedAnnotations: true

@Analytics.dataCategory: #DIMENSION
@Analytics.internalName: #LOCAL
@ObjectModel.representativeKey: 'ConnectionId'

define view entity Z_VE_connection_DIM
  as select from /dmo/connection as _Connection

  association to Z_VE_AIRLINE_DIM as _Airline on $projection.CarrierId = _Airline.CarrierId

{
      @ObjectModel.foreignKey.association: '_Airline'
  key carrier_id                             as CarrierId,
  key connection_id                          as ConnectionId,
      airport_from_id                        as AirportFromId,
      airport_to_id                          as AirportToId,
      departure_time                         as DepartureTime,
      arrival_time                           as ArrivalTime,
      distance                               as Distance,
      distance_unit                          as DistanceUnit,
      concat(airport_from_id, airport_to_id) as trip,
      /* Associations */
      _Airline
}
