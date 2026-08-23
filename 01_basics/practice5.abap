"non runner class

CLASS zcl_course_manager_runner_cls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_course_manager_runner_cls IMPLEMENTATION.

method if_oo_adt_Classrun~main.

data p_passing_Score type decfloat16 value '60.0'.

data(obj) = new zcl_course_manager(  ).

DATA it_tab type zcl_course_manager=>tt_students.

it_tab = value #(
                ( student_id = 101 student_name = '   john doe  ' score = '75.0' status = '' )
                ( student_id = 102 student_name = 'mary jane'     score = '45.0' status = '' )
                ( student_id = 103 student_name = '   sam wilson' score = '82.0' status = '' )
                ).

DATA wa type zcl_course_manager=>ty_student.
LOOP AT it_tab into wa.
wa-student_name = condense( to_upper( wa-student_name ) ).
modify it_tab from wa.
endloop.

obj->evaluate_grades( exporting iv_passing_score = p_passing_Score
                      changing ct_students = it_tab ).

DATA wa2 type zcl_course_manager=>ty_student.
LOOP AT it_tab into wa.
out->write( |name: { wa-student_name }   score:{ wa-score }   status:{ wa-Status } | ).
endloop.

out->write( | average score: { obj->calculate_average_score( it_tab ) } | ).

DATA days_left type i value 5.
while days_left > 0.
out->write( |days remaining: { days_left } | ).
days_left = days_left - 1.
endwhile.


endmethod.
ENDCLASS.












"runner class

CLASS zcl_course_manager_runner_cls DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_course_manager_runner_cls IMPLEMENTATION.

method if_oo_adt_Classrun~main.

data p_passing_Score type decfloat16 value '60.0'.

data(obj) = new zcl_course_manager(  ).

DATA it_tab type zcl_course_manager=>tt_students.

it_tab = value #(
                ( student_id = 101 student_name = '   john doe  ' score = '75.0' status = '' )
                ( student_id = 102 student_name = 'mary jane'     score = '45.0' status = '' )
                ( student_id = 103 student_name = '   sam wilson' score = '82.0' status = '' )
                ).

DATA wa type zcl_course_manager=>ty_student.
LOOP AT it_tab into wa.
wa-student_name = condense( to_upper( wa-student_name ) ).
modify it_tab from wa.
endloop.

obj->evaluate_grades( exporting iv_passing_score = p_passing_Score
                      changing ct_students = it_tab ).

DATA wa2 type zcl_course_manager=>ty_student.
LOOP AT it_tab into wa.
out->write( |name: { wa-student_name }   score:{ wa-score }   status:{ wa-Status } | ).
endloop.

out->write( | average score: { obj->calculate_average_score( it_tab ) } | ).

DATA days_left type i value 5.
while days_left > 0.
out->write( |days remaining: { days_left } | ).
days_left = days_left - 1.
endwhile.


endmethod.
ENDCLASS.
