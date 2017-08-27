CLASS zcl_art_rgb_color DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-DATA:
      black TYPE REF TO zcl_art_rgb_color.


    DATA:
      r TYPE decfloat16,
      g TYPE decfloat16,
      b TYPE decfloat16.



    CLASS-METHODS:
      class_constructor.

    METHODS:
      constructor
        IMPORTING
          i_color TYPE REF TO zcl_art_rgb_color OPTIONAL. "Copy constructor.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ART_RGB_COLOR IMPLEMENTATION.


  METHOD class_constructor.
    CREATE OBJECT black.
    black->r = black->g = black->b = 0.
  ENDMETHOD.


  METHOD constructor.
    IF i_color IS BOUND.
      SYSTEM-CALL OBJMGR CLONE i_color TO me.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
