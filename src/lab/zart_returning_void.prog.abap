*&---------------------------------------------------------------------*
*& Report zart_returning_void
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_returning_void.

CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS foobar.
ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD foobar.
    WRITE 'Total bore!'.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(instance) = NEW cl_foo( ).
  instance->foobar( ).
