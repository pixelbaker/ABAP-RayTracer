CLASS zcl_art_rgb_color DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

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
      class_constructor.


    METHODS:
      constructor
        IMPORTING
          VALUE(i_r)         TYPE decfloat16 OPTIONAL
          VALUE(i_g)         TYPE decfloat16 OPTIONAL
          VALUE(i_b)         TYPE decfloat16 OPTIONAL
          REFERENCE(i_color) TYPE REF TO zcl_art_rgb_color OPTIONAL, "Copy constructor.

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


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_rgb_color IMPLEMENTATION.


  METHOD class_constructor.
    CREATE OBJECT white.
    white->r = white->g = white->b = '1.0'.

    CREATE OBJECT black.
    black->r = black->g = black->b = 0.

    CREATE OBJECT red.
    red->r = '1.0'.
    red->g = red->b = 0.
  ENDMETHOD.


  METHOD constructor.
    "Copy constructor
    IF i_color IS SUPPLIED.
      ASSERT i_color IS BOUND.

      r = i_color->r.
      g = i_color->g.
      b = i_color->b.
      RETURN.
    ENDIF.

    "Component constructor
    IF i_r IS SUPPLIED OR
       i_g IS SUPPLIED OR
       i_b IS SUPPLIED.

      ASSERT i_r IS SUPPLIED AND i_g IS SUPPLIED AND i_b IS SUPPLIED.
      r = i_r.
      g = i_g.
      b = i_b.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD get_quotient_by_decfloat.
    CREATE OBJECT r_color
      EXPORTING
        i_r = r / i_value
        i_g = g / i_value
        i_b = b / i_value.
  ENDMETHOD.


  METHOD powc.
    r_color = NEW zcl_art_rgb_color(
      i_r = r ** i_power
      i_g = g ** i_power
      i_b = b ** i_power ).
  ENDMETHOD.
ENDCLASS.
