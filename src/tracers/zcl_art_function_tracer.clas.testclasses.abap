CLASS lcl_dummy DEFINITION
  INHERITING FROM zcl_art_function_definition.

  PUBLIC SECTION.
    METHODS:
      solve REDEFINITION.
ENDCLASS.

CLASS lcl_dummy IMPLEMENTATION.
  METHOD solve.
    r_value = '.5'.
  ENDMETHOD.
ENDCLASS.



CLASS ucl_art_function_tracer DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      trace_ray FOR TESTING.

ENDCLASS.


CLASS ucl_art_function_tracer IMPLEMENTATION.
  METHOD trace_ray.
    "Test, that the tracing a function works

    "Given
    DATA(world) = NEW zcl_art_world( ).
    world->set_function( NEW lcl_dummy( ) ).

    DATA(cut) = NEW zcl_art_function_tracer( world ).

    "When
    DATA(color) = cut->trace_ray( zcl_art_ray=>new_default( ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = '.5'  act = color->r ).
    cl_abap_unit_assert=>assert_equals( exp = '.5'  act = color->g ).
    cl_abap_unit_assert=>assert_equals( exp = '.5'  act = color->b ).
  ENDMETHOD.
ENDCLASS.
