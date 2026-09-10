"select / order by  / into corresponding to / where

CLASS zcl_sql_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_runner IMPLEMENTATION.

method if_oo_adt_classrun~main.


"scarr - standard sap database table that stores airline master data.

types:BEGIN of ty_carrier,
      carrier_id type /dmo/carrier-carrier_id,
      name type /dmo/carrier-name,
      currency_code type /dmo/carrier-currency_code,
      end of ty_carrier.

DATA it_tab type standard table of ty_Carrier with empty key.

select from /dmo/carrier fields carrier_id,name,currency_code
where currency_code = 'USD'
order by name ascending
into corresponding fields of table @it_tab.       "@: it shows the object is local, not from standard sap system

out->write( it_tab ).
endmethod.
ENDCLASS.
