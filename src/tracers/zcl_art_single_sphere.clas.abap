CLASS zcl_art_single_sphere DEFINITION
  PUBLIC
  FINAL
  INHERITING FROM zcl_art_tracer
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_world TYPE REF TO zcl_art_world,

      trace_ray REDEFINITION.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_single_sphere IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_world = i_world ).
  ENDMETHOD.


  METHOD trace_ray.
    DATA(shade_rec) = NEW zcl_art_shade_rec( i_world = _world ).
    DATA t TYPE decfloat16.

    _world->sphere->hit(
      EXPORTING
        i_ray = i_ray
      IMPORTING
        e_tmin = t
        e_hit = DATA(hit)
      CHANGING
        c_shade_rec = shade_rec ).

    IF hit = abap_true.
      r_result = zcl_art_rgb_color=>red.
    ELSE.
      r_result = zcl_art_rgb_color=>black.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
