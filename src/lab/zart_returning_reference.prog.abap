*&---------------------------------------------------------------------*
*& Report zart_returning_value
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_returning_reference.

CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS foobar
      RETURNING
        VALUE(r_value) TYPE REF TO int4.
ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD foobar.
    r_value = NEW int4( 42 ).
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(foo) = NEW cl_foo( ).
  DATA(value) = foo->foobar( ).
  WRITE value->*.
