CLASS zcl_sql_set_operations DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.
  
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_set_operations IMPLEMENTATION.

method if_oo_adt_classrun~main.

"set operation

"UNION
select customer_id, FIRST_name, LAST_name from zvr_customer
union
select customer_id, FIRST_name, LAST_name from zvr_customer_Arc
order by customer_id
into table @data(wa_union).

out->write( wa_union ).





"UNION ALL 
select customer_id, FIRST_name, LAST_name from zvr_customer
union all
select customer_id, FIRST_name, LAST_name from zvr_customer_Arc
order by customer_id
into table @data(wa_unionall).

out->write( wa_unionall ).





"INTERSECT 
select customer_id, FIRST_name, LAST_name from zvr_customer
intersect
select customer_id, FIRST_name, LAST_name from zvr_customer_Arc
order by customer_id
into table @data(wa_intersect).

out->write( wa_intersect ).





"EXCEPT 
select customer_id, FIRST_name, LAST_name from zvr_customer
except
select customer_id, FIRST_name, LAST_name from zvr_customer_Arc
order by customer_id
into table @data(wa_except).

out->write( wa_except ).

endmethod.
ENDCLASS.
