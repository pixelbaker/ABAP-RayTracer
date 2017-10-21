*&---------------------------------------------------------------------*
*& Report zart_returning_value
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_importing_literal_value.

CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS foobar
      IMPORTING
        VALUE(i_value) TYPE int4.
ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD foobar.
    i_value = 24.
    WRITE i_value.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(foo) = NEW cl_foo( ).
  foo->foobar( 42 ).
