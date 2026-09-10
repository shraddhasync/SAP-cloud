"logic class

CLASS zcl_person_validator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  methods check_age importing value(iv_age)  type i
                    raising zcx_invalid_age.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_person_validator IMPLEMENTATION.

method check_age.
if iv_age < 0 OR iv_age > 150.
 raise exception type zcx_invalid_age.
endif.
endmethod.
ENDCLASS.





















"runner class

CLASS zcl_exception_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_exception_runner IMPLEMENTATION.

method if_oo_Adt_Classrun~main.

data(validornot) = new zcl_person_validator(  ).

try.
 validornot->check_Age( 5 ).
   out->write( 'age is valid' ).

 catch zcx_invalid_age into data(error).
 out->write( | exception error: Age not valid | ).
endtry.
endmethod.
ENDCLASS.
