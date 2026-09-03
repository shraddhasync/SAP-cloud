" non runner class

CLASS zcl_hotel_reservation_mgr DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  types: begin OF ty_reservation,
         res_id type i,
         guest_name TYPE string,
         check_in_Date TYPE d,
         check_out_date type d,
         nightly_rate type decfloat16,
         total_cost TYPE decfloat16,
         status TYPE string,
  end of ty_reservation.

  Types tt_reservations type standard table of ty_reservation with default key.

  methods process_reservations importing value(iv_discount_rate) TYPE decfloat
                               changing value(cv_reservations) type tt_reservations.

  methods calculate_total_revenue importing value(iv_reservations) type tt_reservations
                                  returning value(rv_revenue) type decfloat16.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hotel_reservation_mgr IMPLEMENTATION.

method process_reservations.

data wa type ty_reservation.

LOOP AT cv_reservations into wa.
if wa-check_out_date <= wa-check_in_date.
  wa-status = 'invalid'.
  wa-total_cost = '0.0'.
  modify cv_reservations from wa.
else.
 data days TYPE i.
 days = wa-check_out_date - wa-check_in_Date.
 wa-total_cost = days * wa-nightly_rate.
 if days >= 3.
   wa-total_cost = wa-total_cost * ( 1 - iv_discount_rate ).
   wa-total_cost = round( val = wa-total_Cost dec = 2 ).
   wa-status = 'promo_applied'.
   modify cv_reservations from wa.
 else.
 wa-status = 'confirmed'.
 wa-total_cost = days * wa-nightly_rate.
 modify cv_reservations from wa.
 endif.

endif.
endloop.
endmethod.




method calculate_total_revenue.

DATA wa type ty_reservation.
loop AT iv_reservations into wa where status <> 'invalid'.
rv_Revenue = rv_revenue + wa-total_cost.
endloop.
endmethod.



ENDCLASS.















"runner class

CLASS zcl_hotel_reserv_mgr_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hotel_reserv_mgr_runner IMPLEMENTATION.

method if_oo_Adt_classrun~main.

data it_tab TYPE zcl_hotel_reservation_mgr=>tt_reservations.

it_tab = VALUE #(
  ( res_id         = 101
    guest_name     = '   john doe   '
    check_in_date  = '20261001'
    check_out_date = '20261005'
    nightly_rate   = '120.50'
    total_cost     = '0.0'
    status         = '' )

  ( res_id         = 102
    guest_name     = 'jane smith'
    check_in_date  = '20261010'
    check_out_date = '20261012'
    nightly_rate   = '200.00'
    total_cost     = '0.0'
    status         = '' )

  ( res_id         = 103
    guest_name     = '   mark taylor'
    check_in_date  = '20261015'
    check_out_date = '20261015'
    nightly_rate   = '150.00'
    total_cost     = '0.0'
    status         = '' )
).

data wa type zcl_hotel_reservation_mgr=>ty_reservation.
LOOP AT it_tab into wa.
wa-guest_name = condense( to_upper( wa-guest_name ) ).
modify it_tab from wa.
endloop.

DATA discount TYPE decfloat16 value '0.15'.
data(obj1) = new zcl_hotel_reservation_mgr(  ).

obj1->process_reservations( exporting iv_discount_rate = discount
                            changing cv_reservations = it_tab ).

data wa2 type zcl_hotel_reservation_mgr=>ty_reservation.
LOOP AT it_tab into wa2.
out->write( | id: { wa2-res_id }       name: { wa2-guest_name }       total_cost: { wa2-total_cost }        status: { wa2-status } | ).
endloop.

out->write( | total revenue:  { obj1->calculate_total_revenue(  exporting iv_reservations = it_tab ) } | ).

data pointstoaward type i value 500.
data batches type i value 0.
while  pointstoaward > 0.
pointstoaward = pointstoaward - 100.
batches = batches + 1.
endwhile.

out->write( | points batches completes in { batches } batches | ).


endmethod.
ENDCLASS.
