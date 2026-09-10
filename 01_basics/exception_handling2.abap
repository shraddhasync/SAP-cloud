CLASS zcl_bank_account_ex DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_initial_balance) type decfloat16.

  methods check_balance importing value(iv_amount) type decfloat16
                         raising zcx_insufficient_funds.
  PROTECTED SECTION.
  DATA mv_balance type decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bank_account_ex IMPLEMENTATION.

method constructor.
mv_balance = iv_initial_balance.
endmethod.

method check_balance.
if iv_amount > mv_balance.
raise exception type zcx_insufficient_funds.
endif.
endmethod.
ENDCLASS.










CLASS zcl_bank_ex_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bank_ex_runner IMPLEMENTATION.

method if_oo_adt_Classrun~main.

data(checkvalidity) = new zcl_bank_Account_ex( '250' ).

try.
   checkvalidity->check_balance( '20' ).

   out->write( 'you can withdraw' ).
  catch zcx_insufficient_funds into data(error).
   out->write( |error caught : insufficient funds| ).
endtry.
endmethod.

ENDCLASS.
