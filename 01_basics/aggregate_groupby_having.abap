CLASS zcl_aggr_func DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aggr_func IMPLEMENTATION.

method if_oo_Adt_classrun~main.

"AGGREGATE FUNCTIONS- works on columns and return single value

"COUNT
select count( * ) from zvr_transaction into @data(item).
out->write( |total rows: { item } | ).



"SUM  -work on numeric column only
SELECT sum( amount ) from zvr_transaction into @data(item2).
out->write( |total amount: { item2 } | ).



"AVG
SELECT avg( amount as dec( 10,2 ) ) from zvr_transaction into @data(item3).
out->write( |average: { item3 } | ).



"MIN
SELECT min( amount ) from zvr_transaction into @data(item4).
out->write( |min amount: { item4 } | ).



"MAX
SELECT max( amount ) from zvr_transaction into @data(item5).
out->write( |max amount: { item5 } | ).





"GROUP BY - use to group distinct categories.
"AGGREGATE FUNCTIONS with GROUP BY


select city, count( * ) as city_count
from zvr_customer
GROUP BY city
into table @data(wa).

out->write( wa ).




"HAVING - use to put condition on GROUPS(group by)
select city, count( * ) as city_count
from zvr_customer
GROUP BY city
HAVING count( * ) > 1   "or city = 'Delhi
into table @data(wa2).

out->write( wa2 ).




endmethod.


ENDCLASS.
