CLASS zcl_secure_vaultt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods constructor importing value(iv_passcode) type string
                                value(iv_balance) type decfloat16.

  methods deposits importing value(iv_amount) type decfloat16.

  methods withdrawl importing value(iv_passcode) type string
                              value(iv_amount) type decfloat16.

  methods get_balance importing value(iv_passcode) type string
                      returning value(rv_balance) type decfloat16.

  PROTECTED SECTION.
  PRIVATE SECTION.
  data mv_passcode type string.
  data mv_balance type decfloat16.

ENDCLASS.



CLASS zcl_secure_vaultt IMPLEMENTATION.

method constructor.
mv_passcode = iv_passcode.
mv_balance = iv_balance.
endmethod.

method deposits.
if iv_amount > 0.
mv_balance = mv_balance + iv_amount.
endif.
endmethod.

method withdrawl.
if iv_passcode = mv_passcode AND iv_amount > 0.
mv_balance = mv_balance - iv_amount.
endif.
endmethod.

method get_balance.
if iv_passcode = mv_passcode AND mv_balance > 0.
rv_balance = mv_balance.
endif.
endmethod.

ENDCLASS.
CLASS zcl_secure_vault_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_secure_vault_runner IMPLEMENTATION.

method if_oo_adt_classrun~main.

data(vault) = new zcl_secure_vaultt( iv_passcode = 'shrud' iv_balance = '20000.0' ).

vault->deposits( iv_amount = '600.0' ).
vault->withdrawl( iv_passcode = 'shrud'  iv_amount = '300.0' ).

out->write( |amount left in account: { vault->get_balance( iv_passcode = 'shrud'  ) }| ).
endmethod.
ENDCLASS.
