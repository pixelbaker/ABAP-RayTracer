*&---------------------------------------------------------------------*
*& Report zart_exporting_value
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_exporting_value.

CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS foobar
      EXPORTING
        VALUE(e_value) TYPE int4.
ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD foobar.
    e_value = 42.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(foo) = NEW cl_foo( ).
  DATA value TYPE int4.
  foo->foobar( IMPORTING e_value = value ).
  WRITE value.
