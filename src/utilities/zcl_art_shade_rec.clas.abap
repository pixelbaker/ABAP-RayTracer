CLASS zcl_art_shade_rec DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  " there is no default constructor as the World reference always has to be initialized
  " there is also no assignment operator as we don't want to assign the world
  " the copy constructor only copies the world reference
  " the ray tracer is written so that new ShadeRec objects are always constructed
  " using the first constructor or the copy constructor

  PUBLIC SECTION.
    DATA:
      hit_an_object   TYPE abap_bool,
      local_hit_point TYPE REF TO zcl_art_point3d,
      normal          TYPE REF TO zcl_art_normal,
      color           TYPE REF TO zcl_art_rgb_color,
      world           TYPE REF TO zcl_art_world READ-ONLY.


    CLASS-METHODS:
      new_from_world
        IMPORTING
          i_world           TYPE REF TO zcl_art_world
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_shade_rec,

      new_copy
        IMPORTING
          i_shade_rec       TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_shade_rec.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_hit_an_object   TYPE abap_bool
          i_local_hit_point TYPE REF TO zcl_art_point3d
          i_normal          TYPE REF TO zcl_art_normal
          i_color           TYPE REF TO zcl_art_rgb_color
          VALUE(i_world)    TYPE REF TO zcl_art_world.

ENDCLASS.



CLASS zcl_art_shade_rec IMPLEMENTATION.


  METHOD constructor.
    ASSERT i_local_hit_point IS BOUND AND
           i_normal IS BOUND AND
           i_color IS BOUND AND
           i_world IS BOUND.

    me->local_hit_point = i_local_hit_point.
    me->hit_an_object = i_hit_an_object.
    me->normal = i_normal.
    me->color = i_color.
    me->world = i_world.
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_shade_rec IS BOUND.

    r_instance = NEW #(
      i_world           = i_shade_rec->world
      i_hit_an_object   = i_shade_rec->hit_an_object
      i_normal          = zcl_art_normal=>new_copy( i_shade_rec->normal )
      i_color           = zcl_art_rgb_color=>new_copy( i_shade_rec->color )
      i_local_hit_point = zcl_art_point3d=>new_copy( i_shade_rec->local_hit_point ) ).
  ENDMETHOD.


  METHOD new_from_world.
    ASSERT i_world IS BOUND.

    r_instance = NEW #(
      i_world           = i_world
      i_hit_an_object   = abap_false
      i_normal          = zcl_art_normal=>new_default( )
      i_local_hit_point = zcl_art_point3d=>new_default( )
      i_color           = zcl_art_rgb_color=>new_copy( zcl_art_rgb_color=>black ) ).
  ENDMETHOD.
ENDCLASS.
