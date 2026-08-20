"super class

CLASS zcl_standard_order DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_order_id) type string
                                value(iv_weight) type decfloat16.

  methods calculate_shipping returning value(rv_shipping_cost) TYPE decfloat16.

  PROTECTED SECTION.

  DATA mv_order_id TYPE string.
  DATA mv_weight type decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_standard_order IMPLEMENTATION.

method constructor.
mv_order_id = iv_order_id.
mv_weight = iv_weight.
endmethod.

method calculate_shipping.
rv_shipping_cost = mv_weight * 5.
endmethod.
ENDCLASS.






"sub class

CLASS zcl_express_order_subclass DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_standard_order
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_order_id) type string
                                value(iv_weight) type decfloat16
                                value(iv_express_fees) type decfloat16.

  methods calculate_shipping REDEFINITION.    "am redefining the calculate_Shipping again in subclass- it will be called if we create object using this subclass 

  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA mv_express_fees TYPE decfloat16.
ENDCLASS.



CLASS zcl_express_order_subclass IMPLEMENTATION.

method constructor.
super->constructor( iv_order_id = iv_order_id iv_weight = iv_weight ).
mv_Express_fees = iv_Express_fees.
endmethod.

method calculate_shipping.
rv_Shipping_cost = ( mv_weight * 5 ) + mv_express_fees.     "better practice- write "super->calculate_Shipping()" in place of "(mv_weight * 5 )"
endmethod.
ENDCLASS.









"runner class

CLASS zcl_express_runner_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_express_runner_class IMPLEMENTATION.

method if_oo_adt_classrun~main.

DATA(order1) = new zcl_standard_order( iv_order_id = 'order1' iv_weight = '10.0' ).
DATA(exp1) = new zcl_express_order_subclass( iv_order_id = 'express1' iv_weight = '10.0' iv_Express_fees = '20.0' ).

out->write( | shipping cost for standard order: { order1->calculate_shipping(  ) } | ).
out->write( | shipping cost for express order: { exp1->calculate_shipping(  ) } | ).
endmethod.
ENDCLASS.
