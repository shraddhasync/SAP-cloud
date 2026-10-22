"create database table

@EndUserText.label : 'hotel booking table'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zvr_hotel_demo {
  key booking_id : abap.char(10) not null;
  customer_name  : abap.char(40);
  city           : abap.char(30);
  hotel_name     : abap.char(50);
  price          : abap.char(20);
  currency       : abap.cuky;
}
