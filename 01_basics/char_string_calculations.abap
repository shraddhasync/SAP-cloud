CLASS zcl_char_string_calculations DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_char_string_calculations IMPLEMENTATION.

 method if_oo_adt_classrun~main.

 DATA: a_char type c length 10 value 'ABAP',
       a_string type string value 'learning abap on btp',
       a_date type d value '20290721',
       a_time type t value '081530'.

       "string length
       out->write( |length of { a_char } is { strlen( a_Char ) } | ).

       "update data
       a_char = 'shruds'.
       out->write( | { a_char } | ).

       "concatenation
       DATA b_char type c length 10 value 'platform'.
       data sep type c length 2 value '**'.
       concatenate a_String b_char into a_string separated by sep.
       out->write( | { a_String } | ).


"string operations

       DATA: tex1 TYPE string value 'SAP',
             tex2 type string value 'ABAP',
             tex3 TYPE string.

             "concatenation
             tex3 = tex1 && tex2.
             out->write( tex3 ).

             "substring by offset and length
             tex3 = tex3+3(4).
             out->write(  tex3 ).


 endmethod.
ENDCLASS.
