CLASS ucl_art_single_sphere DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      trace_ray1 FOR TESTING,
      trace_ray2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_single_sphere IMPLEMENTATION.
  METHOD trace_ray1.
    "Test, that the sphere gets hit

    "Given
    DATA(world) = NEW zcl_art_world( ).

    DATA(cut) = NEW zcl_art_single_sphere( world ).

    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_unified( 1 )
      i_origin    = zcl_art_point3d=>new_unified( -1 ) ).

    "When
    DATA(color) = cut->trace_ray( ray ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 1  act = color->r ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->g ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->b ).
  ENDMETHOD.


  METHOD trace_ray2.
    "Test, that the sphere gets not hit

    "Given
    DATA(world) = NEW zcl_art_world( ).

    DATA(cut) = NEW zcl_art_single_sphere( world ).

    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_unified( 1 )
      i_origin    = zcl_art_point3d=>new_unified( 1 ) ).

    "When
    DATA(color) = cut->trace_ray( ray ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->r ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->g ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->b ).
  ENDMETHOD.
ENDCLASS.
