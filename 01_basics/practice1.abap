"super class

CLASS zcl_flight_booking DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
  CLASS-DATA gv_total_bookings type i.

  methods constructor importing value(iv_passenger) type string
                                value(iv_fare) TYPE decfloat16
                                value(iv_days_from_today) TYPE i.

  methods calculate_final_fare returning value(rv_fare) type decfloat16.

  CLASS-METHODS get_booking_count returning value(rv_total_bookings) TYPE decfloat16.

  methods get_Details returning value(rv_details) type string.
  PROTECTED SECTION.
  DATA mv_booking_id type string.
  DATA mv_passenger_name type string.
  DATA mv_base_fare TYPE decfloat16.
  DATA mv_flight_date type d.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_flight_booking IMPLEMENTATION.

method constructor.
mv_passenger_name = condense( to_upper( iv_passenger ) ).
mv_flight_Date = cl_abap_context_info=>get_system_date( ) + iv_Days_from_today.
gv_total_bookings = gv_total_bookings  + 1.
mv_booking_id = |BK-| && gv_total_bookings.
mv_base_fare = iv_fare.

endmethod.

method calculate_final_fare.
rv_fare = mv_base_fare.
endmethod.

method get_booking_count.
rv_total_bookings = gv_total_bookings.
endmethod.

method get_Details.
rv_details = | Booking ID: | &&  mv_booking_id && | Passenger: | && mv_passenger_name && | Flight Date: | && mv_flight_date.
endmethod.
ENDCLASS.


















"sub class 1

CLASS zcl_buisness_flight DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_flight_booking
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_passenger) type string
                                value(iv_fare) TYPE decfloat16
                                value(iv_days_from_today) TYPE i
                                value(iv_lounge_fee) type decfloat16.

  methods calculate_final_fare redefinition.

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA mv_lounge_fee type decfloat16.

ENDCLASS.



CLASS zcl_buisness_flight IMPLEMENTATION.

method constructor.
super->constructor( iv_passenger = iv_passenger iv_fare = iv_fare iv_days_from_today = iv_days_from_today ).
mv_lounge_fee = iv_lounge_fee.

endmethod.

method calculate_final_Fare.
rv_fare = super->calculate_final_fare(  ) + mv_lounge_fee.
endmethod.
ENDCLASS.














"sub class 2

CLASS zcl_discount_flight DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_flight_booking
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_passenger) type string
                                value(iv_fare) TYPE decfloat16
                                value(iv_days_from_today) TYPE i
                                value(iv_discount_rate) TYPE decfloat16.

  methods calculate_final_fare redefinition.

  PROTECTED SECTION.

  PRIVATE SECTION.
  DATA mv_discount_rate type decfloat16.
ENDCLASS.



CLASS zcl_discount_flight IMPLEMENTATION.

method constructor.
super->constructor( iv_passenger = iv_passenger iv_fare = iv_fare iv_days_from_today = iv_days_from_today ).
mv_discount_Rate = iv_discount_rate.
endmethod.

method calculate_final_fare.
rv_fare = super->calculate_final_fare(  ) * ( 1 - mv_discount_Rate ).
endmethod.
ENDCLASS.














"runner class

CLASS zcl_flight_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_Adt_Classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_flight_runner IMPLEMENTATION.

method if_oo_adt_classrun~main.

"declare using Poly-morphism (up casting) - declaring all objects under common superclass.
DATA b1 type ref to zcl_flight_booking.
DATA b2 type ref to zcl_flight_booking.
DATA b3 type ref to zcl_flight_booking.

"initiating
b1 = new zcl_flight_booking( iv_passenger = '   joe doe   ' iv_fare = '200.0'  iv_days_from_today  = 5 ).
b2 = new zcl_buisness_flight( iv_passenger = 'jane smith' iv_fare = '500.0'  iv_days_from_today  = 10  iv_lounge_fee = '100.0' ).
b3 = new zcl_discount_flight( iv_passenger = '    alex taylor' iv_fare = '300.0'  iv_days_from_today  = 2  iv_discount_Rate = '0.20' ).


"dynamic binding- as method is one but used by different objects/instances. (pressing one button of remote but all working individually different chore.
DO 3 TIMES.
IF sy-index = 1.
 out->write( | b1 details: { b1->get_Details(  ) } | ).
 out->write( | b1: { b1->calculate_final_fare(  ) } | ).

ELSEIF sy-index = 2.
 out->write( | b2 details: { b2->get_Details(  ) } | ).
 out->write( | b2: { b2->calculate_final_fare(  ) } | ).

ELSEIF sy-index = 3.
 out->write( | b3 details: { b3->get_Details(  ) } | ).
 out->write( | b3: { b3->calculate_final_fare(  ) } | ).

ENDIF.
ENDDO.

out->write( |total_booking: { zcl_flight_booking=>get_booking_count(  ) } | ).


endmethod.
ENDCLASS.
