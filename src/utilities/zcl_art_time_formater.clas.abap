CLASS zcl_art_time_formater DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      "! Formats seconds into a string with the format h:MM:SS (e.g. 1:24:59)
      make_human_readable_time_code
        IMPORTING
          i_seconds       TYPE int8
        RETURNING
          VALUE(r_output) TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_time_formater IMPLEMENTATION.


  METHOD make_human_readable_time_code.
    CONSTANTS:
      co_hour   TYPE int4 VALUE 3600,
      co_minute TYPE int4 VALUE 60.

    DATA(hours) = i_seconds DIV co_hour.
    DATA(minutes) = ( i_seconds - ( hours * co_hour ) ) DIV co_minute.
    DATA(seconds) = ( i_seconds - ( hours * co_hour ) - ( minutes * co_minute ) ).
    r_output = |{ hours }:{ minutes PAD = '0' WIDTH = 2 ALIGN = RIGHT }:{ seconds PAD = '0' WIDTH = 2 ALIGN = RIGHT }|.
  ENDMETHOD.
ENDCLASS.
