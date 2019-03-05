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

      powc FOR TESTING,

      add_and_assign_by_color FOR TESTING,
      divide_and_assign_by_float FOR TESTING,
      multiply_and_assign_by_float FOR TESTING,

      assign_by_color1 FOR TESTING,
      assign_by_color2 FOR TESTING,

      get_quotient_by_decfloat for testing.

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


  METHOD add_and_assign_by_color.
    "Check that a color cannot only be assigned but also added to the LHS color.

    "Given
    DATA(cut) = zcl_art_rgb_color=>new_unified( 2 ).

    "When
    DATA(result) = cut->add_and_assign_by_color( cut ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result  exp = cut ).
    cl_abap_unit_assert=>assert_equals( act = result->r  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = result->g  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = result->b  exp = 4 ).
  ENDMETHOD.


  METHOD divide_and_assign_by_float.
    "Check that the LHS color gets divided by a float and doesn't create a new instance.

    "Given
    DATA(cut) = zcl_art_rgb_color=>new_unified( 2 ).

    "When
    DATA(result) = cut->divide_and_assign_by_float( 2 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result  exp = cut ).
    cl_abap_unit_assert=>assert_equals( act = result->r  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->g  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->b  exp = 1 ).
  ENDMETHOD.


  METHOD multiply_and_assign_by_float.
    "Check that the LHS color gets multiplied by a float and doesn't create a new instance.

    "Given
    DATA(cut) = zcl_art_rgb_color=>new_unified( 2 ).

    "When
    DATA(result) = cut->multiply_and_assign_by_float( 2 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result  exp = cut ).
    cl_abap_unit_assert=>assert_equals( act = result->r  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = result->g  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = result->b  exp = 4 ).
  ENDMETHOD.


  METHOD assign_by_color1.
    "Check that a color can be assigned to another.

    "Given
    DATA(color) = zcl_art_rgb_color=>new_unified( 2 ).
    DATA(cut) = zcl_art_rgb_color=>new_unified( 1 ).

    "When
    DATA(result) = cut->assign_by_color( color ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result  exp = cut ).
    cl_abap_unit_assert=>assert_equals( act = result->r  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->g  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->b  exp = 2 ).
  ENDMETHOD.


  METHOD assign_by_color2.
    "Check that a color can be assigned to itself.

    "Given
    DATA(cut) = zcl_art_rgb_color=>new_unified( 2 ).

    "When
    DATA(result) = cut->assign_by_color( cut ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result  exp = cut ).
    cl_abap_unit_assert=>assert_equals( act = result->r  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->g  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->b  exp = 2 ).
  ENDMETHOD.


  METHOD get_quotient_by_decfloat.
    "Check that a new color instance gets created being the quotient of the division by the float

    "Given
    DATA(cut) = zcl_art_rgb_color=>new_unified( 2 ).

    "When
    DATA(result) = cut->get_quotient_by_decfloat( 2 ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN result <> cut THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = result->r  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->g  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->b  exp = 1 ).
  ENDMETHOD.
ENDCLASS.
