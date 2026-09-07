"publisher class
CLASS zcl_order_processor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  events order_shipped exporting value(ev_order_id) type i.

  methods constructor importing value(iv_order_id) type i.

  methods ship_order.

  PROTECTED SECTION.
  DATA mv_order_id type i.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_order_processor IMPLEMENTATION.

method constructor.
mv_order_id = iv_order_id.
endmethod.

method ship_order.
raise event order_shipped exporting ev_order_id = mv_order_id.
endmethod.

ENDCLASS.


















"subscriber

CLASS zcl_email_notifier DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods on_order_shipped for event order_shipped of zcl_order_processor importing ev_order_id.

  methods get_log returning value(ev_log) type string.

  PROTECTED SECTION.
  PRIVATE SECTION.
  data mv_log type string.
ENDCLASS.



CLASS zcl_email_notifier IMPLEMENTATION.

method on_order_shipped.
mv_log = |confirmed order for is: { ev_order_id }|.
endmethod.

method get_log.
ev_log = mv_log.
endmethod.
ENDCLASS.




















"runner class

CLASS zcl_order_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_order_runner IMPLEMENTATION.

method if_oo_Adt_classrun~main.

DATA(publisher) = new zcl_order_processor( iv_order_id = 5001 ).
data(notifier) = new zcl_email_notifier(  ).

"connect
set handler notifier->on_order_shipped for publisher.

publisher->ship_order(  ).

out->write( notifier->get_log(  ) ).

endmethod.
ENDCLASS.
