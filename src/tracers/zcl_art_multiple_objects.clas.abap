CLASS zcl_art_multiple_objects DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_tracer
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_world TYPE REF TO zcl_art_world,

      trace_ray REDEFINITION.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_multiple_objects IMPLEMENTATION.
  METHOD constructor.
    super->constructor( i_world ).
  ENDMETHOD.


  METHOD trace_ray.
    DATA(shade_rec) = _world->hit_bare_bones_objects( i_ray ).

    IF shade_rec->hit_an_object = abap_true.
      r_color = shade_rec->color.
    ELSE.
      r_color = zcl_art_rgb_color=>new_copy( me->_world->background_color ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
