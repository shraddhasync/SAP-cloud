INTERFACE zif_hotel_room
  PUBLIC .

  methods get_nightly_rate returning value(rv_rate) type decfloat16.
  methods get_room_type returning value(rv_type) type string.
  methods get_room_number returning value(rv_number) type i.

ENDINTERFACE.
CLASS zcl_hotel_roomm DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces zif_hotel_room.

  methods constructor importing value(iv_room_number) type i
                                value(iv_base_rate) type decfloat16.


  PROTECTED SECTION.
  DATA mv_room_number type i.
  data mv_base_rate TYPE decfloat16.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hotel_roomm IMPLEMENTATION.

method constructor.
mv_room_number = iv_room_number.
mv_base_rate = iv_base_rate.
endmethod.

method zif_hotel_room~get_nightly_rate.
rv_rate = mv_base_rate.
endmethod.

method zif_hotel_room~get_room_type.
rv_type = 'standard'.
endmethod.

method zif_hotel_room~get_room_number.
rv_number = mv_room_number.
endmethod.

ENDCLASS.
CLASS zcl_suite_roomm DEFINITION
  PUBLIC
  FINAL
  inheriting from zcl_hotel_roomm
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods constructor importing value(iv_room_number) type i
                                value(iv_base_rate) type decfloat16
                                value(iv_has_jacuzzi) TYPE abap_bool.

  methods zif_hotel_room~get_nightly_rate redefinition.

  methods zif_hotel_room~get_room_type redefinition.



  PROTECTED SECTION.
  DATA mv_has_jacuzzi TYPE abap_bool.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_suite_roomm IMPLEMENTATION.

method constructor.
super->constructor( iv_room_number = iv_room_number iv_base_rate = iv_base_rate ).
mv_has_jacuzzi = iv_has_jacuzzi.
endmethod.

method zif_hotel_room~get_nightly_rate.
if mv_has_jacuzzi = abap_true.
rv_Rate = mv_base_rate + '50.0'.
else.
rv_Rate = mv_base_rate.
endif.
endmethod.

method zif_hotel_room~get_room_type.
rv_type = 'suite'.
endmethod.

ENDCLASS.
CLASS zcl_hotel_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hotel_runner IMPLEMENTATION.

method if_oo_adt_Classrun~main.

types:begin of ty_room,
      room_number type i,
      room_type TYPE string,
      final_Rate type decfloat16,
      end of ty_room.

data it_tab_obj type STANDARD table of ty_room WITH default key.
DATA it_tab_ref type STANDARD table of ref to zif_hotel_room  with default key.

data(room1) = new zcl_hotel_roomm( iv_room_number = 001 iv_base_Rate = '100.0' ).
data(room2) = new zcl_suite_roomm( iv_room_number = 002 iv_base_Rate = '200.0' iv_has_jacuzzi = abap_true ).

append room1 to it_tab_ref.
APPEND room2 to it_tab_ref.


loop AT it_tab_ref into data(item).
data wa type ty_room.
wa-final_rate = item->get_nightly_rate(  ).
wa-room_type = item->get_room_type( ).
wa-room_number = item->get_room_number(  ).
append wa to it_tab_obj.
endloop.

out->write( it_tab_obj ).

endmethod.
ENDCLASS.
