*&---------------------------------------------------------------------*
*& Report zart_returning_value
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_returning_value.

CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS foobar
      RETURNING
        VALUE(r_value) TYPE int4.
ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD foobar.
    r_value = 42.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(instance) = NEW cl_foo( ).
  DATA(value) = instance->foobar( ).
  WRITE value.
