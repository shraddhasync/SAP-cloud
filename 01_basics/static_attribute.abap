CLASS zcl_constructor1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods constructor importing value(iv_initial_balance) type i.

  methods deposit importing value(iv_money) type i.
  methods get_balance returning value(rv_balance) type i.
  methods withdrawl importing value(iv_withdraw_money) type i.

  class-methods get_total_Account returning value(rv_count) type i.

  PROTECTED SECTION.

  PRIVATE SECTION.

  DATA mv_balance type i.
  class-data mv_acc_Count type i.



ENDCLASS.



CLASS zcl_constructor1 IMPLEMENTATION.

method deposit.
mv_balance = mv_balance + iv_money.
endmethod.

method get_balance.
rv_balance = mv_balance.
endmethod.

method withdrawl.
mv_balance = mv_balance - iv_withdraw_money.
endmethod.

method get_total_account.
rv_Count = mv_acc_count.
endmethod.

method constructor.
mv_balance = iv_initial_balance.
mv_acc_Count = mv_acc_count + 1.   "every time a new object is created mv_Acc_count will be increased.

endmethod.
ENDCLASS.







*For runner class
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


data(lo_account2) = new zcl_constructor1( 1000 ).
data(lo_account3) = new zcl_constructor1( 2000 ).

out->write(  | account count: { zcl_constructor1=>get_total_account(  ) } | ).


endmethod.

ENDCLASS.
