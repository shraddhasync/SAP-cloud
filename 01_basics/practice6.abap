"non runner class

CLASS zcl_bonus_calculator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  "structure
  TYPES: begin of ty_employee,
         emp_id type i,
         emp_name type string,
         sales_amount type decfloat16,
         bonus type decfloat16,
         rating type string,
         end of ty_employee.

   "table type
   TYPES tt_employee type STANDARD table of ty_employee with default key.

   methods process_bonus importing value(iv_bonus_rate) TYPE decfloat16
                         changing value(ct_employee) type tt_employee.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bonus_calculator IMPLEMENTATION.

method process_bonus.

data wa type ty_employee.
loop AT ct_employee into wa.
if wa-sales_amount >= '10000.0'.
wa-bonus = wa-sales_amount * iv_bonus_rate.
wa-rating = 'top'.
elseif wa-sales_amount >= '5000.0'.
wa-bonus = wa-sales_amount * ( iv_bonus_rate / 2 ).
wa-rating = 'standard'.
else.
wa-bonus = '0.0'.
wa-rating = 'low'.
endif.
modify ct_employee from wa.
endloop.

endmethod.
ENDCLASS.












"runner class

CLASS zcl_bonus_calculator_run_cls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_Adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bonus_calculator_run_cls IMPLEMENTATION.

method if_oo_Adt_Classrun~main.

"connect the class to runner class
data(obj) = new zcl_bonus_Calculator(  ).

"simulate selection parameter/input
data p_bonus_rate TYPE decfloat16 value '0.10'.

"declare table
data it_tab TYPE zcl_bonus_Calculator=>tt_employee.

it_tab = value #(
                ( emp_id = 101 emp_name = '   alex smith   ' sales_amount = '12000.0' bonus = '' rating =' ' )
                ( emp_id = 102 emp_name = '   brian lee  ' sales_amount = '6500.0' bonus = '' rating =' ' )
                ( emp_id = 103 emp_name = 'clara van' sales_amount = '3000.0' bonus = '' rating =' ' )
               ).

DATA wa TYPE zcl_bonus_calculator=>ty_employee.
loop AT it_tab into wa.
wa-emp_name = condense( to_upper( wa-emp_name ) ).
modify it_tab from wa.
endloop.

obj->process_bonus( exporting iv_bonus_rate = p_bonus_rate
                    changing ct_employee = it_tab ).

DATA wa2 TYPE zcl_bonus_calculator=>ty_employee.
loop AT it_tab into wa2.
out->write( |emp id: { wa2-emp_id }    name: { wa2-emp_name }     sales amount: { wa2-sales_Amount }     bonus: { wa2-bonus }     rating: { wa2-rating } | ).
endloop.

DATA payout_month TYPE i value 1.
while payout_month <= 3.
out->write( |Bonus installment payout month: { payout_month } | ).
payout_month = payout_month + 1.
endwhile.
endmethod.
ENDCLASS.
