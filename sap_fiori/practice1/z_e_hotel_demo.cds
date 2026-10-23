"create cds view

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'hotel service def'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@UI.headerInfo: {
  typeName : 'booking',
  typeNamePlural : 'bookings',
  title : {type: #STANDARD, value: 'City'},
  description: {type: #STANDARD, value: 'HotelName'}
}

define view entity z_e_hotel_Demo as select from zvr_hotel_demo
{   
  @UI.facet: [{
    id: 'hotetheader',
    purpose: #STANDARD,
    type: #IDENTIFICATION_REFERENCE,
    label: 'Booking Details',
    position: 10
  }]

  @UI.lineItem : [{position: 10, label: 'booking ID' }]
  @UI.selectionField : [{position: 10}]
  @UI.identification: [{ position:10 , label:'booking ID' }]
  key booking_id as BookingId,
  
  @UI.lineItem : [{position: 20, label: 'customer name' }]
  @UI.identification: [{ position:20 , label:'customer name' }]
  customer_name as CustomerName,
  
  @UI.lineItem : [{position: 30, label: 'city' }]
  @UI.selectionField : [{position: 20}]
  @UI.identification: [{ position:30 , label:'city' }]
  city as City,
  
  @UI.lineItem : [{position: 40, label: 'hotel name' }]
  @UI.identification: [{ position:40 , label:'hotel name' }]
  hotel_name as HotelName,
  
  @UI.lineItem : [{position: 50, label: 'price' }]
  @UI.identification: [{ position:50 , label:'price' }]
  @Semantics.amount.currecyCode : 'currency'
  price as Price,
  
  currency as Currency,
  
  @UI.lineItem: [{ position: 60, label: 'Booking Status', criticality: 'StatusCriticality' }]
  @UI.identification: [{ position: 60, label: 'Booking Status', criticality: 'StatusCriticality' }]
  booking_status as BookingStatus,

  case booking_status
    when 'confirmed' then 3
    when 'pending'   then 2
    when 'cancelled' then 1
    else 0
  end as StatusCriticality
}
