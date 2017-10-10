*&---------------------------------------------------------------------*
*& Report zart_returning_value
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_importing_class.


CLASS cl_bar DEFINITION.
  PUBLIC SECTION.
    METHODS set IMPORTING i_value TYPE int4.
    DATA value TYPE int4.
ENDCLASS.

CLASS cl_bar IMPLEMENTATION.
  METHOD set.
    me->value = i_value.
  ENDMETHOD.
ENDCLASS.


CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS foobar
      IMPORTING
        i_value TYPE REF TO cl_bar.
ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD foobar.
    i_value->set( 1 ).
  ENDMETHOD.
ENDCLASS.


CLASS cl_main DEFINITION.
  PUBLIC SECTION.
    METHODS main.
ENDCLASS.

CLASS cl_main IMPLEMENTATION.
  METHOD main.
    DATA(instance) = NEW cl_foo( ).
    DATA(value) = NEW cl_bar( ).
    instance->foobar( value ).
    WRITE value->value.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(main) = NEW cl_main( ).
  main->main( ).
