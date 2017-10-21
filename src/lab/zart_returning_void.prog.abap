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
    WRITE 42.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(foo) = NEW cl_foo( ).
  foo->foobar( ).
