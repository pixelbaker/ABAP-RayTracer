CLASS ucl_art_point3d DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_copy FOR TESTING.

ENDCLASS.


CLASS ucl_art_point3d IMPLEMENTATION.
  METHOD new_copy.
    "Copy constructor generates a new instance of a normal 3D point based on another 3D point

    "Given
    DATA(point) = zcl_art_normal=>new_individual(
      i_x = 5
      i_y = 6
      i_z = 7 ).

    "When
    DATA(cut) = zcl_art_normal=>new_copy( point ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN point <> cut THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 6 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 7 ).
  ENDMETHOD.
ENDCLASS.
