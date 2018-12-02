CLASS ucl_art_point2d DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      constructor1 FOR TESTING,
      constructor2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_point2d IMPLEMENTATION.

  METHOD constructor1.
    "Check the default constructor works

    "When
    DATA(cut) = NEW zcl_art_point2d( ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 0  act = cut->x ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = cut->y ).
  ENDMETHOD.


  METHOD constructor2.
    "Check that initializing x and y works

    "When
    DATA(cut) = NEW zcl_art_point2d( i_x = 1  i_y = 2 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 1  act = cut->x ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = cut->y ).
  ENDMETHOD.

ENDCLASS.
