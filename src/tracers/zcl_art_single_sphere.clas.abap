CLASS zcl_art_single_sphere DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_art_tracer
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      trace_ray REDEFINITION.

ENDCLASS.



CLASS zcl_art_single_sphere IMPLEMENTATION.
  METHOD trace_ray.
    DATA(shade_rec) = zcl_art_shade_rec=>new_from_world( _world ).
    DATA t TYPE decfloat16.

    DATA(hit) = _world->sphere->hit(
      EXPORTING
        i_ray = i_ray
      IMPORTING
        e_tmin = t
      CHANGING
        c_shade_rec = shade_rec ).

    r_color = COND #( WHEN hit = abap_true
                      THEN zcl_art_rgb_color=>new_red( )
                      ELSE zcl_art_rgb_color=>new_black( ) ).
  ENDMETHOD.
ENDCLASS.
