*&---------------------------------------------------------------------*
*& Report zart_returning_value
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_importing_reference.

CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS foobar
      IMPORTING
        REFERENCE(i_value) TYPE int4.
ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD foobar.
    WRITE i_value.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(instance) = NEW cl_foo( ).
  DATA value TYPE int4 VALUE 42.
  instance->foobar( value ).
