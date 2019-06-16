CLASS ucl_art_multiple_objects DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      trace_ray1 FOR TESTING,
      trace_ray2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_multiple_objects IMPLEMENTATION.
  METHOD trace_ray1.
    "Test, that tracing the world results in a hit

    "Given
    DATA(world) = NEW zcl_art_world(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ).

    DATA(sphere) = zcl_art_sphere=>new_default( ).
    sphere->set_color_by_color( zcl_art_rgb_color=>new_red( ) ).

    world->add_object( sphere ).

    DATA(cut) = NEW zcl_art_multiple_objects( world ).

    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_unified( 1 )
      i_origin = zcl_art_point3d=>new_unified( -1 ) ).


    "When
    DATA(color) = cut->trace_ray( ray ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 1  act = color->r ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->g ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->b ).
  ENDMETHOD.


  METHOD trace_ray2.
    "Test, that tracing the world results not a hit

    "Given
    DATA(world) = NEW zcl_art_world(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ).

    DATA(cut) = NEW zcl_art_multiple_objects( world ).

    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_unified( 1 )
      i_origin = zcl_art_point3d=>new_unified( -1 ) ).


    "When
    DATA(color) = cut->trace_ray( ray ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->r ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->g ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = color->b ).
  ENDMETHOD.

ENDCLASS.
