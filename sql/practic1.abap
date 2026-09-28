CLASS zcl_sql_practice DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_practice IMPLEMENTATION.

method if_oo_Adt_Classrun~main.


**"SELECT
***select * from zvr_account into table @data(wa_table).
***out->write( wa_table ).
***
***select account_id , account_type, balance from zvr_account into table @data(wa_table2).
***out->write( wa_table2 ).
***
***
***
***
***"SELECT SINGLE
***select single * from zvr_transaction where trans_id = '0000000001' into @data(wa)  .
***out->write( wa ).
***
***
***
***
***"ORDER BY
***select trans_id, amount, trans_Date from zvr_transaction
***ORDER by amount descending
***into table @data(wa_orderby).
***out->write( wa_orderby ).
***
***
***"DISTINCT
***select distinct trans_type from zvr_transaction into table @data(wa_distinct).
***out->write( wa_distinct ).
***
***select distinct account_type from zvr_Account
***ORDER by account_type ascending
***into table @data(wa_order_distinct).
***
***out->write( wa_order_distinct ).
**
**
**
**
**"WHERE -and
**select trans_id, amount, trans_type from zvr_transaction
**where trans_type = 'WITHDRAW' AND amount < '-2000.00'
**into table @data(wa_where_and).
**
**"WHERE -between
**select account_id, account_type, open_Date from zvr_account
**where open_date between '20200101' and '20201231'
**into table @data(wa_where_between).
**
**"WHERE -like
**select customer_id, FIRST_name , LAST_name from zvr_customer
**where FIRST_name like 'A%'
**into table @data(wa_where_like).
*
*
*
*
*"Aggregate Functions - return single value
*select count( * ) from zvr_transaction into @data(count_of_rows).
*out->write( count_of_rows ).
*
*
*
*
*"GROUP BY
*select trans_type as transtype ,sum( amount ) as total from zvr_transaction
*GROUP by trans_type
*into table @data(wa_groupby).
*out->write( wa_groupby ).
*
*
*
*
*"HAVING
*select city as city, count( * ) as count from zvr_customer
*GROUP by  city
*having count( * ) > 1
*into table @data(wa_having).
*out->write( wa_having ).
*
*
*"CONCAT_WITH_SPACE(string1, string2, space count)
*select customer_id ,concat_with_space( first_name, last_name , 1 ) as full_name from zvr_customer into table @data(wa_concat).
*out->write( wa_Concat ).
*
*
*"LOWER()
*select customer_id, lower( email_id ) as email_lower from zvr_customer into table @data(Wa_lower).
*out->write( Wa_lower ).
*
*
*"SUBSTRING
*select customer_id, substring( city , 1, 3 ) as city_code from zvr_customer into table @data(wa_substring).
*out->write( Wa_substring ).
*
*
*"EXTRACT_YEAR()
*select account_id, open_Date ,extract_year( open_Date ) as open_year from zvr_Account into table @data(wa_extract_year).
*
*
*"DATS_ADD_DAYS( date , no.of days)
*select trans_id, trans_Date,dats_Add_days( trans_Date , 30 ) as due_Date from zvr_transaction into table @data(wa_add_days).
*
*
*"DATS_DAYS_BETWEEN( date , date )
*select account_id, dats_days_between( open_Date , dats`20260101` ) as between_Days  from zvr_account into table @data(wa_betweendays).
*
*
*
*"MATHEMATICAL OPERATION - abs( )
*select trans_id, amount, abs( amount ) * dec`0.18` as tax_amount from zvr_transaction into table @data(wa_operations).
*
*
*
*"CASE WHEN
*select account_id, balance ,
*CASE
* WHEN balance >= dec`10000.00` THEN 'HIGH'
* WHEN balance > dec`40000.00` AND balance < dec`99999.99` THEN 'MEDIUM'
* ELSE 'LOW'
* END as balance_Status
*from zvr_account into table @data(wa_casewhen).


"JOINS
select a~account_id, a~balance,c~first_name, c~city from zvr_Account as a
inner join zvr_customer as c
on a~customer_id = c~customer_id
into table @data(wa_innerjoin).


"left join
select c~first_name,c~last_name, a~account_id, a~balance from zvr_customer as c
left join zvr_Account as a
on c~customer_id = a~customer_id
into table @data(wa_leftjoin).


"3 table inner join
select t~trans_id,t~amount,a~account_type,c~first_name from zvr_transaction as t
inner join zvr_Account as a
on t~account_id = a~account_id
inner join zvr_customer as c
on a~customer_id = c~customer_id
into table @data(wa_3table_innerjoin).


endmethod.
ENDCLASS.
