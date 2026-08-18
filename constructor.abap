CLASS zcl_constructor1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  DATA balance type i.

  methods constructor importing value(iv_initial_balance) type i.

  methods deposit importing value(money) type i.
  methods get_balance returning value(rn_balance) type i.
  methods withdrawl importing value(withdraw_money) type i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_constructor1 IMPLEMENTATION.

method deposit.
balance = balance + money.
endmethod.

method get_balance.
rn_balance = balance.
endmethod.

method withdrawl.
balance = balance - withdraw_money.
endmethod.

method constructor.
balance = iv_initial_balance.
endmethod.
ENDCLASS.





  



*For runner clas
CLASS zcl_constructor_runner_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_constructor_runner_class IMPLEMENTATION.

method if_oo_Adt_Classrun~main.
data(lo_account) = new zcl_constructor1( 1000 ).
lo_account->deposit( 500 ).
lo_account->withdrawl( 200 ).
lo_account->get_balance(  ).
out->write( | balance: { lo_Account->balance } | ).
endmethod.

ENDCLASS.
