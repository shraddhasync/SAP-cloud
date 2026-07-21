CLASS zcl_print DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_print IMPLEMENTATION.

  method if_oo_adt_classrun~main.

      DATA nt1 type i value 40.
      DATA nt2 type i value -3.
      DATA nt3 type i value 20.
      DATA nt4 type i.
      DATA pac TYPE p length 6 decimals 2 value '1.23'.
      DATA ft TYPE f value '1.345'.
      DATA decft16 TYPE decfloat16 value '3.456'.
      DATA decft34 TYPE decfloat34 value '46.5678'.

      DATA type_descr type ref to cl_abap_typedescr.


      DATA res.
      res = nt1 + nt2.
      type_descr = cl_abap_typedescr=>describe_by_data( res ).
      out->write( |res type is: { type_descr->absolute_name } | ).



      DATA res3 type i.
      res3 = nt2 + decft34.
      type_descr = cl_abap_typedescr=>describe_by_data( res3 ).
      out->write( |res3 type is: { type_Descr->absolute_name } | ).


*compound assignment operators

      nt1 += 5.
      out->write( | { nt1 } | ).

      nt1 -= 5.
     out->write( | { nt1 } | ).

      nt1 *= 2.
      out->write( | { nt1 } | ).

      nt1 /= 2.
      out->write( | { nt1 } | ).


*built in mathematics function

      data(nt_abs) = abs( nt2 ).
      out->write( |absolute value: { nt_abs } | ).

      data(nt_sign) = sign( nt2 ).
      out->write( |sign: { nt_sign } | ).

      data(nt2_Sign) = sign( nt3 ).
      out->write( |sign: { nt2_sign } | ).

      DATA(nt_round) = round( val = decft34 dec = 2 ).
      out->write( |round: { nt_round } | ).

      data(nt_trunc) = trunc( decft34 ).
      out->write( |trunc value: { nt_trunc } | ).



  endmethod.
ENDCLASS.
