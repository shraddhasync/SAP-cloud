"amdp code class

CLASS zcl_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_amdp_marker_hdb.

  types: begin of ty_cust,
         customer_id TYPE zacustomer_zacustid,
         first_name type zacustomer_first_name,
         last_name type zacustomer_last_name,
         end of ty_cust,
         tt_cust type standard table of ty_cust with EMPTY key.

  class-methods get_Customer
                AMDP OPTIONS CDS SESSION CLIENT DEPENDENT READ-ONLY
                importing value(iv_cust_id) type zacustomer_Zacustid
                exporting value(et_result) type tt_cust.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp IMPLEMENTATION.

method get_customer
  BY DATABASE PROCEDURE FOR HDB LANGUAGE SQLSCRIPT USING zvr_customer.

  et_result = select customer_id,first_name,last_name from zvr_Customer
              where customer_id = iv_cust_id;
endmethod.

















"runner class

CLASS zcl_amdp_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_runner IMPLEMENTATION.

method if_oo_Adt_classrun~main.

DATA lt_Result TYPE zcl_amdp=>tt_cust.

zcl_amdp=>get_customer( exporting iv_cust_id = 1 importing et_result = lt_Result ).

out->write( lt_result ).
endmethod.

ENDCLASS.

ENDCLASS.
