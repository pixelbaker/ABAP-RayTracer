CLASS zcl_art_ray DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    DATA:
      direction TYPE REF TO zcl_art_vector3d,
      origin    TYPE REF TO zcl_art_point3d.


    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_ray,

      new_copy
        IMPORTING
          REFERENCE(i_ray)  TYPE REF TO zcl_art_ray
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_ray,

      new_from_point_and_vector
        IMPORTING
          REFERENCE(i_direction) TYPE REF TO zcl_art_vector3d
          REFERENCE(i_origin)    TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_instance)      TYPE REF TO zcl_art_ray.


    METHODS:
      assignment
        IMPORTING
          REFERENCE(i_rhs) TYPE REF TO zcl_art_ray
        RETURNING
          VALUE(r_ray)     TYPE REF TO zcl_art_ray.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          REFERENCE(i_direction) TYPE REF TO zcl_art_vector3d
          REFERENCE(i_origin)    TYPE REF TO zcl_art_point3d.

ENDCLASS.



CLASS zcl_art_ray IMPLEMENTATION.
  METHOD assignment.
    IF me <> i_rhs.
      me->origin = i_rhs->origin.
      me->direction = i_rhs->direction.
    ENDIF.

    r_ray = me.
  ENDMETHOD.


  METHOD constructor.
    me->origin = i_origin.
    me->direction = i_direction.
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_ray IS BOUND.

    r_instance = NEW #(
      i_direction = zcl_art_vector3d=>new_copy( i_ray->direction )
      i_origin    = zcl_art_point3d=>new_copy( i_ray->origin ) ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #(
      i_direction = zcl_art_vector3d=>new_default( )
      i_origin    = zcl_art_point3d=>new_default( ) ).
  ENDMETHOD.


  METHOD new_from_point_and_vector.
    ASSERT i_direction IS BOUND AND
           i_origin IS BOUND.

    r_instance = NEW #(
      i_direction = zcl_art_vector3d=>new_copy( i_direction )
      i_origin    = zcl_art_point3d=>new_copy( i_origin ) ).
  ENDMETHOD.
ENDCLASS.
