CLASS zcl_string_func DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_Adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_string_func IMPLEMENTATION.

method if_oo_Adt_classrun~main.

  data: text1 type string value 'welcome to SAP ABAP World'.

  "length of string
  out->write( |length of { text1 } is { strlen( text1 ) } | ).

  "character count
  out->write( | { numofchar( text1 ) } | ).

  "position of substring
  out->write( | { find( val = text1 sub = 'SAP' ) } | ).

  "find any of character's first occurrence
  out->write( | { find_any_of( val = text1 sub = 'ABC' ) }| ).

  "count of substring
  out->write( | { count( val = text1 sub = 'AB' ) } | ).




  DATA text2 type string value 'welcome to SAP ABAP World'.
  DATA res type string.

  "lower case
  out->write( | { to_lower( text2 ) } | ).

  "upper case
  out->write( | { to_upper( text2 ) } | ).

  "mixed case
  out->write( | { to_mixed( text2 ) } | ).

  "condense- removes all spaces
  out->write( | { condense( text2 ) } | ).

  "substring
  out->write( | { substring( val = text2 off = 3 len = 7 ) } | ).

  "substring after
  out->write( | { substring_After( val = text2 sub = 'to' ) }| ).

  "substring before
  out->write( | { substring_before( val = text2 sub = 'SAP' ) }| ).

  "replace first occurrence
  out->write( | { replace( val = text2 sub = 'ABAP' with = 'HANA' ) } | ).

  "also, replace first occurrence
  replace first occurrence of 'ABAP' in text2 with 'Universe'.
  out->write( text2 ).

  "replace all occurrence
  REPLACE all OCCURRENCES of 'World' in text2 with 'Universe'.
  out->write( text2 ).

  "repeat
  DATA ress type string.
  ress = repeat(  val = 'AB' occ = 3 ).
  out->write( ress ).



DATA text3 type string value 'Welcome to the SAP ABAP World'.

"contains substring- CS(contains substring)
if text3 CS 'SAP'.
  out->write( 'it does' ).
endif.

"not contains substring- NS(not contains substring)
if text3 CN 'SAP'.
  out->write( 'it does not' ).
endif.

"Contains only given all characters,could be in different sequence- CO(contains only)
if text3 CO 'SAPA B'.
 out->write( 'it contains all characters' ).
endif.

"not contains only given all characters- CN(contains not only)
if text3 CO 'SAPA B'.
 out->write( 'it does not contains all characters' ).
endif.

"contains any of character or characters- CA(contains any)
if text3 CA 'ABC'.
 out->write( 'it does ' ).
endif.

"not contains any of character or characters- CA(not contains any)
if text3 CA 'ABC'.
 out->write( 'it does not' ).
endif.

"check if string empty- IS INITIAL
if text3 IS INITIAL.
 out->write( 'it is empty' ).
endif.

"check if string not empty- IS NOT INITIAL
if text3 IS NOT INITIAL.
 out->write( 'it is empty' ).
endif.


endmethod.

ENDCLASS.
