CLASS zcl_art_light DEFINITION
  PUBLIC
  ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      get_direction ABSTRACT
        IMPORTING
          i_sr            TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_vector3d,

      "! Calculates the incident radiance of the hit point
      l ABSTRACT
        IMPORTING
          i_shading_record TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_result)  TYPE REF TO zcl_art_rgb_color.

ENDCLASS.



CLASS zcl_art_light IMPLEMENTATION.

ENDCLASS.
