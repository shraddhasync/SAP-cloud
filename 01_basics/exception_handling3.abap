CLASS zcl_order_discount DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods check_discount importing value(iv_discount_pct) type i
                         raising zcx_invalid_discount.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_order_discount IMPLEMENTATION.

method check_discount.
if iv_discount_pct > 50.
 "create object of exception class and give attribute value to it so we can access it in runner class directly.
 data(ex_obj) = new zcx_invalid_discount(  ).
 ex_obj->mv_reason = |discount of { iv_discount_pct }% exceeds the max limit|.
 raise exception ex_obj.
endif.
endmethod.
ENDCLASS.











CLASS zcl_discount_ex_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_discount_ex_runner IMPLEMENTATION.

method if_oo_Adt_classrun~main.

data(validity) = new zcl_order_discount(  ).

try.
 validity->check_discount( 5 ).
 out->write( |discount applied successfully!| ).

 catch zcx_invalid_discount into data(error).
 out->write( error->mv_reason ).

endtry.
endmethod.
ENDCLASS.
