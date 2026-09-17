CLASS zcl_sql_string_func DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_string_func IMPLEMENTATION.

method if_oo_Adt_Classrun~main.


"LOWER - lowercase
select lower( first_name ) from zvr_customer into table @data(wa).
out->write( wa ).





"UPPER -uppercase
select upper( FIRST_name ) from zvr_customer into table @data(wa2).
LOOP AT wa2 into data(item).
out->write( item ).
endloop.






"CONCATE
select FIRST_name ,LAST_name , CONCAT( first_name,last_name ) as fullname from zvr_customer into table @data(wa3).
out->write( wa3 ).







"CONCAT_WITH_SPACE
select FIRST_name, LAST_name , CONCAT_WITH_SPACE( first_name,last_name,1 ) as fullname from zvr_customer into table @data(wa4).
out->write( wa4 ).





"LEFT FUNCTION  - use to get substring by giving substring length from a direction(left)
select FIRST_name, left( first_name, 1 ) as initials from zvr_customer into table @data(wa5).
out->write( wa5 ).






"RIGHT FUNCTION  - use to get substring by giving substring length from a direction(RIGHT)
select FIRST_name, right( first_name, 1 ) as initials from zvr_customer into table @data(wa6).
out->write( wa6 ).




"LENGTH
select FIRST_name, length( first_name ) as firstname_length from zvr_customer into table @data(wa7).
out->write( wa7 ).




"REPLACE  -(org string,'wht substring need to be replaced, to what substring we replace it to)
select single FIRST_name , replace( first_name, 'it' , 'gh' ) as replaced from zvr_customer into @data(wa8).
out->write( wa8 ).



"substring  -(org string, start pos, string length)   NOTE:index start from 1
select single FIRST_name, substring( first_name , 2,2 )  as subtring from zvr_customer into @data(wa9).
out->write( wa9 ).







endmethod.

ENDCLASS.
