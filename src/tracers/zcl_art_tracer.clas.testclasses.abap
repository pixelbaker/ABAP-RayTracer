CLASS lcl_dummy DEFINITION
  INHERITING FROM zcl_art_tracer
  FINAL.

  PUBLIC SECTION.
    METHODS:
      trace_ray REDEFINITION,

      is_world_bound
        RETURNING
          VALUE(r_result) TYPE abap_bool.

ENDCLASS.


CLASS lcl_dummy IMPLEMENTATION.
  METHOD trace_ray.
  ENDMETHOD.

  METHOD is_world_bound.
    r_result = xsdbool( _world IS BOUND ).
  ENDMETHOD.
ENDCLASS.



CLASS ucl_art_tracer DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut   TYPE REF TO lcl_dummy,
      _world TYPE REF TO zcl_art_world.


    METHODS:
      setup,

      constructor1 FOR TESTING,
      trace_ray FOR TESTING.

ENDCLASS.


CLASS ucl_art_tracer IMPLEMENTATION.
  METHOD setup.
    _world = NEW zcl_art_world( ).
  ENDMETHOD.


  METHOD constructor1.
    "Test, that instantiating works properly

    "When
    _cut = NEW lcl_dummy( _world ).

    "Then
    cl_abap_unit_assert=>assert_true( _cut->is_world_bound( ) ).
  ENDMETHOD.


  METHOD trace_ray.
    "Get me to then 100% code coverage

    "Give
    _cut = NEW lcl_dummy( _world ).
    DATA ray TYPE REF TO zcl_art_ray.

    "When
    _cut->trace_ray( ray ).
  ENDMETHOD.
ENDCLASS.
