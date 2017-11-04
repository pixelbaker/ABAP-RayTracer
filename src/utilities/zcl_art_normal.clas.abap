CLASS zcl_art_normal DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    DATA:
      x TYPE decfloat16 READ-ONLY,
      y TYPE decfloat16 READ-ONLY,
      z TYPE decfloat16 READ-ONLY.


    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_normal,

      new_unified
        IMPORTING
          i_value           TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_normal,

      new_individual
        IMPORTING
          i_x               TYPE decfloat16
          i_y               TYPE decfloat16
          i_z               TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_normal,

      new_copy
        IMPORTING
          i_normal          TYPE REF TO zcl_art_normal
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_normal,

      new_from_vector
        IMPORTING
          i_vector          TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_normal.


    METHODS:
      normalize,

      assignment_by_normal
        IMPORTING
          i_normal        TYPE REF TO zcl_art_normal
        RETURNING
          VALUE(r_normal) TYPE REF TO zcl_art_normal,

      assignment_by_vector
        IMPORTING
          i_vector        TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_normal) TYPE REF TO zcl_art_normal.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_x TYPE decfloat16
          i_y TYPE decfloat16
          i_z TYPE decfloat16.

ENDCLASS.



CLASS zcl_art_normal IMPLEMENTATION.


  METHOD assignment_by_normal.
    r_normal = me.

    IF me = i_normal.
      RETURN.
    ENDIF.

    x = i_normal->x.
    y = i_normal->y.
    z = i_normal->z.
  ENDMETHOD.


  METHOD assignment_by_vector.
    x = i_vector->x.
    y = i_vector->y.
    z = i_vector->z.

    r_normal = me.
  ENDMETHOD.


  METHOD constructor.
    me->x = i_x.
    me->y = i_y.
    me->z = i_z.
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #(
      i_x = i_normal->x
      i_y = i_normal->y
      i_z = i_normal->z ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = new_unified( 0 ).
  ENDMETHOD.


  METHOD new_from_vector.
    r_instance = NEW #(
      i_x = i_vector->x
      i_y = i_vector->y
      i_z = i_vector->z ).
  ENDMETHOD.


  METHOD new_individual.
    r_instance = NEW #(
      i_x = i_x
      i_y = i_y
      i_z = i_z ).
  ENDMETHOD.


  METHOD new_unified.
    r_instance = NEW #(
      i_x = i_value
      i_y = i_value
      i_z = i_value ).
  ENDMETHOD.


  METHOD normalize.
    "Convert normal to a unit normal

    DATA length TYPE decfloat16.
    length = sqrt( x * x + y * y + z * z ).
    x = x / length.
    y = y / length.
    z = z / length.
  ENDMETHOD.
ENDCLASS.
