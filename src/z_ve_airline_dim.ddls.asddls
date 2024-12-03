
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Dimension for Airline'
@Metadata.ignorePropagatedAnnotations: true

@Analytics.dataCategory: #DIMENSION
@Analytics.internalName: #LOCAL
@ObjectModel.representativeKey: 'CarrierId'

define view entity Z_VE_AIRLINE_DIM as select from /dmo/carrier {
 
@ObjectModel.text.element: ['AirlineName']
key carrier_id    as CarrierId,
    name          as AirlineName,
    currency_code as CurrencyCode
 
}
