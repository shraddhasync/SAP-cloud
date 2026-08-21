"super class

CLASS zcl_subscription DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
  CLASS-DATA gv_active_subs type i.
  methods constructor importing value(iv_user) type string
                                value(iv_start_offset) type i
                                value(iv_price) TYPE decfloat16.

  methods get_Annual_cost returning value(rv_cost) type decfloat16.

  methods get_info returning value(rv_info) type string.

  CLASS-methods get_total_subs RETURNING value(rv_total_subs) TYPE i.

  PROTECTED SECTION.
  DATA mv_sub_id type string.
  data mv_user_name type string.          "keeping in protected means its visible to this class and child classes only
  DATA mv_start_Date type d.
  DATA mv_monthly_price type decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_subscription IMPLEMENTATION.

method constructor.
mv_user_name = condense( to_upper( iv_user ) ).
mv_start_date = cl_abap_context_info=>get_system_Date(  ) + iv_start_offset.
gv_active_subs = gv_active_subs + 1.
mv_sub_id = |SUB-{ gv_active_subs }|.
mv_monthly_price = iv_price.
endmethod.

method get_annual_Cost.
rv_cost = mv_monthly_price * 12.
endmethod.

method get_info.
rv_info = |ID: { mv_sub_id } USER: { mv_user_name } Start: { mv_start_date } |.
endmethod.

method get_total_subs.
rv_total_subs = gv_Active_subs.
endmethod.

ENDCLASS.
















"sub class 1

CLASS zcl_premium_sub DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_subscription
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_user) type string
                                value(iv_start_offset) type i
                                value(iv_price) TYPE decfloat16
                                value(iv_addon_fee) type decfloat16.

  methods get_annual_cost redefinition.

  PROTECTED SECTION.
  data mv_Addon_fee TYPE decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_premium_sub IMPLEMENTATION.

method constructor.
super->constructor( iv_user = iv_user iv_start_offset = iv_start_offset iv_price = iv_price ).
mv_addon_fee = iv_Addon_fee.
endmethod.

method get_annual_cost.
rv_cost = super->get_annual_cost(  ) + ( mv_Addon_fee * 12 ).
endmethod.
ENDCLASS.
















"sub class 2

CLASS zcl_student_sub DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_subscription
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods constructor importing value(iv_user) type string
                                value(iv_start_offset) type i
                                value(iv_price) TYPE decfloat16
                                value(iv_discount_percent) type decfloat16.

  methods get_annual_cost redefinition.

  PROTECTED SECTION.
  DATA mv_discount_percent type decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_student_sub IMPLEMENTATION.

method constructor.
super->constructor( iv_user = iv_user iv_start_offset = iv_start_offset iv_price = iv_price ).
mv_discount_percent = iv_discount_percent.
endmethod.

method get_annual_cost.
rv_cost = super->get_annual_cost(  ) * (  1 - mv_discount_percent ).
endmethod.
ENDCLASS.














"runner class

CLASS zcl_subscription_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_subscription_runner IMPLEMENTATION.

method if_oo_Adt_classrun~main.

"up casting
DATA sub1 type ref to zcl_subscription.
DATA sub2 type ref to zcl_subscription.
DATA sub3 type ref to zcl_subscription.

"initiating
sub1 = new zcl_subscription( iv_user = '   mike rose  ' iv_start_offset = 0  iv_price = '10.0' ).
sub2 = new zcl_premium_sub( iv_user = 'rachel zane' iv_start_offset = 3  iv_price = '20.0' iv_Addon_fee = '5.0' ).
sub3 = new zcl_student_sub( iv_user = '   harvey specter' iv_start_offset = 1  iv_price = '10.0' iv_discount_percent = '0.50' ).


"dynamic binding
DO 3 TIMES.
CASE sy-index.
 when 1.
   out->write( |sub1: { sub1->get_info(  ) } | ).
   out->write( |cost: { sub1->get_annual_cost(  ) } | ).
   out->write( |--------------------------------------------------------------| ).
 when 2.
   out->write( |sub2: { sub2->get_info(  ) } | ).
   out->write( |cost: { sub2->get_annual_cost(  ) } | ).
   out->write( |--------------------------------------------------------------| ).
 when 3.
   out->write( |sub3: { sub3->get_info(  ) } | ).
   out->write( |cost: { sub3->get_annual_cost(  ) } | ).
   out->write( |--------------------------------------------------------------| ).
ENDCASE.
ENDDO.

out->write( | total_subscription: { zcl_subscription=>get_total_subs(  ) } | ).


endmethod.
ENDCLASS.
