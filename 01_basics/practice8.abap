"non cunner class

CLASS zcl_freight_calculator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  TYPES: BEGIN of ty_shipment,
         tracking_id type string,
         origin_city type string,
         destination_City type string,
         weight_kg TYPE decfloat16,
         departure_ts type utclong,
         delivery_ts type utclong,
         freight_cost type decfloat16,
         delivery_hours type i,
         status TYPE string,
  end of ty_shipment.

  types tt_shipments type standard TABLE of ty_shipment with default key.

  methods calculate_shipping_Rates importing value(iv_base_rate) type decfloat16
                                    changing value(ct_shipments) TYPE tt_shipments.

  methods calculate_total_weight importing value(it_shipments) type tt_Shipments
                                   returning value(rv_total_Weight) type decfloat16.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_freight_calculator IMPLEMENTATION.

method calculate_shipping_rates.

data wa type ty_shipment.
LOOP AT ct_shipments into wa.
DATA seconds type i.
seconds = utclong_diff( high = wa-delivery_ts low = wa-departure_ts ).
wa-delivery_hours = seconds / 3600.
wa-freight_cost = wa-weight_kg * iv_base_rate.

if wa-delivery_hours <= 24.
 wa-freight_cost = wa-freight_cost + wa-freight_cost * '0.20'.
 wa-status = 'express'.
 modify ct_shipments from wa.
 elseif wa-delivery_hours > 72.
  wa-freight_cost = wa-freight_cost - wa-freight_cost * '0.15'.
  wa-status = 'delayed'.
  modify ct_shipments from wa.
 else.
  wa-status = 'standard'.
  wa-freight_cost = round( val = wa-freight_cost dec = 2 ).
  modify ct_shipments from wa.
endif.
endloop.
endmethod.

method calculate_total_Weight.
data wa type ty_shipment.
LOOP AT it_shipments into wa.
rv_total_Weight = rv_total_weight + wa-weight_kg.
endloop.
endmethod.
ENDCLASS.




















"runner class

CLASS zcl_freight_calculator_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_freight_calculator_runner IMPLEMENTATION.

method if_oo_Adt_Classrun~main.

data(obj1) = new zcl_freight_Calculator(  ).
DATA base_rate TYPE decfloat16 VALUE '12.50'.

DATA now TYPE utclong.
now = utclong_current(  ).

DATA dep1 TYPE utclong.
DATA arr1 TYPE utclong.
dep1 = now.
arr1 = utclong_add( val = dep1 seconds = 43200 ).

DATA dep2 TYPE utclong.
DATA arr2 TYPE utclong.
dep2 = now.
arr2 = utclong_add( val = dep2 days = 2 ).

DATA dep3 TYPE utclong.
DATA arr3 TYPE utclong.
dep3 = now.
arr3 = utclong_add( val = dep3 days = 4 ).

DATA it_tab TYPE zcl_freight_Calculator=>tt_shipments.
it_tab = VALUE #(
      ( tracking_id      = 'trk-1001'
        origin_city      = '  mumbai  '
        destination_city = 'delhi'
        weight_kg        = '10.5'
        departure_ts     = dep1
        delivery_ts      = arr1
        freight_cost     = '0.0'
        delivery_hours   = 0
        status           = '' )

      ( tracking_id      = 'trk-1002'
        origin_city      = 'pune'
        destination_city = '   bangalore   '
        weight_kg        = '25.0'
        departure_ts     = dep2
        delivery_ts      = arr2
        freight_cost     = '0.0'
        delivery_hours   = 0
        status           = '' )

      ( tracking_id      = 'trk-1003'
        origin_city      = '  chennai  '
        destination_city = 'kolkata'
        weight_kg        = '5.0'
        departure_ts     = dep3
        delivery_ts      = arr3
        freight_cost     = '0.0'
        delivery_hours   = 0
        status           = '' )
    ).

data wa type zcl_freight_calculator=>ty_shipment.
loop AT it_tab into wa.
wa-origin_city = condense( to_upper( wa-origin_city ) ).
wa-destination_city = condense( to_upper( wa-destination_city ) ).
wa-tracking_id = to_upper( wa-tracking_id ).
modify it_tab from wa.
endloop.

obj1->calculate_shipping_rates( exporting iv_base_rate = base_rate
                                changing ct_shipments = it_tab ).

data wa2 type zcl_freight_calculator=>ty_shipment.
loop AT it_tab into wa2.
out->write( |track id: { wa2-tracking_id }    route: { wa2-origin_city }->{ wa2-destination_city }      hours: { wa2-delivery_hours }      cost: { wa2-freight_cost }       status: { wa2-status } | ).
modify it_tab from wa2.
endloop.

out->write( |total weight: { obj1->calculate_total_weight( exporting it_shipments = it_tab ) } | ).

data fuel_tank type decfloat16 value '100.0'.
DATA trip_burn type decfloat16 value '22.5'.
data trips type i VALUE 0.
while fuel_tank >= trip_burn.
fuel_tank = fuel_tank - trip_burn.
trips = trips + 1.
endwhile.

out->write( |completed { trips }.    remanining fuel in tank: { fuel_tank } | ).

endmethod.
ENDCLASS.
