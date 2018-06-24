CLASS cl_unittest DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_math.


    METHODS:
      setup,

      composite_inverse_transform1 FOR TESTING.


ENDCLASS.


CLASS cl_unittest IMPLEMENTATION.
  METHOD setup.
  ENDMETHOD.


  METHOD composite_inverse_transform1.
    "Check that generating a transformation matrix by rotating on a line works

    "Given
    DATA(rotate_around_line) = zcl_art_vector3d=>new_unified( 0 )->get_difference_by_vector(
                                 zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = -1 ) ).
    DATA(u) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 ).
    DATA(v) = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 ).
    DATA(w) = zcl_art_vector3d=>new_copy( rotate_around_line ).

    "When
    DATA(result) = zcl_art_math=>composite_inverse_transform(
      i_rotate_around_line = rotate_around_line
      i_u = u
      i_v = v
      i_w = w
      i_angle = 180 ).

    "Then
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 1 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 2 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.
ENDCLASS.
