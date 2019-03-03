CLASS ucl_art_rgb_color DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_copy FOR TESTING,
      new_default FOR TESTING,
      new_individual FOR TESTING,
      new_unified FOR TESTING,
      powc FOR TESTING.

ENDCLASS.


CLASS ucl_art_rgb_color IMPLEMENTATION.
  METHOD new_copy.
    "Copy constructor generates a new instance of a RGB color based on another RGB color

    "Given
    DATA(color) = zcl_art_rgb_color=>new_individual(
      i_r = 5
      i_g = 6
      i_b = 7 ).

    "When
    DATA(cut) = zcl_art_rgb_color=>new_copy( color ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN color <> cut THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->r  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->g  exp = 6 ).
    cl_abap_unit_assert=>assert_equals( act = cut->b  exp = 7 ).
  ENDMETHOD.


  METHOD new_default.
    "Default constructor generates a RGB color with all components zero

    "When
    DATA(cut) = zcl_art_rgb_color=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->r  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->g  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->b  exp = 0 ).
  ENDMETHOD.


  METHOD new_individual.
    "Individual constructor generates a RGB color according to components

    "When
    DATA(cut) = zcl_art_rgb_color=>new_individual(
      i_r = 2
      i_g = 3
      i_b = 4 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->r  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->g  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = cut->b  exp = 4 ).
  ENDMETHOD.


  METHOD new_unified.
    "Unified constructor generates a RGB color with all components one

    "When
    DATA(cut) = zcl_art_rgb_color=>new_unified( 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->r  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->g  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->b  exp = 1 ).
  ENDMETHOD.


  METHOD powc.
    "Check that the power operation works

    "Given
    DATA(cut) = zcl_art_rgb_color=>new_unified( 2 ).

    "When
    DATA(result) = cut->powc( 2 ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN result <> cut THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = result->r  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = result->g  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = result->b  exp = 4 ).
  ENDMETHOD.

ENDCLASS.
