CLASS zcl_art_function_tracer DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_tracer
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      trace_ray REDEFINITION.

ENDCLASS.



CLASS zcl_art_function_tracer IMPLEMENTATION.
  METHOD trace_ray.
    DATA(hres) = _world->viewplane->hres.
    DATA(vres) = _world->viewplane->vres.

    DATA(factor_x) = ( i_ray->origin->x + ( hres / 2 ) ) / hres.
    DATA(factor_y) = ( i_ray->origin->y + ( vres / 2 ) ) / vres.

    DATA(value) = _world->function->solve(
      i_x = factor_x
      i_y = factor_y ).

    r_color = zcl_art_rgb_color=>new_unified( value ).
  ENDMETHOD.
ENDCLASS.
