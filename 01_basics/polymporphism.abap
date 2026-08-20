"super class

CLASS zcl_polymorphism_superclass DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_id) type string
                                value(iv_rate) type decfloat16.

  methods calculate_total_rate importing value(iv_days) type i returning value(rv_total) TYPE decfloat16.

  PROTECTED SECTION.
  DATA mv_vehicle_id type string.
  DATA mv_daily_rate type decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_polymorphism_superclass IMPLEMENTATION.

method constructor.
mv_vehicle_id = iv_id.
mv_daily_rate = iv_rate.
endmethod.

method calculate_total_rate.
rv_total = iv_days * mv_daily_rate.
endmethod.











"subclass 1

CLASS zcl_polymorphism_subclass DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_polymorphism_superclass
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_id) type string
                                value(iv_rate) type decfloat16
                                value(iv_service_fees) TYPE decfloat16.

  methods calculate_total_Rate redefinition.
  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA mv_Service_fee TYPE decfloat16.

ENDCLASS.



CLASS zcl_polymorphism_subclass IMPLEMENTATION.

method constructor.
super->constructor( iv_id = iv_id iv_rate = iv_rate ).
mv_service_fee = iv_service_fees.
endmethod.

method calculate_total_rate.
rv_total = super->calculate_total_rate( iv_days ) + mv_service_fee.
endmethod.
ENDCLASS.
ENDCLASS.












"sub class 2

CLASS zcl_polymorphism_subclass2 DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_polymorphism_superclass
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_id) type string
                                value(iv_rate) type decfloat16
                                value(iv_discount) TYPE decfloat16.

  methods calculate_total_rate redefinition.

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA mv_discount type decfloat16.

ENDCLASS.



CLASS zcl_polymorphism_subclass2 IMPLEMENTATION.

method constructor.
super->constructor( iv_id = iv_id iv_rate = iv_Rate ).
mv_discount = iv_discount.
endmethod.

method calculate_total_rate.
rv_total = super->calculate_total_rate( iv_days ) - mv_Discount.
endmethod.
ENDCLASS.










"runner class

CLASS zcl_polymorphism_runner_cls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_polymorphism_runner_cls IMPLEMENTATION.

method if_oo_adt_classrun~main.

DATA veh1 type ref to zcl_polymorphism_superclass.                 "we gave refernce variable of super class to all
DATA veh2 type ref to zcl_polymorphism_superclass.
DATA veh3 type ref to zcl_polymorphism_superclass.

veh1 = NEW zcl_polymorphism_superclass( iv_id = 'STD-01' iv_rate = '50.0' ).               "but they perforimng individual class when asked
veh2 = NEW zcl_polymorphism_subclass( iv_id = 'LUX-01' iv_rate = '100.0' iv_service_fees = '50.0' ).
veh3 = NEW zcl_polymorphism_subclass2( iv_id = 'STD-01' iv_rate = '50.0' iv_discount = '10.0' ).

out->write( |vehicle 1: { veh1->calculate_total_Rate( 3 ) } | ).
out->write( |vehicle 2: { veh2->calculate_total_Rate( 3 ) } | ).
out->write( |vehicle 3: { veh3->calculate_total_Rate( 3 ) } | ).


endmethod.
ENDCLASS.
