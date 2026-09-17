CLASS zcl_sql_date_time_func DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_date_time_func IMPLEMENTATION.

method if_oo_Adt_classrun~main.

"ADD_dAYS()   ADD_MONTHS()    DAYS_BETWEEN()
data(today_Date) = cl_abap_context_info=>get_system_date(  ).

select join_Date, add_days( join_Date , 7 ) as join_date_plus_7days ,
add_months( join_Date , 3 ) as join_date_plus_3months ,
days_between( join_date , @today_Date ) as current_date_minus_join_Date
from zvr_customer into table @data(wa).

out->write( wa ).





"EXTRACT_YEAR()    EXTRACT_MONTH()    EXTRACT_DAY()
select join_Date, extract_year( join_Date ) as join_year,
extract_month( join_Date ) as join_month,
extract_Day( join_Date ) as join_Day
from zvr_customer into table @data(wa2).

out->write( wa2 ).






"GROUPING BY YEAR
select extract_year( join_Date ) as join_year ,count( * ) as customer_count from zvr_customer GROUP BY extract_year( join_date ) into table @data(wa3).
out->write( wa3 ).
endmethod.
ENDCLASS.
