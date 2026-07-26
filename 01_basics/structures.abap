CLASS zcl_structures DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_structures IMPLEMENTATION.

method if_oo_adt_classrun~main.

"structure
types: begin of ty_employee,
       emp_id type i,
       emp_name TYPE string,
       salary type p length 8 decimals 2,
       END of ty_employee.

DATA employee type ty_employee.

employee-emp_id = 1001.
employee-emp_name = 'shuds'.
employee-salary = '55000.50'.

out->write( | simple structure: { employee-emp_id } { employee-emp_name } salary: { employee-salary } | ).



"nested structure.
TYPES: begin OF ty_address,
       street type string,
       city type string,
       pincode type i,
       END of ty_address.

TYPES: begin of ty_details,
       detail TYPE ty_employee,
       address type ty_address,
       end of ty_details.
DATA info type ty_details.

info-detail-emp_id = 1002.
info-detail-emp_name = 'par'.
info-detail-salary = '78000.69'.

info-address-street ='main street 123'.
info-address-city = 'indore'.
info-address-pincode = 56473.

out->write( | nested structure: { info-detail-emp_id } { info-detail-emp_name } | ).
out->write( | address: { info-address-street } { info-address-city } { info-address-pincode } | ).
out->write( | salary: { info-detail-salary } | ).








endmethod.

ENDCLASS.
