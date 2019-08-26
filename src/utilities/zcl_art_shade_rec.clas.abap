"! There is no default constructor as the World reference always has to be initialized.
"! There is also no assignment operator as we don't want to assign the world.
"! The copy constructor only copies the world reference.
"! The ray tracer is written so that new ShadeRec objects are always constructed
"! using the first constructor or the copy constructor
CLASS zcl_art_shade_rec DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.


  PUBLIC SECTION.
    DATA:
      "! did the ray hit an object?
      hit_an_object   TYPE abap_bool,

      "! Nearest object's material
      material        TYPE REF TO zcl_art_material,

      "! world coordinates of intersection
      hit_point       TYPE REF TO zcl_art_point3d,

      "! world coordinates of hit point on untransformed object (used for texture transformations)
      local_hit_point TYPE REF TO zcl_art_point3d,

      "! normal at hit point
      normal          TYPE REF TO zcl_art_normal,

      "! used in the Chapter 3 only
      color           TYPE REF TO zcl_art_rgb_color,

      "! For specular hightlights
      ray             TYPE REF TO zcl_art_ray,

      "! recursion depth
      depth           TYPE int4,

      "! ray parameter
      t               TYPE decfloat16,

      "! for area lights
      dir             TYPE REF TO zcl_art_vector3d,

      "! world reference
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
          i_hit_point       TYPE REF TO zcl_art_point3d
          i_local_hit_point TYPE REF TO zcl_art_point3d
          i_normal          TYPE REF TO zcl_art_normal
          i_color           TYPE REF TO zcl_art_rgb_color
          i_ray             TYPE REF TO zcl_art_ray
          i_dir             TYPE REF TO zcl_art_vector3d
          i_material        TYPE REF TO zcl_art_material OPTIONAL
          i_depth           TYPE int4
          i_t               TYPE decfloat16
          VALUE(i_world)    TYPE REF TO zcl_art_world.

ENDCLASS.


CLASS zcl_art_shade_rec IMPLEMENTATION.


  METHOD constructor.
    ASSERT i_hit_point IS BOUND AND
           i_local_hit_point IS BOUND AND
           i_normal IS BOUND AND
           i_color IS BOUND AND
           i_world IS BOUND AND
           i_ray IS BOUND AND
           i_dir IS BOUND.

    me->hit_point = i_hit_point.
    me->local_hit_point = i_local_hit_point.
    me->hit_an_object = i_hit_an_object.
    me->normal = i_normal.
    me->color = i_color.
    me->world = i_world.

    "Doesn't need to be bound
    me->material = i_material.
    me->depth = i_depth.
    me->t = i_t.
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_shade_rec IS BOUND.

    r_instance = NEW #(
      i_world = i_shade_rec->world
      i_hit_an_object = i_shade_rec->hit_an_object
      i_normal = zcl_art_normal=>new_copy( i_shade_rec->normal )
      i_color = zcl_art_rgb_color=>new_copy( i_shade_rec->color )
      i_hit_point = zcl_art_point3d=>new_copy( i_shade_rec->hit_point )
      i_local_hit_point = zcl_art_point3d=>new_copy( i_shade_rec->local_hit_point )
      i_ray = zcl_art_ray=>new_copy( i_shade_rec->ray )
      i_dir = zcl_art_vector3d=>new_copy( i_shade_rec->dir )
      i_depth = i_shade_rec->depth
      i_t = i_shade_rec->t
      i_material = i_shade_rec->material ).
  ENDMETHOD.


  METHOD new_from_world.
    ASSERT i_world IS BOUND.

    r_instance = NEW #(
      i_world = i_world
      i_hit_an_object = abap_false
      i_normal = zcl_art_normal=>new_default( )
      i_hit_point = zcl_art_point3d=>new_default( )
      i_local_hit_point = zcl_art_point3d=>new_default( )
      i_color = zcl_art_rgb_color=>new_black( )
      i_ray = zcl_art_ray=>new_default( )
      i_dir = zcl_art_vector3d=>new_default( )
      "i_material = not bound by intention
      i_depth = 0
      i_t = 0 ).
  ENDMETHOD.
ENDCLASS.


