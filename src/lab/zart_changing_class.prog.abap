*&---------------------------------------------------------------------*
*& Report zart_returning_value
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_changing_class.


CLASS cl_bar DEFINITION.
  PUBLIC SECTION.
    METHODS set IMPORTING i_value TYPE int4.
    DATA value TYPE int4 VALUE 1.
ENDCLASS.

CLASS cl_bar IMPLEMENTATION.
  METHOD set.
    me->value = i_value.
  ENDMETHOD.
ENDCLASS.


CLASS cl_foo DEFINITION.
  PUBLIC SECTION.
    METHODS:
      pass_class_by_reference
        CHANGING
          REFERENCE(c_value) TYPE REF TO cl_bar,

      pass_class_by_value
        CHANGING
          VALUE(c_value) TYPE REF TO cl_bar.

ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD pass_class_by_reference.
    c_value->set( 42 ).
  ENDMETHOD.

  METHOD pass_class_by_value.
    c_value->set( 42 ).
  ENDMETHOD.
ENDCLASS.


CLASS cl_main DEFINITION.
  PUBLIC SECTION.
    METHODS main.
ENDCLASS.

CLASS cl_main IMPLEMENTATION.
  METHOD main.
    DATA(foo) = NEW cl_foo( ).
    DATA(bar) = NEW cl_bar( ).

    foo->pass_class_by_reference( CHANGING c_value = bar ).
*    foo->pass_class_by_value( CHANGING c_value = bar ).

    WRITE bar->value.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(main) = NEW cl_main( ).
  main->main( ).
