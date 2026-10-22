"insert data in database table

CLASS zcl_fill_hotel_demo DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_fill_hotel_demo IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DELETE FROM zvr_hotel_demo.

    DATA hotel TYPE TABLE OF zvr_hotel_demo.

    hotel = VALUE #(
        ( booking_id = 'B001' customer_name = 'Alice Smith'    city = 'Paris'     hotel_name = 'Le Bristol'         price = '450.00' currency = 'EUR' )
        ( booking_id = 'B002' customer_name = 'Bob Jones'      city = 'New York'  hotel_name = 'The Plaza'          price = '750.00' currency = 'USD' )
        ( booking_id = 'B003' customer_name = 'Charlie Brown'  city = 'Tokyo'     hotel_name = 'Park Hyatt Tokyo'   price = '600.00' currency = 'JPY' )
        ( booking_id = 'B004' customer_name = 'Diana Prince'   city = 'London'    hotel_name = 'The Ritz London'    price = '550.00' currency = 'GBP' )
        ( booking_id = 'B005' customer_name = 'Ethan Hunt'     city = 'Sydney'    hotel_name = 'Park Hyatt Sydney'  price = '800.00' currency = 'AUD' )
        ).

    INSERT zvr_hotel_demo FROM TABLE @hotel.
    out->write( 'filled' ).
  ENDMETHOD.
ENDCLASS.
