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
          VALUE(i_value)    TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d,

      new_individual
        IMPORTING
          VALUE(i_x)        TYPE decfloat16
          VALUE(i_y)        TYPE decfloat16
          VALUE(i_z)        TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_vector3d,

      new_copy
        IMPORTING
          REFERENCE(i_vector) TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_instance)   TYPE REF TO zcl_art_vector3d,

      new_from_normal
        IMPORTING
          REFERENCE(i_normal) TYPE REF TO zcl_art_normal
        RETURNING
          VALUE(r_instance)   TYPE REF TO zcl_art_vector3d,

      new_from_point
        IMPORTING
          REFERENCE(i_point) TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_instance)  TYPE REF TO zcl_art_vector3d.


    METHODS:
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
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_vector3d IMPLEMENTATION.
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
    r_instance = NEW #( ).
    r_instance->x = i_vector->x.
    r_instance->y = i_vector->y.
    r_instance->z = i_vector->z.
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.


  METHOD new_from_normal.
    r_instance = NEW #( ).
    r_instance->x = i_normal->x.
    r_instance->y = i_normal->y.
    r_instance->z = i_normal->z.
  ENDMETHOD.


  METHOD new_from_point.
    r_instance = NEW #( ).
    r_instance->x = i_point->x.
    r_instance->y = i_point->y.
    r_instance->z = i_point->z.
  ENDMETHOD.

  METHOD new_individual.
    r_instance = NEW #( ).
    r_instance->x = i_x.
    r_instance->y = i_y.
    r_instance->z = i_z.
  ENDMETHOD.

  METHOD new_unified.
    r_instance = NEW #( ).
    r_instance->x = r_instance->y = r_instance->z = i_value.
  ENDMETHOD.
ENDCLASS.
