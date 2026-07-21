CLASS zcl_date_time DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_date_time IMPLEMENTATION.

 method if_oo_adt_classrun~main.

 "current date
 data(date1) = cl_abap_context_info=>get_system_Date( ).
 out->write( | { date1 date = user } | ).




 "display year month date
 DATA month type i.
 month = date1+4(2).

 data year type i.
 year = date1+0(4).

 data date type i.
 date = date1+6(2).

 out->write( | year: { year } date: { date } month: { month } | ).





 "add days to date
 date1 = date1 + 10.



 "diff of days btw dates.
 data d1 type d value '20260721'.
 data d2 type d value '20260724'.

 DATA diff_days type i.
 diff_Days = d2 - d1.
 out->write( diff_Days ).




 "comparison of dates
 data d3 type d value '20260721'.
 data d4 type d value '20260724'.

if d4 > d3 .
 out->write( |yes| ).
endif.



"time
DATA curr_time type t.
DATA newtime type t.

curr_time = cl_abap_context_info=>get_system_time( ).
newtime   = cl_abap_context_info=>get_system_time( ).

out->write( |current time: { curr_time time = iso } | ).



"add 1 hour (3600 seconds) - if you add subtract anything it will happen in 'seconds' unit
curr_time = curr_time + 3600.
out->write( | { curr_time time = iso } | ).



"subtract both time
data(seconds_res) = curr_time - newtime.
out->write( seconds_res ).





"time stamps
DATA(curr_timest) = utclong_current(  ).

"add days to time stamp
curr_timest = utclong_add( val = curr_timest days = 7 ).
out->write(  | added days in timestamp: { curr_timest timestamp = iso } | ).

"subtract time stamp
DATA difff_sec type i.
curr_timest = utclong_add( val = curr_timest days = 7 ).
difff_sec = utclong_diff( high = curr_timest low = curr_timest ).
out->write( | diff of seconds is: { difff_sec } | ).


        
        


 endmethod.
ENDCLASS.
