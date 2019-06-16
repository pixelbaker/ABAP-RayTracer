CLASS zcl_art_sinusoid_function DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_function_definition
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS:
*      co_range TYPE decfloat16 VALUE '3.79'.
      co_range TYPE decfloat16 VALUE '10.83'.


    METHODS:
      solve REDEFINITION.

ENDCLASS.



CLASS ZCL_ART_SINUSOID_FUNCTION IMPLEMENTATION.
  METHOD solve.
    DATA(xx) = ( i_x * co_range ) ** 2.
    DATA(yy) = ( i_y * co_range ) ** 2.
    DATA(xxyy) =  CONV f( xx * yy ).
    DATA(sin_result) = sin( xxyy ).
    r_value = '0.5' * ( '1.0' + sin_result ).
  ENDMETHOD.
ENDCLASS.
