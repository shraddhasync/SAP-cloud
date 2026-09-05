"interfaces

INTERFACE zif_discount_strategy
  PUBLIC .

  methods apply_discount importing value(iv_amount) type decfloat16
                         returning value(rv_final_Amount) type decfloat16.

ENDINTERFACE.













"class 1

CLASS zcl_regular_discount DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces zif_discount_strategy.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_regular_discount IMPLEMENTATION.

method zif_discount_strategy~apply_discount.
rv_final_amount = iv_amount * '0.95'.
endmethod.
ENDCLASS.
















"class 2

CLASS zcl_vip_discount DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces zif_discount_strategy.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_vip_discount IMPLEMENTATION.

method zif_discount_strategy~apply_discount.
rv_final_amount = iv_amount * '0.80'.
endmethod.
ENDCLASS.














"runner class

CLASS zcl_discount_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_discount_runner IMPLEMENTATION.

method if_oo_Adt_Classrun~main.

types:begin of ty_discount,
      original_amount type decfloat16,
      discounted_amount TYPE decfloat16,
      end of ty_discount.

DATA it_tab_ref type STANDARD table of ref to zif_discount_strategy with default key.
append new zcl_regular_Discount(  ) to it_tab_ref.
APPEND new zcl_vip_discount(  ) to it_tab_ref.

DATA it_tab_obj type STANDARD table of ty_Discount with default key.

loop AT it_tab_ref into data(bnk).
data wa type ty_discount.
wa-original_amount = '100.0'.
wa-discounted_amount = bnk->apply_discount( iv_amount = wa-original_amount ).
append wa to it_tab_obj.
endloop.

out->write( it_tab_obj ).

endmethod.
ENDCLASS.


just ignore cutomer_type rn.
