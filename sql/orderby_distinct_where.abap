CLASS zcl_sql_orderby DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.




CLASS zcl_sql_orderby IMPLEMENTATION.

method if_oo_Adt_classrun~main.


"ORDER - help sort output data in Ascending / Descending
data wa_order type STANDARD table of zvr_customer.
select * from zvr_customer
order by first_name ascending ,LAST_name descending
into table @wa_order.

out->write( wa_order ).



"DISTINCT with single column
data wa_distinct type STANDARD table of zvr_customer.
select distinct FIRST_name from zvr_customer into corresponding fields of table @wa_distinct.

LOOP AT wa_distinct into data(item).
out->Write( item-first_name ).
endloop.


"DISTINCT with multiple column combination
data wa_distinct2 type STANDARD table of zvr_customer.
select distinct FIRST_name , LAST_name from zvr_customer into corresponding fields of table @wa_distinct2.

LOOP AT wa_distinct2 into data(item2).
out->Write( | { item2-first_name }    { item2-last_name } | ).
endloop.






"WHERE -single row   (equal = '='  .  unequal = '<>'  ,   in between = 'where birth_date BETWEEN '20034060' AND '20067086'  ,
   "LIKE = 'where email_id LIKE '%gmail.com'    ,    AND = 'where city = 'jaipur' AND join_Date > '20034647'   ,    IN = 'where city IN ('delhi' , 'mumbai')    /    OR = 'where city = 'delhi' OR city = 'mumbai'    ,     NOT = 'where NOT city = 'delhi'
data wa_where type STANDARD table of zvr_customer.
select * from zvr_customer where customer_id = '000003' into table @wa_where.
out->write( wa_where ).



"WHERE -multiple row
data wa_where2 type STANDARD TABLE of zvr_customer.
select FIRST_name, LAST_name from zvr_customer where city = 'Delhi' into corresponding fields of table @wa_where2.

LOOP AT wa_where2 into data(item3).
out->write( | { item3-first_name } { item3-last_name } | ).


endloop.
endmethod.
ENDCLASS.
