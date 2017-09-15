CLASS zcl_art_point3d DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    DATA:
      x TYPE decfloat16,
      y TYPE decfloat16,
      z TYPE decfloat16.


    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_point3d,

      new_unified
        IMPORTING
          VALUE(i_value)    TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_point3d,

      new_individual
        IMPORTING
          VALUE(i_x)        TYPE decfloat16
          VALUE(i_y)        TYPE decfloat16
          VALUE(i_z)        TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_point3d,

      new_copy
        IMPORTING
          REFERENCE(i_point) TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_instance)  TYPE REF TO zcl_art_point3d.


    METHODS:
      get_difference_from_point
        IMPORTING
          i_point         TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      get_difference_from_vector
        IMPORTING
          i_vector       TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point3d,

      get_sum_by_vector
        IMPORTING
          i_vector       TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point3d,

      assignment
        IMPORTING
          REFERENCE(i_point) TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_point)     TYPE REF TO zcl_art_point3d.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          VALUE(i_x) TYPE decfloat16
          VALUE(i_y) TYPE decfloat16
          VALUE(i_z) TYPE decfloat16.

ENDCLASS.



CLASS zcl_art_point3d IMPLEMENTATION.


  METHOD assignment.
    ASSERT i_point IS BOUND.
    r_point = me.
    CHECK i_point <> me.

    me->x = i_point->x.
    me->y = i_point->y.
    me->z = i_point->z.
  ENDMETHOD.


  METHOD constructor.
    x = i_x.
    y = i_y.
    z = i_z.
  ENDMETHOD.


  METHOD get_difference_from_point.
    "vector joining two points

    r_vector = zcl_art_vector3d=>new_individual(
      i_x = x - i_point->x
      i_y = y - i_point->y
      i_z = z - i_point->z ).
  ENDMETHOD.


  METHOD get_difference_from_vector.
    r_point = new_individual(
      i_x = x - i_vector->x
      i_y = y - i_vector->y
      i_z = z - i_vector->z ).
  ENDMETHOD.


  METHOD get_sum_by_vector.
    r_point = new_individual(
      i_x = x + i_vector->x
      i_y = x + i_vector->y
      i_z = x + i_vector->z ).
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_point IS BOUND.

    r_instance = NEW #(
      i_x = i_point->x
      i_y = i_point->y
      i_z = i_point->z ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = new_unified( 0 ).
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
ENDCLASS.
