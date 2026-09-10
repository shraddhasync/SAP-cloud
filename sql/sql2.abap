CLASS zcl_sql_runner2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_runner2 IMPLEMENTATION.

method if_oo_Adt_Classrun~main.

select from /dmo/connection fields carrier_id, connection_id, airport_from_id, airport_to_id
where airport_from_id = 'FRA'
order by airport_from_id Ascending
into table @data(local_connection).      "without creating a custom table

if sy-subrc = 0.
out->write( local_connection ).
else.
out->write( 'no connections' ).
endif.

endmethod.
ENDCLASS.
