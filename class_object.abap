CLASS zcl_bank_acc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods deposit importing value(iv_amount) type i.
  methods get_balance returning value(rv_balance) type i.

  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA mv_balance type i.

ENDCLASS.

CLASS zcl_bank_acc IMPLEMENTATION.

method deposit.
mv_balance = mv_balance + iv_amount.
endmethod.

method get_balance.
rv_balance =  mv_balance.
endmethod.
ENDCLASS.








"FOR RUNNER CLASS

CLASS zcl_execution_bank_acc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_execution_bank_acc IMPLEMENTATION.

method if_oo_adt_classrun~main.
DATA(lo_account) = new zcl_bank_acc( ).
lo_account->deposit( 500 ).
out->write( | current balance : { lo_Account->get_balance(  ) } | ).
endmethod.

ENDCLASS.



