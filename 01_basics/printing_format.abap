CLASS zcl_printing_format DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_printing_format IMPLEMENTATION.

method if_oo_adt_classrun~main.


"string literals ( | | ).
  DATA a type i value 10.
  data b type i value 20.
  out->write( |sum of { a } and { b } is { a + b } | ).

  DATA(score) = 85.
  out->write( |result: { COND #( WHEN score >= 50 THEN 'wuhuww' ELSE 'yukk' ) } | ).



"number formatting
  DATA text1 type p decimals 2 VALUE '12345.678921'.
  out->write( | NUMBER = RAW  { text1 number = raw } | ).
  out->write( | NUMBER = USER { text1 number = user } | ).
  out->write( | with 4 decimals: { text1 decimals = 3 } | ).


"date formatting
  DATA text2 type d VALUE '20260721'.
  out->write( | DATE = RAW (YYYYMMDD) { text2 DATE = RAW  }| ).
  out->write( | DATE = ISO (YYYY-MM-DD) { text2 DATE = ISO  }| ).
  out->write( | DATE = USER (MM/DD/YYYY) { text2 DATE = USER }| ).


"time formatting
 DATA text5 type t value '113044'.
 out->write(  |TIME = RAW { text5 TIME = RAW  }| ).
 out->write(  |TIME = iso { text5 TIME = ISO  }| ).
 out->write(  |TIME = user { text5 TIME = USER  }| ).


"Time stamp formatting
data(text6) = utclong_current( ).
out->write( |timestamp: { text6 TIMESTAMP = ISO TIMEZONE = 'UTC' } | ).



"alignment and padding
"width = n , align = left , align = right , align = center , pad = '.'
  DATA text3 type string value 'BTP '.
  out->write(  |[{ text3 width = 4 align = right pad = '*' }]| ).
  out->write(  |[{ text3 width = 8 align = center pad = '/' }]| ).



"case conversion
 DATA text4 type string value 'hello to you'.
 out->write( | { text4 case = upper }| ).
 out->write( | { text4 case = lower }| ).


"complex real world example date time
data(name) = 'vineya'.
data(login_time) = cl_abap_context_info=>get_system_time( ).
data(login_Date) = cl_abap_context_info=>get_system_date( ).
out->write(  |Hey,{ name case = upper } logged in at { login_time time = iso } on { login_date  date = iso }.| ).


endmethod.

ENDCLASS.
