CLASS zcl_art_rgb_color DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    DATA:
      r TYPE decfloat16,
      g TYPE decfloat16,
      b TYPE decfloat16.


    CLASS-METHODS:
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
          VALUE(r_instance)  TYPE REF TO zcl_art_rgb_color,

      "! Gives you a new instance with the color red.
      new_red
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_rgb_color,

      "! Gives you a new instance with the color white.
      new_white
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_rgb_color,

      "! Gives you a new instance with the color black.
      new_black
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_rgb_color.



    METHODS:
      "! operator+=
      add_and_assign_by_color
        IMPORTING
          i_color        TYPE REF TO zcl_art_rgb_color
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      "! operator=
      assign_by_color
        IMPORTING
          i_color        TYPE REF TO zcl_art_rgb_color
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      "! operator/=
      divide_and_assign_by_decfloat
        IMPORTING
          i_value        TYPE decfloat16
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      "! operator/
      get_quotient_by_decfloat
        IMPORTING
          i_value        TYPE decfloat16
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      powc
        IMPORTING
          i_power        TYPE decfloat16
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      "! operator*=
      multiply_and_assign_by_decflt
        IMPORTING
          i_value        TYPE decfloat16
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      "! operator*
      "! multiplication by a float on the right
      "! @parameter r_result | a new instance (value object), which contains the result of the multiplication
      multiply_by_decfloat
        IMPORTING
          i_value         TYPE decfloat16
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_rgb_color.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          VALUE(i_r) TYPE decfloat16
          VALUE(i_g) TYPE decfloat16
          VALUE(i_b) TYPE decfloat16.

ENDCLASS.



CLASS zcl_art_rgb_color IMPLEMENTATION.


  METHOD add_and_assign_by_color.
    ADD i_color->r TO me->r.
    ADD i_color->g TO me->g.
    ADD i_color->b TO me->b.

    r_color = me.
  ENDMETHOD.


  METHOD assign_by_color.
    IF me <> i_color.
      me->r = i_color->r.
      me->g = i_color->g.
      me->b = i_color->b.
    ENDIF.

    r_color = me.
  ENDMETHOD.


  METHOD constructor.
    me->r = i_r.
    me->g = i_g.
    me->b = i_b.
  ENDMETHOD.


  METHOD divide_and_assign_by_decfloat.
    DIVIDE me->r BY i_value.
    DIVIDE me->g BY i_value.
    DIVIDE me->b BY i_value.

    r_color = me.
  ENDMETHOD.


  METHOD get_quotient_by_decfloat.
    r_color = zcl_art_rgb_color=>new_individual(
      i_r = r / i_value
      i_g = g / i_value
      i_b = b / i_value ).
  ENDMETHOD.


  METHOD multiply_and_assign_by_decflt.
    MULTIPLY me->r BY i_value.
    MULTIPLY me->g BY i_value.
    MULTIPLY me->b BY i_value.

    r_color = me.
  ENDMETHOD.


  METHOD multiply_by_decfloat.
    r_result = NEW #(
      i_r = me->r * i_value
      i_g = me->g * i_value
      i_b = me->b * i_value ).
  ENDMETHOD.


  METHOD new_black.
    r_instance = zcl_art_rgb_color=>new_unified( 0 ).
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


  METHOD new_red.
    r_instance = zcl_art_rgb_color=>new_individual( i_r = 1  i_g = 0  i_b = 0 ).
  ENDMETHOD.


  METHOD new_unified.
    r_instance = NEW #(
      i_r = i_value
      i_g = i_value
      i_b = i_value ).
  ENDMETHOD.


  METHOD new_white.
    r_instance = zcl_art_rgb_color=>new_unified( 1 ).
  ENDMETHOD.


  METHOD powc.
    r_color = zcl_art_rgb_color=>new_individual(
      i_r = r ** i_power
      i_g = g ** i_power
      i_b = b ** i_power ).
  ENDMETHOD.
ENDCLASS.
