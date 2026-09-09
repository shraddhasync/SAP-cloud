CLASS zcl_atm_machine DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  events cash_dispensed exporting value(ev_atm_id) type string
                                  value(ev_amount) type decfloat16.

  methods trigger_cash_dispensed importing value(iv_atm_id) type string
                                           value(iv_amount) type decfloat16.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_atm_machine IMPLEMENTATION.

method trigger_cash_dispensed.
raise event cash_dispensed exporting ev_atm_id = iv_Atm_id ev_amount = iv_amount.
endmethod.
ENDCLASS.

CLASS zcl_central_audit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods on_cash_dispensed for event cash_dispensed of zcl_atm_machine importing ev_atm_id ev_amount.

  methods get_log returning value(rv_log) type string.
  PROTECTED SECTION.
  data mv_log type string.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_central_audit IMPLEMENTATION.

method on_Cash_dispensed.
mv_log = |cash dispensed from { ev_atm_id } and the amount is { ev_amount }|.
endmethod.

method get_log.
rv_log = mv_log.
endmethod.

ENDCLASS.

CLASS zcl_atm_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_atm_runner IMPLEMENTATION.

method if_oo_adt_Classrun~main.

data(pub) = new zcl_Atm_machine(  ).
data(sub) = new zcl_central_Audit(  ).

set handler sub->on_cash_dispensed for pub.

pub->trigger_cash_dispensed( iv_Atm_id = '501'  iv_amount = '7000.0' ).

out->write( sub->get_log(  ) ).
endmethod.
ENDCLASS.
