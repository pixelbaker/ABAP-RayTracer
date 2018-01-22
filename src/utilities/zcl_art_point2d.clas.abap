CLASS zcl_art_point2d DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      x TYPE decfloat16,
      y TYPE decfloat16.

    METHODS:
      constructor
        IMPORTING
          i_x TYPE decfloat16 OPTIONAL
          i_y TYPE decfloat16 OPTIONAL.

ENDCLASS.



CLASS zcl_art_point2d IMPLEMENTATION.
  METHOD constructor.
    me->x = i_x.
    me->y = i_y.
  ENDMETHOD.
ENDCLASS.
