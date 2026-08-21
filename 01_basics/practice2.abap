"super class

CLASS zcl_hotel_runner_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hotel_runner_class IMPLEMENTATION.

method if_oo_adt_Classrun~main.

"up casting reference variables to a common superclass
DATA room1 TYPE ref to zcl_hotel_room.             "room1 - reference variable
DATA room2 type ref to zcl_hotel_room.
DATA room3 type ref to zcl_hotel_room.

"initiate
room1 = new zcl_hotel_room( iv_guest = 'alice' iv_check_in_days = 2 iv_nights = 3 iv_rate = '100.0' ).
room2 = new zcl_suite_room( iv_guest = 'bob' iv_check_in_days = 5 iv_nights = 2 iv_rate = '250.0' iv_cleaning_fee = '50.0' ).
room3 = new zcl_extended_room( iv_guest = 'charlie' iv_check_in_days = 10 iv_nights = 8 iv_rate = '90.0' iv_loyalty_discount = '120.0' ).


"dynamic binding     we will call same method that we redfinined in all classes but each instance/object will perform there own redefinied method.
DO 3 TIMES.
CASE sy-index.
 when 1.
     out->write( |room1 : { room1->get_summary(  ) } | ).
     out->write( |bill_amount room 1: { room1->get_bill_amount(  ) } | ).
     out->write( |---------------------------------------------------------------| ).

 when 2.
     out->write( |room2 : { room2->get_summary(  ) } | ).
     out->write( |bill_amount room 2: { room2->get_bill_amount(  ) } | ).
     out->write( |---------------------------------------------------------------| ).

 when 3.
     out->write( |room3 : { room3->get_summary(  ) } | ).
     out->write( |bill_amount room 3: { room3->get_bill_amount(  ) } | ).
ENDCASE.
ENDDO.


endmethod.
ENDCLASS.













"sub class 1

CLASS zcl_suite_room DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_hotel_room
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_guest) type string
                                value(iv_check_in_days) type i
                                value(iv_nights) type i
                                value(iv_rate) type decfloat16
                                value(iv_cleaning_fee) type decfloat16.

  methods get_bill_amount redefinition.

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA mv_cleaning_fee type decfloat16.

ENDCLASS.



CLASS zcl_suite_room IMPLEMENTATION.

method constructor.
super->constructor( iv_guest = iv_guest iv_check_in_days = iv_check_in_days iv_nights = iv_nights iv_rate = iv_rate ).
mv_cleaning_fee = iv_cleaning_fee.
endmethod.

method get_bill_amount.
rv_total = super->get_bill_amount(  ) + mv_cleaning_fee.
endmethod.

ENDCLASS.
















"sub class 2

CLASS zcl_extended_room DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_hotel_room
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_guest) type string
                                value(iv_check_in_days) type i
                                value(iv_nights) type i
                                value(iv_rate) type decfloat16
                                value(iv_loyalty_Discount) TYPE decfloat16.

  methods get_bill_amount redefinition.

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA mv_loyalty_discount type decfloat16.

ENDCLASS.



CLASS zcl_extended_room IMPLEMENTATION.

method constructor.
super->constructor( iv_guest = iv_guest iv_check_in_days = iv_check_in_days iv_nights = iv_nights iv_rate = iv_rate ).
mv_loyalty_discount = iv_loyalty_discount.
endmethod.

method get_bill_amount.
IF mv_nights >= 7.
rv_total = super->get_bill_amount(  ) - mv_loyalty_discount.
ELSE.
rv_total = super->get_bill_amount(  ).
ENDIF.
endmethod.
ENDCLASS.


















"runner class

CLASS zcl_hotel_runner_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hotel_runner_class IMPLEMENTATION.

method if_oo_adt_Classrun~main.

"up casting reference variables to a common superclass
DATA room1 TYPE ref to zcl_hotel_room.             "room1 - reference variable
DATA room2 type ref to zcl_hotel_room.
DATA room3 type ref to zcl_hotel_room.

"initiate
room1 = new zcl_hotel_room( iv_guest = 'alice' iv_check_in_days = 2 iv_nights = 3 iv_rate = '100.0' ).
room2 = new zcl_suite_room( iv_guest = 'bob' iv_check_in_days = 5 iv_nights = 2 iv_rate = '250.0' iv_cleaning_fee = '50.0' ).
room3 = new zcl_extended_room( iv_guest = 'charlie' iv_check_in_days = 10 iv_nights = 8 iv_rate = '90.0' iv_loyalty_discount = '120.0' ).


"dynamic binding     we will call same method that we redfinined in all classes but each instance/object will perform there own redefinied method.
DO 3 TIMES.
CASE sy-index.
 when 1.
     out->write( |room1 : { room1->get_summary(  ) } | ).
     out->write( |bill_amount room 1: { room1->get_bill_amount(  ) } | ).
     out->write( |---------------------------------------------------------------| ).

 when 2.
     out->write( |room2 : { room2->get_summary(  ) } | ).
     out->write( |bill_amount room 2: { room2->get_bill_amount(  ) } | ).
     out->write( |---------------------------------------------------------------| ).

 when 3.
     out->write( |room3 : { room3->get_summary(  ) } | ).
     out->write( |bill_amount room 3: { room3->get_bill_amount(  ) } | ).
ENDCASE.
ENDDO.


endmethod.
ENDCLASS.
