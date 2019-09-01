CLASS ucl_art_world DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_world.


    METHODS:
      setup,

      build FOR TESTING,

      display_pixel1 FOR TESTING RAISING zcx_bmp_bitmap,
      display_pixel2 FOR TESTING RAISING zcx_bmp_bitmap,
      display_pixel3 FOR TESTING RAISING zcx_bmp_bitmap,

      render_scene1 FOR TESTING RAISING zcx_bmp_bitmap,
      render_perspective1 FOR TESTING RAISING zcx_bmp_bitmap,
      get_num_objects FOR TESTING,

      hit_bare_bones_objects1 FOR TESTING,
      hit_bare_bones_objects2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_world IMPLEMENTATION.
  METHOD setup.
    "To speed some of the test up, we make the viewport height and width very small
    _cut = NEW #(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ).
  ENDMETHOD.


  METHOD get_num_objects.
    "Test, that the number of objects can be retrieved

    "Given
    _cut->add_object( zcl_art_sphere=>new_default( ) ).

    "When
    DATA(num_objects) = _cut->get_num_objects( ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 1  act = num_objects ).
  ENDMETHOD.


  METHOD render_scene1.
    "Test, that a fresh world being rendered isn't crashing

    "When
    _cut->render_scene( ).

    "Then
    _cut->bitmap->build( ).
  ENDMETHOD.


  METHOD render_perspective1.
    "Test, that a fresh world being rendered isn't crashing

    "Given


    "When
    _cut->render_perspective( ).

    "Then
    _cut->bitmap->build( ).
  ENDMETHOD.


  METHOD hit_bare_bones_objects1.
    "Test, that trying to hit no objects won't crash

    "When
    DATA(result) = _cut->hit_bare_bones_objects( zcl_art_ray=>new_default( ) ).

    "Then
    cl_abap_unit_assert=>assert_false( result->hit_an_object ).
  ENDMETHOD.


  METHOD hit_bare_bones_objects2.
    "Test, that trying to hit an object works

    "Given
    _cut->add_object( zcl_art_sphere=>new_default( ) ).

    "When
    DATA(result) = _cut->hit_bare_bones_objects(
      zcl_art_ray=>new_from_point_and_vector(
        i_direction = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
        i_origin = zcl_art_point3d=>new_default( ) ) ).

    "Then
    cl_abap_unit_assert=>assert_true( result->hit_an_object ).
  ENDMETHOD.


  METHOD build.
    "Test, that at least one object or a function gets added to the world

    "When
    _cut->build( ).

    "Then
    cl_abap_unit_assert=>assert_true(
      xsdbool( _cut->get_num_objects( ) > 0 OR
               _cut->function IS BOUND ) ).
  ENDMETHOD.


  METHOD display_pixel1.
    "Test, that adding a pixel color with "out of gamma" being disabled works.

    "Given
    _cut->viewplane->set_gamut_display( abap_false ).
    _cut->set_bitmap( NEW zcl_bmp_bitmap(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ) ).

    "When
    _cut->display_pixel(
      i_row = 0
      i_column = 0
      i_pixel_color = zcl_art_rgb_color=>new_unified( '.5' ) ).


    "Then
    DATA(bmp) = _cut->bitmap->build( ).
    cl_abap_unit_assert=>assert_equals(
      exp = '424D3A0000000000000036000000280000000100000001000000010018000000000004000000130B0000130B0000000000000000000080808000'
      act = bmp ).
  ENDMETHOD.


  METHOD display_pixel2.
    "Test, that adding a pixel color with "out of gamma" being enabled works.

    "Given
    _cut->viewplane->set_gamut_display( abap_true ).
    _cut->viewplane->set_gamma( '1.5' ).
    _cut->set_bitmap( NEW zcl_bmp_bitmap(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ) ).

    "When
    _cut->display_pixel(
      i_row = 0
      i_column = 0
      i_pixel_color = zcl_art_rgb_color=>new_unified( '1.5' ) ).


    "Then
    DATA(bmp) = _cut->bitmap->build( ).
    cl_abap_unit_assert=>assert_equals(
      exp = '424D3A0000000000000036000000280000000100000001000000010018000000000004000000130B0000130B000000000000000000000000FF00'
      act = bmp ).
  ENDMETHOD.


  METHOD display_pixel3.
    "Test, that adding a pixel bigger than 1 gets maxed down to 1.

    "Given
    _cut->viewplane->set_gamut_display( abap_false ).
    _cut->set_bitmap( NEW zcl_bmp_bitmap(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ) ).

    "When
    _cut->display_pixel(
      i_row = 0
      i_column = 0
      i_pixel_color = zcl_art_rgb_color=>new_unified( '1.5' ) ).


    "Then
    DATA(bmp) = _cut->bitmap->build( ).
    cl_abap_unit_assert=>assert_equals(
      exp = '424D3A0000000000000036000000280000000100000001000000010018000000000004000000130B0000130B00000000000000000000FFFFFF00'
      act = bmp ).
  ENDMETHOD.
ENDCLASS.
