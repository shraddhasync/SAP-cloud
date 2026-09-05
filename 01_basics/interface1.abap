"interface

INTERFACE zif_smart_device
  PUBLIC .
  methods calculate_hourly_cost returning value(rv_cost) type decfloat16.

  methods get_Description returning value(rv_desc) TYPE string.

ENDINTERFACE.














"super class

CLASS zcl_appliance DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces zif_smart_device.

  methods constructor importing value(iv_brand) TYPE string
                                value(iv_watts) TYPE i.

  PROTECTED SECTION.
  data mv_brand type string.
  data mv_watts type i.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_appliance IMPLEMENTATION.

method constructor.
mv_brand = iv_brand.
mv_watts = iv_watts.
endmethod.

method zif_smart_device~calculate_hourly_cost.
rv_cost = ( mv_watts / 1000 ) * '0.15'.
endmethod.

method zif_smart_device~get_description.
rv_desc = |appliance brand: { mv_brand } |.
endmethod.

ENDCLASS.
















"sub class

CLASS zcl_ac_unit DEFINITION
  PUBLIC
  FINAL
  inheriting from zcl_appliance
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods zif_smart_Device~calculate_hourly_cost redefinition.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ac_unit IMPLEMENTATION.

method zif_smart_Device~calculate_hourly_cost.
rv_cost = ( mv_watts / 1000 ) * '0.25'.
endmethod.


ENDCLASS.


















"runner class

CLASS zcl_home_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_home_runner IMPLEMENTATION.

method if_oo_Adt_Classrun~main.

data it_tab TYPE standard table of ref to zif_smart_device with default key.

append new zcl_appliance( iv_brand = 'samsung' iv_watts = 1000 ) to it_tab.
append new zcl_ac_unit( iv_brand = 'daikin' iv_watts = 2000 ) to it_tab.

LOOP AT it_tab into data(item).
out->write( |{ item->get_description(  ) }   cost: { item->calculate_hourly_cost(  ) } | ).
endloop.

endmethod.
ENDCLASS.

