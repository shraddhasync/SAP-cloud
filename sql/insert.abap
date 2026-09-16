CLASS zcl_sql_insert DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_insert IMPLEMENTATION.

method if_oo_Adt_classrun~main.

delete from zvr_account.         "delete - delete help delete all data not structure or table.
delete from zvr_customer.
delete from zvr_customer_Arc.
delete from zvr_transaction.
commit work.                      "commit work - help to make changes permanent.

"insert single row
data wa type zvr_customer.
wa = VALUE #( customer_id = '000001' first_name = 'Amit'   last_name = 'Sharma'  dob = '19850215' city = 'Delhi' email_id = 'amit.sharma@gmail.com' join_date = '20200110' ).
insert zvr_customer from @wa.

if sy-subrc = 0.
out->write( 'success' ).
else.
out->write( 'failed' ).
endif.




"insert multiple row
data wa_table type standard table of zvr_customer.
wa_table = value #(
       ( customer_id = '000002' first_name = 'Priya'  last_name = 'Mehta'   dob = '19901123' city = 'Mumbai'   email_id = 'priya.mehta@hotmail.com' join_date = '20191220' )
      ( customer_id = '000003' first_name = 'Amit'  last_name = 'Verma'   dob = '19950312' city = 'Bangalore' email_id = 'rohan.verma@gmail.com' join_date = '20210315' )
      ( customer_id = '000004' first_name = 'Sneha'  last_name = 'Kapoor'  dob = '19880601' city = 'Delhi'     email_id = 'sneha.kapoor@yahoo.com' join_date = '20200205 ' )
      ( customer_id = '000005' first_name = 'Ankit'  last_name = 'Gupta'   dob = '19920707' city = 'Mumbai' email_id = 'ankit.gupta@gmail.com' join_date = '20200412' )
      ( customer_id = '000006' first_name = 'Neha'   last_name = 'Singh'   dob = '19981218' city = 'Chennai'  email_id = 'neha.singh@yahoo.com' join_date = '20210325' )
      ( customer_id = '000007' first_name = 'Rahul'  last_name = 'Jain'    dob = '19830409' city = 'Kolkata'  email_id = 'rahul.jain@gmail.com' join_date = '20191130' )
      ( customer_id = '000008' first_name = 'Ankit'  last_name = 'Gupta'   dob = '19940914' city = 'Kolkata' email_id = 'pooja.reddy@hotmail.com' join_date = '20210505' )
      ( customer_id = '000009' first_name = 'Karan'  last_name = 'Nair'    dob = '19871122' city = 'Jaipur'  email_id = 'karan.nair@yahoo.com'  join_date = '20200122' )
      ( customer_id = '000010' first_name = 'Sneha'  last_name = 'Iyer'    dob = '19960630' city = 'Jaipur'  email_id = 'divya.iyer@hotmail.com' join_date = '20210418' )
      ).
insert zvr_customer from table @wa_table.

if sy-subrc = 0.
out->write( 'success' ).
else.
out->write( 'failed' ).
endif.





data wa_table2 type standard table of zvr_transaction.
wa_table2 = value #(
  ( trans_id = '000000000001' account_id = '1000000001' trans_date = '20250901' trans_time = '101500' amount = '5000.00'   trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000002' account_id = '1000000001' trans_date = '20250902' trans_time = '113000' amount = '-2000.00'  trans_type = 'WITHDRAW'  currency_code = 'INR' )
      ( trans_id = '000000000003' account_id = '1000000002' trans_date = '20250903' trans_time = '093000' amount = '10000.00'  trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000004' account_id = '1000000002' trans_date = '20250903' trans_time = '160000' amount = '-5000.00'  trans_type = 'TRANSFER'  currency_code = 'INR' )
      ( trans_id = '000000000005' account_id = '1000000003' trans_date = '20250904' trans_time = '104500' amount = '2000.00'   trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000006' account_id = '1000000003' trans_date = '20250905' trans_time = '114000' amount = '-500.00'   trans_type = 'WITHDRAW'  currency_code = 'INR' )
      ( trans_id = '000000000007' account_id = '1000000004' trans_date = '20250906' trans_time = '090000' amount = '30000.00'  trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000008' account_id = '1000000004' trans_date = '20250907' trans_time = '170500' amount = '-10000.00' trans_type = 'WITHDRAW'  currency_code = 'INR' )
      ( trans_id = '000000000009' account_id = '1000000005' trans_date = '20250907' trans_time = '141000' amount = '75000.00'  trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000010' account_id = '1000000005' trans_date = '20250908' trans_time = '101500' amount = '-25000.00' trans_type = 'TRANSFER'  currency_code = 'INR' )
      ( trans_id = '000000000011' account_id = '1000000006' trans_date = '20250908' trans_time = '120000' amount = '1500.00'   trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000012' account_id = '1000000006' trans_date = '20250909' trans_time = '133500' amount = '-700.00'   trans_type = 'WITHDRAW'  currency_code = 'INR' )
      ( trans_id = '000000000013' account_id = '1000000007' trans_date = '20250909' trans_time = '091500' amount = '25000.00'  trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000014' account_id = '1000000007' trans_date = '20250909' trans_time = '180000' amount = '-5000.00'  trans_type = 'WITHDRAW'  currency_code = 'INR' )
      ( trans_id = '000000000015' account_id = '1000000008' trans_date = '20250910' trans_time = '101000' amount = '12000.00'  trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000016' account_id = '1000000008' trans_date = '20250910' trans_time = '153000' amount = '-4000.00'  trans_type = 'WITHDRAW'  currency_code = 'INR' )
      ( trans_id = '000000000017' account_id = '1000000001' trans_date = '20250911' trans_time = '110000' amount = '2000.00'   trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000018' account_id = '1000000002' trans_date = '20250911' trans_time = '143000' amount = '-3000.00'  trans_type = 'TRANSFER'  currency_code = 'INR' )
      ( trans_id = '000000000019' account_id = '1000000003' trans_date = '20250911' trans_time = '163000' amount = '500.00'    trans_type = 'DEPOSIT'   currency_code = 'INR' )
      ( trans_id = '000000000020' account_id = '1000000004' trans_date = '20250911' trans_time = '171500' amount = '-1500.00'  trans_type = 'WITHDRAW'  currency_code = 'INR' )
  ).



"we did not gave value to "trans_TS" so for this we will loop on wa_table 2 and use utclong(time+date+timezone) = timezone

data(timezo) = cl_abap_context_info=>get_user_time_zone( ).

LOOP at wa_table2 into data(item).
CONVERT date item-trans_Date time  item-trans_time time zone timezo INTO utclong item-trans_TS.
endloop.
insert zvr_transaction from table @wa_table2.

if sy-subrc = 0.
out->write( 'success' ).
else.
out->write( 'failed' ).
endif.





DATA wa_table3 type STANDARD TABLE of zvr_customer_arc.
wa_table3 = value #(
      ( customer_id = '000012' first_name = 'Ram'  last_name = 'Mehta'   dob = '19851123' city = 'Mumbai'   email_id = 'ram.mehta@hotmail.com' join_date = '20191220' )
      ( customer_id = '000013' first_name = 'Shyam'  last_name = 'Verma'   dob = '19970312' city = 'Bangalore' email_id = 'shyam.verma@gmail.com' join_date = '20210315' )
      ( customer_id = '000014' first_name = 'Hari'  last_name = 'Kapoor'  dob = '19890601' city = 'Delhi'     email_id = 'hari.kapoor@yahoo.com' join_date = '20200205 ' )
      ( customer_id = '000015' first_name = 'Vishal'  last_name = 'Gupta'   dob = '19940707' city = 'Mumbai' email_id = 'vishal.gupta@gmail.com' join_date = '20200412' )
      ( customer_id = '000006' first_name = 'Neha'   last_name = 'Singh'   dob = '19981218' city = 'Chennai'  email_id = 'neha.singh@yahoo.com' join_date = '20210325' )
      ( customer_id = '000007' first_name = 'Rahul'  last_name = 'Jain'    dob = '19830409' city = 'Kolkata'  email_id = 'rahul.jain@gmail.com' join_date = '20191130' )
      ( customer_id = '000008' first_name = 'Ankit'  last_name = 'Gupta'   dob = '19940914' city = 'Kolkata' email_id = 'pooja.reddy@hotmail.com' join_date = '20210505' )
      ( customer_id = '000009' first_name = 'Karan'  last_name = 'Nair'    dob = '19871122' city = 'Jaipur'  email_id = 'karan.nair@yahoo.com'  join_date = '20200122' )
      ( customer_id = '000010' first_name = 'Sneha'  last_name = 'Iyer'    dob = '19960630' city = 'Jaipur'  email_id = 'divya.iyer@hotmail.com' join_date = '20210418' )
      ).
insert zvr_customer_arc from table @wa_table3.

if sy-subrc = 0.
out->write( 'success' ).
else.
out->write( 'failed' ).
endif.






data wa_table4 type STANDARD table of zvr_account.
wa_table4 = value #(
( account_id = '1000000001' customer_id = '000001' account_type = 'SAVINGS' open_date = '20200115' balance = '45000.00'  currency_code = 'INR' )
      ( account_id = '1000000002' customer_id = '000002' account_type = 'CURRENT' open_date = '20200220' balance = '150000.00' currency_code = 'INR' )
      ( account_id = '1000000003' customer_id = '000003' account_type = 'SAVINGS' open_date = '20210320' balance = '5200.00'   currency_code = 'INR' )
      ( account_id = '1000000004' customer_id = '000004' account_type = 'SAVINGS' open_date = '20200210' balance = '78000.00'  currency_code = 'INR' )
      ( account_id = '1000000005' customer_id = '000005' account_type = 'CURRENT' open_date = '20200420' balance = '225000.00' currency_code = 'INR' )
      ( account_id = '1000000006' customer_id = '000006' account_type = 'SAVINGS' open_date = '20210330' balance = '9000.00'   currency_code = 'INR' )
      ( account_id = '1000000007' customer_id = '000007' account_type = 'SAVINGS' open_date = '20191210' balance = '110000.00' currency_code = 'INR' )
      ( account_id = '1000000008' customer_id = '000008' account_type = 'CURRENT' open_date = '20210515' balance = '30500.00'  currency_code = 'INR' )
      ( account_id = '1000000012' customer_id = '000012' account_type = 'CURRENT' open_date = '20210515' balance = '33500.00'  currency_code = 'INR' )
      ( account_id = '1000000013' customer_id = '000013' account_type = 'SAVINGS' open_date = '20210515' balance = '36500.00'  currency_code = 'INR' )
).
insert zvr_account from table @wa_table4.

if sy-subrc = 0.
out->write( 'success' ).
else.
out->write( 'failed' ).
endif.



endmethod.
ENDCLASS.
