CLASS ucl_art_math DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      "! Check, that rotating by zero degree returns an identity matrix
      inverse_rotate_x1 FOR TESTING,
      "! Check, rotating by 45 degree
      inverse_rotate_x2 FOR TESTING,
      "! Check, rotating by 90 degree
      inverse_rotate_x3 FOR TESTING,
      "! Check, rotating by 180 degree
      inverse_rotate_x4 FOR TESTING,
      "! Check, rotating by 360 degree
      inverse_rotate_x5 FOR TESTING,
      "! Check, rotating by 720 degree
      inverse_rotate_x6 FOR TESTING,

      "! Check, that rotating by zero degree returns an identity matrix
      inverse_rotate_y1 FOR TESTING,
      "! Check, rotating by 45 degree
      inverse_rotate_y2 FOR TESTING,
      "! Check, rotating by 90 degree
      inverse_rotate_y3 FOR TESTING,
      "! Check, rotating by 180 degree
      inverse_rotate_y4 FOR TESTING,
      "! Check, rotating by 360 degree
      inverse_rotate_y5 FOR TESTING,
      "! Check, rotating by 720 degree
      inverse_rotate_y6 FOR TESTING,

      "! Check, that rotating by zero degree returns an identity matrix
      inverse_rotate_z1 FOR TESTING,
      "! Check, rotating by 45 degree
      inverse_rotate_z2 FOR TESTING,
      "! Check, rotating by 90 degree
      inverse_rotate_z3 FOR TESTING,
      "! Check, rotating by 180 degree
      inverse_rotate_z4 FOR TESTING,
      "! Check, rotating by 360 degree
      inverse_rotate_z5 FOR TESTING,
      "! Check, rotating by 720 degree
      inverse_rotate_z6 FOR TESTING,

      "! Check, that rotating by zero degree returns an identity matrix
      rotate_about_line_in_x1 FOR TESTING,
      "! Check, rotating by 90 degree
      rotate_about_line_in_x2 FOR TESTING,

      "! Check, that rotating by zero degree returns an identity matrix
      rotate_about_line_in_y1 FOR TESTING,
      "! Check, rotating by 90 degree
      rotate_about_line_in_y2 FOR TESTING,

      "! Check, that rotating by zero degree returns an identity matrix
      rotate_about_line_in_z1 FOR TESTING,
      "! Check, rotating by 90 degree
      rotate_about_line_in_z2 FOR TESTING.


ENDCLASS.


CLASS ucl_art_math IMPLEMENTATION.
  METHOD inverse_rotate_x1.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_x( 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_x2.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_x( 45 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = '0.7071067811865474' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = '0.7071067811865477' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = '-0.7071067811865477' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = '0.7071067811865474' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_x3.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_x( 90 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_x4.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_x( 180 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_x5.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_x( 360 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_x6.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_x( 720 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_y1.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_y( 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_y2.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_y( 45 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = '0.7071067811865474' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = '-0.7071067811865477' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = '0.7071067811865477' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = '0.7071067811865474' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_y3.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_y( 90 ).

    "Then
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_y4.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_y( 180 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_y5.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_y( 360 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_y6.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_y( 720 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_z1.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_z( 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_z2.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_z( 45 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = '0.7071067811865474' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = '0.7071067811865477' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = '-0.7071067811865477' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = '0.7071067811865474' ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_z3.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_z( 90 ).

    "Then
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_z4.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_z( 180 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_z5.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_z( 360 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD inverse_rotate_z6.
    "When
    DATA(result) = zcl_art_math=>inverse_rotate_z( 720 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD rotate_about_line_in_x1.
    "When
    DATA(result) = zcl_art_math=>rotate_about_line_in_x(
      i_u = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_v = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 )
      i_angle = 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD rotate_about_line_in_x2.
    "When
    DATA(result) = zcl_art_math=>rotate_about_line_in_x(
      i_u = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_v = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 )
      i_angle = 90 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD rotate_about_line_in_y1.
    "When
    DATA(result) = zcl_art_math=>rotate_about_line_in_y(
      i_u = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_v = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 )
      i_angle = 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD rotate_about_line_in_y2.
    "When
    DATA(result) = zcl_art_math=>rotate_about_line_in_y(
      i_u = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_v = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 )
      i_angle = 90 ).

    "Then
    cl_abap_unit_assert=>assert_equals_Float( act = result->matrix[ 1 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 3 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD rotate_about_line_in_z1.
    "When
    DATA(result) = zcl_art_math=>rotate_about_line_in_z(
      i_u = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_v = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 )
      i_angle = 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD rotate_about_line_in_z2.
    "When
    DATA(result) = zcl_art_math=>rotate_about_line_in_z(
      i_u = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_v = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 )
      i_angle = 90 ).

    "Then
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 1 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = -1 ).
    cl_abap_unit_assert=>assert_equals_float( act = result->matrix[ 2 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.
ENDCLASS.
