CLASS zcl_sql_join DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_join IMPLEMENTATION.

method if_oo_Adt_Classrun~main.

"inner join
SELECT c~customer_id, c~FIRST_name, c~last_name, a~account_id, a~balance FROM zvr_customer AS c
INNER JOIN zvr_Account AS a
ON c~customer_id = a~customer_id
INTO table @data(wa_innerjoin).

out->write( wa_innerjoin ).





"left outer join
SELECT c~customer_id, c~FIRST_name, c~last_name, a~account_id, a~balance FROM zvr_customer AS c
LEFT JOIN zvr_Account AS a
ON c~customer_id = a~customer_id
INTO table @data(wa_leftjoin).

out->write( wa_leftjoin ).




"right outer join
SELECT c~customer_id, c~FIRST_name, c~last_name, a~account_id, a~balance FROM zvr_customer AS c
RIGHT JOIN zvr_Account AS a
ON c~customer_id = a~customer_id
INTO table @data(wa_rightjoin).

out->write( wa_rightjoin ).



"you can have multiple joins too inside one query
endmethod.
ENDCLASS.
