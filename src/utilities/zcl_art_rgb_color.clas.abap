CLASS zcl_art_rgb_color DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-DATA:
      black TYPE REF TO zcl_art_rgb_color, "todo: should go into a constants class
      red   TYPE REF TO zcl_art_rgb_color, "todo: should go into a constants class
      white TYPE REF TO zcl_art_rgb_color. "todo: should go into a constants class


    DATA:
      r TYPE decfloat16,
      g TYPE decfloat16,
      b TYPE decfloat16.


    CLASS-METHODS:
      class_constructor,

      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_rgb_color,

      new_unified
        IMPORTING
          VALUE(i_value)    TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_rgb_color,

      new_individual
        IMPORTING
          VALUE(i_r)        TYPE decfloat16
          VALUE(i_g)        TYPE decfloat16
          VALUE(i_b)        TYPE decfloat16
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_rgb_color,

      new_copy
        IMPORTING
          REFERENCE(i_color) TYPE REF TO zcl_art_rgb_color
        RETURNING
          VALUE(r_instance)  TYPE REF TO zcl_art_rgb_color.


    METHODS:
      get_quotient_by_decfloat
        IMPORTING
          i_value        TYPE decfloat16
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      powc
        IMPORTING
          i_power        TYPE decfloat16
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          VALUE(i_r) TYPE decfloat16
          VALUE(i_g) TYPE decfloat16
          VALUE(i_b) TYPE decfloat16.

ENDCLASS.



CLASS zcl_art_rgb_color IMPLEMENTATION.


  METHOD class_constructor.
    white = zcl_art_rgb_color=>new_unified( 1 ).

    black = zcl_art_rgb_color=>new_unified( 0 ).

    red = zcl_art_rgb_color=>new_individual(
      i_r = 1
      i_g = 0
      i_b = 0 ).
  ENDMETHOD.


  METHOD constructor.
    me->r = i_r.
    me->g = i_g.
    me->b = i_b.
  ENDMETHOD.


  METHOD get_quotient_by_decfloat.
    r_color = zcl_art_rgb_color=>new_individual(
      i_r = r / i_value
      i_g = g / i_value
      i_b = b / i_value ).
  ENDMETHOD.


  METHOD powc.
    r_color = zcl_art_rgb_color=>new_individual(
      i_r = r ** i_power
      i_g = g ** i_power
      i_b = b ** i_power ).
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_color IS BOUND.

    r_instance = NEW #(
      i_r = i_color->r
      i_g = i_color->g
      i_b = i_color->b ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = new_unified( 0 ).
  ENDMETHOD.


  METHOD new_individual.
    r_instance = NEW #(
      i_r = i_r
      i_g = i_g
      i_b = i_b ).
  ENDMETHOD.


  METHOD new_unified.
    r_instance = NEW #(
      i_r = i_value
      i_g = i_value
      i_b = i_value ).
  ENDMETHOD.
ENDCLASS.
