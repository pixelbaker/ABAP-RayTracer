CLASS zcl_art_point3d DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      x TYPE decfloat16 READ-ONLY,
      y TYPE decfloat16 READ-ONLY,
      z TYPE decfloat16 READ-ONLY.

    METHODS:
      constructor
        IMPORTING
          VALUE(i_value)     TYPE decfloat16 OPTIONAL
          VALUE(i_x)         TYPE decfloat16 OPTIONAL
          VALUE(i_y)         TYPE decfloat16 OPTIONAL
          VALUE(i_z)         TYPE decfloat16 OPTIONAL
          REFERENCE(i_point) TYPE REF TO zcl_art_point3d OPTIONAL,

      subtract_point
        IMPORTING
          i_point         TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      subtract_vector
        IMPORTING
          i_vector       TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point3d.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ART_POINT3D IMPLEMENTATION.


  METHOD constructor.
    IF i_value IS SUPPLIED.
      x = y = z = i_value.
      RETURN.
    ENDIF.


    IF i_x IS SUPPLIED OR
       i_y IS SUPPLIED OR
       i_z IS SUPPLIED.

      ASSERT i_x IS SUPPLIED AND i_y IS SUPPLIED AND i_z IS SUPPLIED.

      x = i_x.
      y = i_y.
      z = i_z.
      RETURN.
    ENDIF.


    IF i_point IS SUPPLIED.
      ASSERT i_point IS BOUND.

      x = i_point->x.
      y = i_point->y.
      z = i_point->z.
      RETURN.
    ENDIF.


    x = y = z = '0.0'.
  ENDMETHOD.


  METHOD subtract_point.
    "vector joining two points

    CREATE OBJECT r_vector
      EXPORTING
        i_x = x - i_point->x
        i_y = y - i_point->y
        i_z = z - i_point->z.
  ENDMETHOD.


  METHOD subtract_vector.
    CREATE OBJECT r_point
      EXPORTING
        i_x = x - i_vector->x
        i_y = y - i_vector->y
        i_z = z - i_vector->z.
  ENDMETHOD.
ENDCLASS.
