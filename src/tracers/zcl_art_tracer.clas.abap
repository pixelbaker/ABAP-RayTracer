CLASS zcl_art_tracer DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_world TYPE REF TO zcl_art_world,

      trace_ray
        IMPORTING
          i_ray           TYPE REF TO zcl_art_ray
          i_depth         TYPE int4 OPTIONAL
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color.


  PROTECTED SECTION.
    DATA:
      _world TYPE REF TO zcl_art_world.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_tracer IMPLEMENTATION.
  METHOD trace_ray.
    r_color = zcl_art_rgb_color=>black.
  ENDMETHOD.


  METHOD constructor.
    ASSERT i_world IS BOUND.
    _world = i_world.
  ENDMETHOD.

ENDCLASS.
