CLASS zcl_art_geometric_object DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
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


  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ART_GEOMETRIC_OBJECT IMPLEMENTATION.
ENDCLASS.
