CLASS zcl_motion_sensor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  EVENTS motion_Detected exporting value(ev_location) type string.

  methods trigger_motion importing value(iv_location) type string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_motion_sensor IMPLEMENTATION.

method trigger_motion.
raise event motion_detected exporting ev_location = iv_location.
endmethod.


ENDCLASS.
CLASS zcl_alarm_system DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  methods on_motion_detected for event motion_detected of zcl_motion_sensor importing ev_location.

  methods get_log returning value(rv_log) type string.

  PROTECTED SECTION.
  data mv_log type string.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_alarm_system IMPLEMENTATION.

method on_motion_detected.
mv_log = |warning! alarm: { ev_location }|.
endmethod.


method get_log.
rv_log = mv_log.
endmethod.

ENDCLASS.
CLASS zcl_alarm_runner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  interfaces if_oo_Adt_Classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_alarm_runner IMPLEMENTATION.

method if_oo_Adt_classrun~main.

data(pub) = new zcl_motion_sensor(  ).
data(sub)  = new zcl_alarm_system(  ).

set handler sub->on_motion_detected for pub.

pub->trigger_motion( iv_location = 'security room' ).

out->write( sub->get_log(  ) ).

endmethod.
ENDCLASS.
