CLASS zcl_math_op_Case_when DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_math_op_case_when IMPLEMENTATION.

method if_oo_adt_classrun~main.


"CASE WHEN
"mathematical operations

select account_id, balance + 500 as bonus_balance,
balance - 500 as after_charges,
balance * 100 as depost_points,
division( balance , 7 , 4 ) as balance_division_7,
div( ceil( balance ), 2 ) as half_balance,
mod( ceil( balance ), 7 ) as reminder_balance,
abs( balance - 30000 ) as deviation,
round( division( balance, 7, 4 ),2 ) as round_balance,
ceil( division( balance, 7, 4 ) ) as round_up,
floor( division( balance, 7, 4 ) ) as round_down,
 case
   when balance > 100000 then 'premium value'
   when balance > 50000 then 'high value'
   else 'low value'
   end as customer_type
from zvr_account into table @data(wa).

out->write( wa ).
endmethod.
ENDCLASS.
