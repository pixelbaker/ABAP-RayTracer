CLASS zcl_art_ray DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      origin    TYPE REF TO zcl_art_point3d,
      direction TYPE REF TO zcl_art_vector3d.


    METHODS:
      constructor
        IMPORTING
          REFERENCE(i_ray)       TYPE REF TO zcl_art_ray OPTIONAL "copy constructor
          REFERENCE(i_origin)    TYPE REF TO zcl_art_point3d OPTIONAL "origin and dir
          REFERENCE(i_direction) TYPE REF TO zcl_art_vector3d OPTIONAL, "origin and dir

      assignment
        IMPORTING
          REFERENCE(i_rhs) TYPE REF TO zcl_art_ray
        RETURNING
          VALUE(r_ray)     TYPE REF TO zcl_art_ray.


  PROTECTED SECTION.
  PRIVATE SECTION.
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
    IF i_ray IS BOUND.
      me->origin = i_ray->origin.
      me->direction = i_ray->direction.
      RETURN.
    ENDIF.


    IF i_origin IS BOUND AND
       i_direction IS BOUND.
      me->origin = i_origin.
      me->direction = i_direction.
      RETURN.
    ENDIF.


    CREATE OBJECT me->origin.
    me->direction = zcl_art_vector3d=>new_default( ).
  ENDMETHOD.
ENDCLASS.
