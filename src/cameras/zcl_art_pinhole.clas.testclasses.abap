CLASS ucl_art_pinhole DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_default FOR TESTING,
      new_copy FOR TESTING,
      get_direction FOR TESTING,
      render_scene FOR TESTING.

ENDCLASS.


CLASS ucl_art_pinhole IMPLEMENTATION.
  METHOD new_default.
    "Test, that the default constructor works

    "When
    DATA(cut) = zcl_art_pinhole=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 500  act = cut->get_view_plane_distance( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = cut->get_zoom_factor( ) ).
  ENDMETHOD.


  METHOD new_copy.
    "Test, that the copy constructor works

    "Given
    DATA(pinhole) = zcl_art_pinhole=>new_default( ).
    pinhole->set_view_plane_distance( 100 ).
    pinhole->set_zoom_factor( 2 ).

    "When
    DATA(cut) = zcl_art_pinhole=>new_copy( pinhole ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 100  act = cut->get_view_plane_distance( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = cut->get_zoom_factor( ) ).
  ENDMETHOD.


  METHOD get_direction.
    "Test, that getting the normalized direction of the camera works

    "Given
    DATA(cut) = zcl_art_pinhole=>new_default( ).
    cut->set_eye_by_components( i_x = -2  i_y = 0  i_z = 0 ).
    cut->set_lookat_by_components(  i_x = 0  i_y = 0  i_z = 0 ).
    cut->compute_uvw( ).

    "When
    DATA(direction) = cut->get_direction( NEW zcl_art_point2d( ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 1  act = direction->x ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = direction->y ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = direction->z ).
  ENDMETHOD.


  METHOD render_scene.
    "Test, that rendering an empty scene works

    "Given
    DATA(cut) = zcl_art_pinhole=>new_default( ).

    "When
    DATA(world) = NEW zcl_art_world(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ).
    cut->render_scene( CHANGING c_world = world ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( world->num_rays > 0 ) ).
  ENDMETHOD.
ENDCLASS.
