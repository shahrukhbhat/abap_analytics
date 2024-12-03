@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Dimension for Customer'
@Metadata.ignorePropagatedAnnotations: true

@Analytics.dataCategory: #DIMENSION
@Analytics.internalName: #LOCAL
@ObjectModel.representativeKey: 'CustomerId'

define view entity Z_VE_customer_DIM
  as select from /dmo/customer
  association [0..1] to I_Country as _Country on $projection.CountryCode = _Country.Country
{
  key customer_id  as CustomerId,
      first_name   as FirstName,
      last_name    as LastName,
      title        as Title,
      street       as Street,
      postal_code  as PostalCode,
      city         as City,
      @ObjectModel.foreignKey.association: '_Country'
      country_code as CountryCode,
      /* Associations */
      _Country
}
