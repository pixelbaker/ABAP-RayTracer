CLASS zcl_art_directional DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_light
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_copy
        IMPORTING
          i_directional     TYPE REF TO zcl_art_directional
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_directional,

      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_directional.


    METHODS:
      get_direction REDEFINITION,

      l REDEFINITION,

      scale_radiance
        IMPORTING
          i_b TYPE decfloat16,

      set_color_by_decfloat
        IMPORTING
          i_c TYPE decfloat16,

      set_color_by_color
        IMPORTING
          i_c TYPE REF TO zcl_art_rgb_color,

      set_color_by_components
        IMPORTING
          i_r TYPE decfloat16
          i_g TYPE decfloat16
          i_b TYPE decfloat16,

      set_direction_by_vector
        IMPORTING
          i_d TYPE REF TO zcl_art_vector3d,

      set_direction_by_components
        IMPORTING
          i_dx TYPE decfloat16
          i_dy TYPE decfloat16
          i_dz TYPE decfloat16.


  PRIVATE SECTION.
    DATA:
      _ls    TYPE decfloat16,

      _color TYPE REF TO zcl_art_rgb_color,

      "! direction the light comes from
      _dir   TYPE REF TO zcl_art_vector3d.


    METHODS:
      constructor
        IMPORTING
          i_directional TYPE REF TO zcl_art_directional OPTIONAL.

ENDCLASS.



CLASS zcl_art_directional IMPLEMENTATION.
  METHOD get_direction.
  ENDMETHOD.


  METHOD l.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    "Copy Constructor
    IF i_directional IS BOUND.
      RETURN.
    ENDIF.

    "Default Constructor
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #( i_directional = i_directional ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.

  METHOD scale_radiance.
  ENDMETHOD.

  METHOD set_color_by_color.
  ENDMETHOD.

  METHOD set_color_by_components.
  ENDMETHOD.

  METHOD set_color_by_decfloat.
  ENDMETHOD.

  METHOD set_direction_by_components.
  ENDMETHOD.

  METHOD set_direction_by_vector.
  ENDMETHOD.
ENDCLASS.
