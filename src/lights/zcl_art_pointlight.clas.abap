CLASS zcl_art_pointlight DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_light
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_copy
        IMPORTING
          i_pointlight      TYPE REF TO zcl_art_pointlight
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_pointlight,

      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_pointlight.


    METHODS:
      assign_by_pointlight
        IMPORTING
          i_rhs               TYPE REF TO zcl_art_pointlight
        RETURNING
          VALUE(r_pointlight) TYPE REF TO zcl_art_pointlight,

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

      set_location_by_point
        IMPORTING
          i_location TYPE REF TO zcl_art_point3d,

      set_location_by_components
        IMPORTING
          i_dx TYPE decfloat16
          i_dy TYPE decfloat16
          i_dz TYPE decfloat16.


  PRIVATE SECTION.
    DATA:
      "! Original name from the book is 'ls'
      _radiance_scaling_factor TYPE decfloat16,

      _color                   TYPE REF TO zcl_art_rgb_color,

      _location                TYPE REF TO zcl_art_point3d.


    METHODS:
      constructor
        IMPORTING
          i_pointlight TYPE REF TO zcl_art_pointlight OPTIONAL. "Copy Constructor

ENDCLASS.



CLASS zcl_art_pointlight IMPLEMENTATION.
  METHOD get_direction.
    DATA(vector) = _location->get_difference_by_point( i_sr->hit_point ).
    r_result = vector->hat( ).
  ENDMETHOD.


  METHOD l.
    r_result = _color->multiply_by_decfloat( _radiance_scaling_factor ).
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    "Copy Constructor
    IF i_pointlight IS BOUND.
      assign_by_pointlight( i_pointlight ).
      RETURN.
    ENDIF.

    "Default Constructor
    _radiance_scaling_factor = '1.0'.
    _color = zcl_art_rgb_color=>new_unified( '1.0' ).
    _location = zcl_art_point3d=>new_default( ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #( i_pointlight = i_pointlight ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
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


  METHOD set_location_by_components.
    _location->x = i_dx.
    _location->y = i_dy.
    _location->z = i_dz.
  ENDMETHOD.


  METHOD set_location_by_point.
    _location->assignment( i_location ).
  ENDMETHOD.


  METHOD assign_by_pointlight.
    ASSERT i_rhs IS BOUND.
    r_pointlight = me.
    CHECK me <> i_rhs.

    "super->assign_by_light( i_rhs ).

    _radiance_scaling_factor = i_rhs->_radiance_scaling_factor.
    _color = zcl_art_rgb_color=>new_copy( i_rhs->_color ).
    _location = zcl_art_point3d=>new_copy( i_rhs->_location ).
  ENDMETHOD.
ENDCLASS.
