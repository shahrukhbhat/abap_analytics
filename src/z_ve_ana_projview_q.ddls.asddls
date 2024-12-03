@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Query for flight booking'

define transient view entity Z_VE_ANA_PROJVIEW_Q // transient: only a ABAP Server runtime object is generated
  provider contract analytical_query             // provider contract analytical query: strict analytical checks are executed inside Dictionary Activation

  with parameters
                                                 // Parameters are allowed
    p_preferred_currency : abap.dec(15,2)

  as projection on Z_VE_FLTBKS_CUBE              // Underlying View needs to be a CUBE view
{

          @AnalyticsDetails.query.axis: #ROWS
          TravelID,
          @AnalyticsDetails.query.axis: #ROWS
          BookingID,
          @AnalyticsDetails.query.axis: #ROWS
          CustomerID,
          @AnalyticsDetails.query.axis: #ROWS
          Airline,
          @AnalyticsDetails.query.axis: #ROWS
          ConnectionID,
          @AnalyticsDetails.query.axis: #ROWS
          FlightDate,
          @AnalyticsDetails.query.axis: #ROWS
          FlightPrice,
          @AnalyticsDetails.query.axis: #ROWS
          CurrencyCode,
          @AnalyticsDetails.query.axis: #ROWS
          BookingDate,
          TotalNoOfBookings,
          @AnalyticsDetails.query.axis: #ROWS
          Distance,
          @AnalyticsDetails.query.axis: #ROWS
          DistanceUnit,
          @AnalyticsDetails.query.axis: #ROWS
          TotalPrice,
          @AnalyticsDetails.query.axis: #ROWS
          BookingFee,
          @AnalyticsDetails.query.axis: #ROWS
          FlightPricePerBooking,

          @AnalyticsDetails.query.axis: #ROWS                               // Typed Literals
          @Aggregation.default: #FORMULA                                    // Calculated Units as references for calculated quantities
          @EndUserText.label: 'Discount On Booking'
          abap.decfloat34'0.05'                                                                     as DiscountOnBooking,

          @AnalyticsDetails.query.axis: #ROWS
          @Aggregation.default: #FORMULA
          @EndUserText.label: 'Tax On Booking'
          abap.decfloat34'0.19'                                                                     as TaxOnBooking,

          @AnalyticsDetails.query.axis: #ROWS
  virtual CurrencyCode1 : abap.cuky( 5 ),                                   // Definition of calculated units via virtual

          @AnalyticsDetails.query.axis: #ROWS
          @Semantics.amount.currencyCode: 'CurrencyCode1'
          @Aggregation.default: #FORMULA
          @EndUserText.label: 'FliPrice Discounted'
          curr_to_decfloat_amount( FlightPricePerBooking ) * ( 1 - $projection.DiscountOnBooking  ) as FlightPriceDiscounted, // Referring to other expressions via $projection

          @AnalyticsDetails.query.axis: #ROWS
          @Semantics.amount.currencyCode: 'CurrencyCode'
          @Aggregation.default: #FORMULA
          @EndUserText.label: 'Final Flight Price'
          $projection.FlightPriceDiscounted * ( 1 + $projection.TaxOnBooking )                      as FlightPriceDiscountedTaxed

}
