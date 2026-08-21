"program1:

CLASS zcl_employee_processor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  "structure
  types: begin OF ty_Student,
         stu_id type i,
         stu_name type string,
         stu_score type decfloat16,
         end of ty_student.

   "table type
   types ty_it_student type standard table of ty_student with default key. "standard table must have default key

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_employee_processor IMPLEMENTATION.

method if_oo_adt_classrun~main.

 "table
 DATA it_student type ty_it_student.

 "work area
 DATA wa TYPE ty_Student.

 it_student  = value #(
                      ( stu_id = 101 stu_name = 'shrud' stu_score = '100.0' )
                      ( stu_id = 102 stu_name = 'vish' stu_score = '30.0' )
                      ( stu_id = 103 stu_name = 'prathna' stu_score = '87.0' )
                      ).

 loop at it_student into wa where stu_score >= '50.0'.
    out->write( |name: { wa-stu_name }      score: { wa-stu_score } | ).
 endloop.

endmethod.

ENDCLASS.
