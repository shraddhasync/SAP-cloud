CLASS zcl_stock_manager DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  events low_Stock exporting value(ev_sku) type string
                                value(ev_qty) type i.



  methods trigger_low_Stock importing value(iv_sku) type string
                                        value(iv_qty) type i.
  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_stock_manager IMPLEMENTATION.
method trigger_low_stock.
if iv_qty < 5.
raise event low_stock exporting ev_sku = iv_sku ev_qty = iv_qty.
endif.
endmethod.
ENDCLASS.

CLASS zcl_procurement_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.



  methods on_low_Stock for event low_Stock of zcl_stock_manager importing ev_sku ev_qty.
  methods get_log returning value(rv_log) type string.

  PROTECTED SECTION.
  data mv_log type string.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_procurement_service IMPLEMENTATION.

method on_low_stock.
mv_log = |{ ev_sku } is low on stock with { ev_qty } quantity.|.
endmethod.

method get_log.
rv_log = mv_log.
endmethod.
ENDCLASS.

CLASS zcl_stock_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_stock_runner IMPLEMENTATION.

method if_oo_Adt_classrun~main.

data(pub) = new zcl_stock_manager(  ).
data(sub) = new zcl_procurement_service(  ).

set handler sub->on_low_stock for pub.

pub->trigger_low_stock( iv_sku = 'laptop'  iv_qty = 9 ).

out->write( sub->get_log(  ) ).
endmethod.
ENDCLASS.
