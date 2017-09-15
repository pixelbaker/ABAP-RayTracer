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
      world           TYPE REF TO zcl_art_world.


    CLASS-METHODS:
      new_from_world
        IMPORTING
          REFERENCE(i_world) TYPE REF TO zcl_art_world
        RETURNING
          VALUE(r_instance)  TYPE REF TO zcl_art_shade_rec,

      new_copy
        IMPORTING
          REFERENCE(i_shade_rec) TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_instance)      TYPE REF TO zcl_art_shade_rec.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ART_SHADE_REC IMPLEMENTATION.


  METHOD new_copy.
    ASSERT i_shade_rec IS BOUND.

    r_instance = NEW #( ).
    r_instance->hit_an_object = i_shade_rec->hit_an_object.
    r_instance->local_hit_point = zcl_art_point3d=>new_copy( i_shade_rec->local_hit_point ).
    r_instance->color = zcl_art_rgb_color=>new_copy( i_shade_rec->color ).
    r_instance->world = i_shade_rec->world.
  ENDMETHOD.


  METHOD new_from_world.
    ASSERT i_world IS BOUND.

    r_instance = NEW #( ).
    r_instance->world = i_world.
    r_instance->hit_an_object = abap_false.
    r_instance->normal = NEW #( ).
    r_instance->local_hit_point = zcl_art_point3d=>new_default( ).
    r_instance->color = zcl_art_rgb_color=>new_copy( zcl_art_rgb_color=>black ).
  ENDMETHOD.
ENDCLASS.
