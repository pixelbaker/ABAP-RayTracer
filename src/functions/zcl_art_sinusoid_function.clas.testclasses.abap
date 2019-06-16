CLASS ucl_art_sinusoid_function DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      solve FOR TESTING.

ENDCLASS.


CLASS ucl_art_sinusoid_function IMPLEMENTATION.



  METHOD solve.
    "Test, that the equation gets solved for a 2D point

    "Given
    DATA(cut) = NEW zcl_art_sinusoid_function( ).

    "When
    DATA(value) = cut->solve( i_x = 0  i_y = 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = '.5'  act = value ).
  ENDMETHOD.

ENDCLASS.
