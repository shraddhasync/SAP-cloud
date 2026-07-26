CLASS zcl_loop DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_loop IMPLEMENTATION.

method if_oo_adt_classrun~main.

"IF ELSE
 data(score) = 78.

 IF score >= 90.
  out->write(  'grade A' ).
  ELSEIF score >= 75.
   out->write(  'grade B' ).
  ELSEIF score >= 50.
   out->write(  'grade C' ).
  ELSE.
   out->write(  'failed' ).
 endif.



"CASE WHEN
 DATA(day) = 'sat'.

 CASE day.
  WHEN 'mon' OR 'tues' OR 'wednes' OR 'thurs' OR  'fri'.
   out->write( 'weekday' ).
  WHEN 'sat' OR 'sun'.
   out->write( 'weekend' ).
  WHEN OTHERS.
   out->write( 'invalid day').
  ENDCASE.


"LOOP
"DO ENDDO LOOP
data(sum) = 0.

DO 10 TIMES.

IF sum >= 20.
 out->write( | sum: { sum } | ).
 EXIT.
ELSE.
 IF sy-index mod 2 <> 0.
  continue.
 ELSE.
  sum = sum + sy-index.
  OUT->WRITE( |index is: { sy-index }, sum is: { sum } | ).
 ENDIF.
ENDIF.

ENDDO.




"WHILE LOOP
data(fact) = 5.
data(counter) = 1.

WHILE counter < 5.
 counter = counter * sy-index.
 out->write( counter ).
ENDWHILE.



"LOOP AT  - loop on internal table.
DATA inttab1 TYPE STANDARD TABLE OF i WITH EMPTY KEY.
inttab1 = VALUE #( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ).

LOOP AT inttab1 INTO DATA(val).

CHECK val MOD 2 = 0. "even digits
 out->write( |val: { val } | ).

ENDLOOP.



endmethod.
ENDCLASS.
