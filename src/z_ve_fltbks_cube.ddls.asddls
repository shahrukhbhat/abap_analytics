@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View entity flight bookings cube'
@Analytics.dataCategory: #CUBE

define view entity Z_VE_FLTBKS_CUBE
  as select from /DMO/I_Booking_U as _Booking
  association to Z_VE_customer_DIM   as _Customer   on  _Booking.CustomerID = _Customer.CustomerId
  association to Z_VE_AIRLINE_DIM    as _Airline    on  _Booking.AirlineID = _Airline.CarrierId
  association to Z_VE_connection_DIM as _Connection on  _Booking.AirlineID    = _Connection.CarrierId
                                                    and _Booking.ConnectionID = _Connection.ConnectionId
  association to Z_VE_AGENCY_DIM     as _Agency     on  _Booking.TravelID = _Agency.TravelID
  association to I_Currency          as _Currency   on  _Currency.Currency = $projection.CurrencyCode
  association to /DMO/I_Travel_U     as _Travel     on  _Booking.TravelID = _Travel.TravelID
{

  key _Booking.TravelID                         as TravelID,
  key _Booking.BookingID                        as BookingID,
      @ObjectModel.foreignKey.association: '_Customer'
      _Booking.CustomerID                       as CustomerID,
      @ObjectModel.foreignKey.association: '_Airline'
      _Booking.AirlineID                        as Airline,
      @ObjectModel.foreignKey.association: '_Connection'
      _Booking.ConnectionID                     as ConnectionID,
      _Booking.FlightDate                       as FlightDate,
      _Booking.FlightPrice                      as FlightPrice,
      _Booking.CurrencyCode                     as CurrencyCode,
      _Connection.Distance                      as Distance,
      _Connection.DistanceUnit                  as DistanceUnit,
      _Travel.BookingFee                        as BookingFee,
      _Travel.TotalPrice                        as TotalPrice,

      @Semantics.amount.currencyCode: 'CurrencyCode'
      _Booking.FlightPrice + _Travel.BookingFee as FlightPricePerBooking,

      _Booking.BookingDate                      as BookingDate,

      @Aggregation.default: #SUM
      1                                         as TotalNoOfBookings,
      /* Associations */
      _Customer,
      _Airline,
      _Connection,
      _Agency,
      _Currency,
      _Travel
}
