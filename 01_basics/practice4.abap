"non runner class

CLASS zcl_customer_manager DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  "structure
  types: BEGIN OF ty_customers,
         cust_id type i,
         cust_name type string,
         balance TYPE decfloat16,
         status TYPE string,
         end of ty_customers.

  "table type
  TYPES tt_customers type STANDARD table of ty_customers with default key.

  methods apply_penalty importing value(iv_penalty_fee) type decfloat16
                        changing value(ct_customer) TYPE tt_customers.

  methods calculate_total_debt importing value(it_customer) type tt_customers
                               returning value(rv_total_debt) TYPE decfloat16.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_customer_manager IMPLEMENTATION.

method apply_penalty.
DATA wa TYPE ty_customers.
loop at ct_customer into wa where balance < '0.0'.
wa-balance =  wa-balance - iv_penalty_fee.
wa-status = 'overdue'.
modify ct_customer from wa.
endloop.
endmethod.

method calculate_total_debt.
DATA wa type ty_customers.
LOOP AT it_customer into wa where balance < '0.0'.
rv_total_Debt = rv_total_debt + wa-balance.
endloop.
endmethod.

ENDCLASS.

















"runner class

CLASS zcl_customer_manager_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_customer_manager_runner IMPLEMENTATION.
method if_oo_adt_classrun~main.

    DATA(obj) = new zcl_customer_manager(  ).
    DATA penalty_fee_input type decfloat16 VALUE '10.0'.

   "table
    DATA it_tab TYPE zcl_customer_manager=>tt_customers.

    it_tab = VALUE #(
                     ( cust_id = 101 cust_name = 'alice smith' balance = '-150.0' status = 'active' )
                     ( cust_id = 102 cust_name = 'bob jones'   balance = '300.0' status = 'active' )
                     ( cust_id = 103 cust_name = 'charlie'     balance = '-50.0'  status = 'active' )
                    ).

    data wa TYPE zcl_customer_manager=>ty_customers.
    LOOP AT it_tab into wa.
     wa-cust_name = condense( to_upper( wa-cust_name ) ).
     modify it_tab from wa.
    endloop.

    out->write( |total debt: { obj->calculate_total_debt( it_tab ) } | ).
    obj->apply_penalty( exporting iv_penalty_fee = penalty_fee_input
                        changing ct_customer = it_tab ).

    DATA wa2 TYPE zcl_customer_manager=>ty_customers.
    LOOP AT it_tab into wa2.
     out->write( |cust_name: { wa2-cust_name }     balance: { wa2-balance }      status: { wa2-status } | ).
    endloop.

    data lv_outstanding type decfloat16 VALUE '200.0'.
    DATA lv_monthly_pay type decfloat16 value '45.0'.
    data lv_months type i value 0.

    while lv_outstanding > '0.0'.
    lv_outstanding = lv_outstanding - lv_monthly_pay.
    lv_months = lv_months + 1.
    endwhile.

    out->write( |months: { lv_months } | ).
endmethod.
ENDCLASS.
