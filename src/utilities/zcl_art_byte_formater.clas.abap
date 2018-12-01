CLASS zcl_art_byte_formater DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      make_human_readable_byte_count
        IMPORTING
          i_bytes         TYPE int8
        RETURNING
          VALUE(r_output) TYPE string.


  PRIVATE SECTION.
    CONSTANTS:
      _co_unit TYPE int4 VALUE 1024,
      _co_pre  TYPE string VALUE `KMGTPE`.

ENDCLASS.



CLASS zcl_art_byte_formater IMPLEMENTATION.


  METHOD make_human_readable_byte_count.
    IF i_bytes < _co_unit.
      r_output = |{ i_bytes } B|.
      RETURN.
    ENDIF.

    DATA exp TYPE int4.
    exp = log( i_bytes ) / log( _co_unit ).

    DATA(pos) = exp - 1.
    DATA(pre) = |{ _co_pre+pos(1) }i|.

    DATA float_value TYPE decfloat16.
    float_value = i_bytes / ( _co_unit ** exp ).

    r_output = |{ float_value DECIMALS = 1 } { pre }B|.
  ENDMETHOD.
ENDCLASS.
