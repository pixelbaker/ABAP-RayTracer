CLASS zcl_art_vector3d DEFINITION
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
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d,

      new_unified
        IMPORTING
          i_value           TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d,

      new_individual
        IMPORTING
          i_x               TYPE decfloat16
          i_y               TYPE decfloat16
          i_z               TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d,

      new_copy
        IMPORTING
          i_vector          TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d,

      new_from_normal
        IMPORTING
          i_normal          TYPE REF TO zcl_art_normal
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d,

      new_from_point
        IMPORTING
          i_point           TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d.


    METHODS:
      assignment_by_vector
        IMPORTING
          i_vector        TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      get_dot_product_by_normal
        IMPORTING
          i_normal             TYPE REF TO zcl_art_normal
        RETURNING
          VALUE(r_dot_product) TYPE decfloat16,

      get_dot_product_by_vector
        IMPORTING
          i_vector             TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_dot_product) TYPE decfloat16,

      get_sum_by_vector
        IMPORTING
          i_vector        TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      get_product_by_decfloat
        IMPORTING
          i_value         TYPE decfloat16
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      get_quotient_by_decfloat
        IMPORTING
          i_value         TYPE decfloat16
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      "! Convert vector to a unit vector
      normalize.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_x TYPE decfloat16
          i_y TYPE decfloat16
          i_z TYPE decfloat16.

ENDCLASS.



CLASS ZCL_ART_VECTOR3D IMPLEMENTATION.


  METHOD assignment_by_vector.
    r_vector = me.
    IF me = i_vector.
      RETURN.
    ENDIF.

    me->x = i_vector->x.
    me->y = i_vector->y.
    me->z = i_vector->z.
  ENDMETHOD.


  METHOD constructor.
    me->x = i_x.
    me->y = i_y.
    me->z = i_z.
  ENDMETHOD.


  METHOD get_dot_product_by_normal.
    r_dot_product = x * i_normal->x + y * i_normal->y + z * i_normal->z.
  ENDMETHOD.


  METHOD get_dot_product_by_vector.
    r_dot_product = x * i_vector->x + y * i_vector->y + z * i_vector->z.
  ENDMETHOD.


  METHOD get_product_by_decfloat.
    r_vector = new_individual(
      i_x = x * i_value
      i_y = y * i_value
      i_z = z * i_value ).
  ENDMETHOD.


  METHOD get_quotient_by_decfloat.
    r_vector = new_individual(
      i_x = x / i_value
      i_y = y / i_value
      i_z = z / i_value ).
  ENDMETHOD.


  METHOD get_sum_by_vector.
    r_vector = new_individual(
      i_x = x + i_vector->x
      i_y = y + i_vector->y
      i_z = z + i_vector->z ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #(
      i_x = i_vector->x
      i_y = i_vector->y
      i_z = i_vector->z ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = new_unified( 0 ).
  ENDMETHOD.


  METHOD new_from_normal.
    r_instance = NEW #(
      i_x = i_normal->x
      i_y = i_normal->y
      i_z = i_normal->z ).
  ENDMETHOD.


  METHOD new_from_point.
    r_instance = NEW #(
      i_x = i_point->x
      i_y = i_point->y
      i_z = i_point->z ).
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
    DATA length TYPE decfloat16.
    length = sqrt( x * x + y * y + z * z ).
    x = x / length.
    y = y / length.
    z = z / length.
  ENDMETHOD.
ENDCLASS.
