CLASS ucl_art_sphere DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _shade_rec TYPE REF TO zcl_art_shade_rec.


    METHODS:
      setup,

      new_default FOR TESTING,
      new_copy FOR TESTING,
      new_by_center_and_radius FOR TESTING.

ENDCLASS.


CLASS ucl_art_sphere IMPLEMENTATION.
  METHOD setup.
    DATA(world) = NEW zcl_art_world( ).
    _shade_rec = zcl_art_shade_rec=>new_from_world( world ).
  ENDMETHOD.


  METHOD new_default.
    "Default constructor generates a sphere in the world origin with a radius of one

    "When
    DATA(cut) = zcl_art_sphere=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->get_radius( )  exp = 1 ).

    DATA(center) = cut->get_center( ).
    cl_abap_unit_assert=>assert_equals( act = center->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = center->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = center->z  exp = 0 ).
  ENDMETHOD.


  METHOD new_copy.
    "Copy constructor generates a new instance of a sphere based on another sphere

    "Given
    DATA(center) = zcl_art_point3d=>new_unified( 2 ).
    DATA(sphere) = zcl_art_sphere=>new_by_center_and_radius(
      i_center = center
      i_radius = '.5' ).

    DATA(color) = zcl_art_rgb_color=>new_unified( 2 ).
    sphere->set_color_by_color( color ).

    "When
    DATA(cut) = zcl_art_sphere=>new_copy( sphere ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( sphere <> cut ) ).

    DATA(new_center) = cut->get_center( ).
    cl_abap_unit_assert=>assert_true( xsdbool( new_center <> center ) ).
    cl_abap_unit_assert=>assert_equals( act = new_center->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = new_center->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = new_center->z  exp = 2 ).

    cl_abap_unit_assert=>assert_equals( act = cut->get_radius( )  exp = '0.5' ).

    DATA(new_color) = cut->get_color( ).
    cl_abap_unit_assert=>assert_true( xsdbool( new_color <> color ) ).
    cl_abap_unit_assert=>assert_equals( act = new_color->r  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = new_color->g  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = new_color->b  exp = 2 ).
  ENDMETHOD.


  METHOD new_by_center_and_radius.
    "Constructs a new instance of a sphere based on a point and a radius

    "When
    DATA(cut) = zcl_art_sphere=>new_by_center_and_radius(
      i_center = zcl_art_point3d=>new_unified( 2 )
      i_radius = '.5' ).

    "Then
    DATA(center) = cut->get_center( ).
    cl_abap_unit_assert=>assert_equals( act = center->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = center->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = center->z  exp = 2 ).

    cl_abap_unit_assert=>assert_equals( act = cut->get_radius( )  exp = '0.5' ).

    cl_abap_unit_assert=>assert_bound( act = cut->get_color( ) ).
  ENDMETHOD.
ENDCLASS.
