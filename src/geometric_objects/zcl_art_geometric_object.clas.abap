CLASS zcl_art_geometric_object DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_object TYPE REF TO zcl_art_geometric_object OPTIONAL,

      hit ABSTRACT
        IMPORTING
          REFERENCE(i_ray)       TYPE REF TO zcl_art_ray
        EXPORTING
          REFERENCE(e_tmin)      TYPE decfloat16
          VALUE(e_hit)           TYPE abap_bool
        CHANGING
          REFERENCE(c_shade_rec) TYPE REF TO zcl_art_shade_rec.


  PROTECTED SECTION.
    DATA:
      color TYPE REF TO zcl_art_rgb_color.


    METHODS:
      set_color
        IMPORTING
          i_color TYPE REF TO zcl_art_rgb_color.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_geometric_object IMPLEMENTATION.


  METHOD constructor.
    IF i_object IS SUPPLIED.
      ASSERT i_object IS BOUND.

      color = i_object->color.
      RETURN.
    ENDIF.

    color = zcl_art_rgb_color=>black.
  ENDMETHOD.


  METHOD set_color.
    color = i_color.
  ENDMETHOD.

ENDCLASS.
