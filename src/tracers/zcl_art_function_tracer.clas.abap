CLASS zcl_art_function_tracer DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_tracer
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      trace_ray REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_function_tracer IMPLEMENTATION.
  METHOD trace_ray.
    ASSERT _world->function IS BOUND.
    DATA(hres) = _world->_viewplane->hres.
    DATA(vres) = _world->_viewplane->vres.
    DATA(half_hres) = hres / '2.0'.
    DATA(half_vres) = vres / '2.0'.
    DATA(factor_x) = ( ( i_ray->origin->x + half_hres ) * hres ) / '10000.0'.
    DATA(factor_y) = ( ( i_ray->origin->y + half_vres ) * vres ) / '10000.0'.

    DATA(x) = '3.79' * factor_x.
    DATA(y) = '3.79' * factor_y.

    DATA(value) = _world->function->solve(
      i_x = x
      i_y = y ).

    r_color = zcl_art_rgb_color=>new_unified( value ).
  ENDMETHOD.
ENDCLASS.
