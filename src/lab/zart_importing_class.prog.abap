*&---------------------------------------------------------------------*
*& Report zart_importing_class
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_importing_class.


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
        IMPORTING
          REFERENCE(i_value) TYPE REF TO cl_bar,

      pass_class_by_value
        IMPORTING
          VALUE(i_value) TYPE REF TO cl_bar.

ENDCLASS.

CLASS cl_foo IMPLEMENTATION.
  METHOD pass_class_by_reference.
    i_value->set( 42 ).
  ENDMETHOD.

  METHOD pass_class_by_value.
    i_value->set( 42 ).
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

    foo->pass_class_by_reference( bar ).
*    foo->pass_class_by_value( bar ).

    WRITE bar->value.
  ENDMETHOD.
ENDCLASS.


START-OF-SELECTION.
  DATA(main) = NEW cl_main( ).
  main->main( ).
