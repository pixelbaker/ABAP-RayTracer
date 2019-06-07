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

      new_default FOR TESTING.

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
ENDCLASS.
