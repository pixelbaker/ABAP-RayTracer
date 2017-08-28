CLASS zcl_art_normal DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      x TYPE decfloat16 READ-ONLY,
      y TYPE decfloat16 READ-ONLY,
      z TYPE decfloat16 READ-ONLY.

    METHODS:
      normalize,

      assignment_by_vector
        IMPORTING
          i_vector TYPE REF TO zcl_art_vector3d.


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


  METHOD assignment_by_vector.
    x = i_vector->x.
    y = i_vector->y.
    z = i_vector->z.
  ENDMETHOD.

ENDCLASS.
