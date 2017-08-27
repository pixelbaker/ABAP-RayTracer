CLASS zcl_art_normal DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      x TYPE decfloat16,
      y TYPE decfloat16,
      z TYPE decfloat16.

    METHODS:
      normalize.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_normal IMPLEMENTATION.
  METHOD normalize.
    "Convert normal to a unit normal

    DATA length TYPE decfloat16.
    length = sqrt( x * x + y * y + z * z ).
    x = x / length.
    y = y / length.
    z = z / length.
  ENDMETHOD.

ENDCLASS.
