@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Dimension for Agency'
@Metadata.ignorePropagatedAnnotations: true

@Analytics.dataCategory: #DIMENSION
@Analytics.internalName: #LOCAL
@ObjectModel.representativeKey: 'AgencyId'

define view entity Z_VE_AGENCY_DIM
  as select from /dmo/agency
  association to /DMO/I_Travel_U as _Travel on $projection.AgencyId = _Travel.AgencyID
{
  key agency_id        as AgencyId,
      name             as Name,
      street           as Street,
      postal_code      as PostalCode,
      city             as City,
      country_code     as CountryCode,
      phone_number     as PhoneNumber,
      /* Associations */
      _Travel.TravelID as TravelID,
      _Travel
}
