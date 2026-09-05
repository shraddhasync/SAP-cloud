"interface

INTERFACE zif_taxable
  PUBLIC .

  methods calculate_tax returning value(rv_tax) type decfloat16.

ENDINTERFACE.









"class 1

CLASS zcl_employee DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces zif_taxable.

  methods constructor importing value(iv_salary) TYPE decfloat16.

  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA mv_salary TYPE decfloat16.
ENDCLASS.



CLASS zcl_employee IMPLEMENTATION.

method constructor.
mv_Salary = iv_salary.
endmethod.

method zif_taxable~calculate_tax.
rv_tax = mv_salary * '0.20'.
endmethod.

ENDCLASS.
















"class 2

CLASS zcl_productt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces zif_taxable.

  methods constructor importing value(iv_price) type decfloat16.

  PROTECTED SECTION.
  PRIVATE SECTION.
  data mv_price TYPE decfloat16.

ENDCLASS.



CLASS zcl_productt IMPLEMENTATION.

method constructor.
mv_price = iv_price.
endmethod.

method zif_taxable~calculate_tax.
rv_tax = mv_price * '0.10'.
endmethod.
ENDCLASS.





















"runner class

CLASS zcl_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_Classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_runner IMPLEMENTATION.

method if_oo_adt_Classrun~main.

DATA it_tab type STANDARD table of ref to zif_taxable WITH default key.
append new zcl_employee( iv_Salary = '50000.0' ) to it_tab.
append new zcl_productt( iv_price = '100.0' ) to it_tab.

LOOP AT it_tab into data(wa).
out->write( |tax amount: { wa->calculate_tax(  ) } | ).
endloop.
endmethod.
ENDCLASS.
