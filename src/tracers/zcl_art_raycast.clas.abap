CLASS zcl_art_raycast DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_tracer
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    METHODS:
      trace_ray REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_raycast IMPLEMENTATION.
  METHOD trace_ray.
    DATA(shade_rec) = _world->hit_objects( i_ray ).


    IF shade_rec->hit_an_object = abap_true.
      "used for specular shading
      shade_rec->ray = i_ray.

      r_color = shade_rec->material->shade( CHANGING c_shade_rec = shade_rec ).
    ELSE.
      r_color = zcl_art_rgb_color=>new_black( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
