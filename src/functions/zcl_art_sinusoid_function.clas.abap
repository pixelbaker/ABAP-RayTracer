CLASS zcl_art_sinusoid_function DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_function_definition
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      solve REDEFINITION.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_sinusoid_function IMPLEMENTATION.
  METHOD solve.
    DATA(xx) = i_x ** 2.
    DATA(yy) = i_y ** 2.
    DATA(xxyy) =  CONV f( xx * yy ).
    DATA(sin_result) = sin( xxyy ).
    r_value = '0.5' * ( '1.0' + sin_result ).
  ENDMETHOD.
ENDCLASS.
