CLASS zcl_sql_delete_update_subquery DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_delete_update_subquery IMPLEMENTATION.

method if_oo_adt_classrun~main.

"update
update zvr_customer_arc set email_id = 'updatedemail@.com', city = 'updatecity' where customer_id = 10.


"delete
delete from zvr_customer_arc where city = 'jaipur'.          "this row would be deleted from table




"subquery
select c~customer_id, c~FIRST_name, c~LAST_name, a~account_id, a~balance from zvr_customer as c
left join zvr_account as a
on c~customer_id = a~customer_id
where a~balance > ( select AVG( balance as dec( 15,2 ) ) from zvr_account ) into table @data(wa_subquery).
out->write( wa_subquery ).

endmethod.

ENDCLASS.
