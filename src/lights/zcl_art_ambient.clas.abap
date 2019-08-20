CLASS zcl_art_ambient DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_light
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_copy
        IMPORTING
          i_ambient         TYPE REF TO zcl_art_ambient
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_ambient,

      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_ambient.


    METHODS:
      assign_by_ambient
        IMPORTING
          i_rhs                TYPE REF TO zcl_art_ambient
        RETURNING
          VALUE(r_directional) TYPE REF TO zcl_art_ambient,

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
          i_b TYPE decfloat16.


  PRIVATE SECTION.
    DATA:
      "! Original name from the book is 'ls'
      _radiance_scaling_factor TYPE decfloat16,

      _color                   TYPE REF TO zcl_art_rgb_color.


    METHODS:
      constructor
        IMPORTING
          i_ambient TYPE REF TO zcl_art_ambient OPTIONAL. "Copy Constructor

ENDCLASS.



CLASS zcl_art_ambient IMPLEMENTATION.
  METHOD new_copy.
    r_instance = NEW #( i_ambient = i_ambient ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.


  METHOD get_direction.
    r_result = zcl_art_vector3d=>new_default( ).
  ENDMETHOD.


  METHOD l.
    r_result = _color->multiply_by_decfloat( _radiance_scaling_factor ).
  ENDMETHOD.


  METHOD scale_radiance.
    _radiance_scaling_factor = i_b.
  ENDMETHOD.


  METHOD set_color_by_color.
    _color->assign_by_color( i_c ).
  ENDMETHOD.


  METHOD set_color_by_components.
    _color->r = i_r.
    _color->g = i_g.
    _color->b = i_b.
  ENDMETHOD.


  METHOD set_color_by_decfloat.
    _color->r = i_c.
    _color->g = i_c.
    _color->b = i_c.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    "Copy Constructor
    IF i_ambient IS BOUND.
      assign_by_ambient( i_ambient ).
      RETURN.
    ENDIF.

    "Default Constructor
    _radiance_scaling_factor = '1.0'.
    _color = zcl_art_rgb_color=>new_unified( '1.0' ).
  ENDMETHOD.


  METHOD assign_by_ambient.
    ASSERT i_rhs IS BOUND.
    r_directional = me.
    CHECK me <> i_rhs.

    "super->assign_by_light( i_rhs ).

    _radiance_scaling_factor = i_rhs->_radiance_scaling_factor.
    _color = zcl_art_rgb_color=>new_copy( i_rhs->_color ).
  ENDMETHOD.
ENDCLASS.
