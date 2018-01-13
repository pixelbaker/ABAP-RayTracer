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

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      _unit TYPE int4 VALUE 1024,
      _pre  TYPE string VALUE `KMGTPE`.

ENDCLASS.



CLASS zcl_art_byte_formater IMPLEMENTATION.
  METHOD make_human_readable_byte_count.
    IF i_bytes < _unit.
      r_output = |{ i_bytes } B|.
      RETURN.
    ENDIF.

    DATA exp TYPE int4.
    exp = log( i_bytes ) / log( _unit ).

    DATA(pos) = exp - 1.
    DATA(pre) = |{ _pre+pos(1) }i|.

    DATA float_value TYPE decfloat16.
    float_value = i_bytes / ( _unit ** exp ).

    r_output = |{ float_value DECIMALS = 1 } { pre }B|.
  ENDMETHOD.
ENDCLASS.
