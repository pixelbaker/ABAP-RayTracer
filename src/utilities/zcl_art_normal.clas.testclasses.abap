CLASS lzcl_art_normal DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_unified FOR TESTING,
      new_default1 FOR TESTING.

ENDCLASS.


CLASS lzcl_art_normal IMPLEMENTATION.
  METHOD new_default1.
    "Default constructor generates normal with all components zero

    "When
    DATA(cut) = zcl_art_normal=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 0 ).
  ENDMETHOD.


  METHOD new_unified.
    "Unified constructor generates normal with all components one

    "When
    DATA(cut) = zcl_art_normal=>new_unified( 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.

ENDCLASS.
