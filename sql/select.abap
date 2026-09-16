CLASS zcl_sql_select DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_select IMPLEMENTATION.

method if_oo_adt_classrun~main.

"reading single row- use workarea
data wa type zvr_customer.
select single * from zvr_customer into @wa.
out->write( | firstname: { wa-first_name }    lastname : { wa-last_name }     dob: { wa-dob }     city: { wa-city }   email id: { wa-email_id }| ).




"reading single row with specific column- use workarea
DATA wa2 type zvr_customer.
select single first_name , last_name from zvr_customer into ( @wa2-first_name , @wa2-last_name ).     "OR "INTO corresponding fields of @wa2.
out->write( | firstname: { wa2-first_name }    lastname : { wa2-last_name } | ).




"reading data all together- use worktable
data wa_table type STANDARD table of zvr_customer.
select * from zvr_customer into table @wa_table.
LOOP AT wa_table into data(item).
out->write( | firstname: { item-first_name }    lastname : { item-last_name }     dob: { item-dob }     city: { item-city }   email id: { item-email_id }| ).
endloop.




"reading data all together specific column- use worktable
data wa_table2 type STANDARD table of zvr_customer.
select FIRST_name , last_name from zvr_customer into corresponding fields of table @wa_table2.
LOOP AT wa_table2 into data(item2).
out->write( | firstname: { item2-first_name }      lastname: { item2-last_name } | ).
endloop.


endmethod.
ENDCLASS.
