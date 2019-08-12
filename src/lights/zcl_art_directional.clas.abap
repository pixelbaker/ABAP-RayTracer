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
      assign_by_directional
        IMPORTING
          i_rhs                TYPE REF TO zcl_art_directional
        RETURNING
          VALUE(r_directional) TYPE REF TO zcl_art_directional,

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
      "! Original name from the book is 'ls'
      _radiance_scaling_factor TYPE decfloat16,

      _color                   TYPE REF TO zcl_art_rgb_color,

      "! direction the light comes from
      _direction               TYPE REF TO zcl_art_vector3d.


    METHODS:
      constructor
        IMPORTING
          i_directional TYPE REF TO zcl_art_directional OPTIONAL.

ENDCLASS.



CLASS zcl_art_directional IMPLEMENTATION.
  METHOD get_direction.
    r_result = _direction.
  ENDMETHOD.


  METHOD l.
    r_result = _color->multiply_by_decfloat( _radiance_scaling_factor ).
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    "Copy Constructor
    IF i_directional IS BOUND.
      assign_by_directional( i_directional ).
      RETURN.
    ENDIF.

    "Default Constructor
    _radiance_scaling_factor = '1.0'.
    _color = zcl_art_rgb_color=>new_unified( '1.0' ).
    _direction = zcl_art_vector3d=>new_individual( i_x = '0.0'  i_y = '1.0'  i_z = '0.0' ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #( i_directional = i_directional ).
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


  METHOD set_direction_by_components.
    _direction->x = i_dx.
    _direction->y = i_dy.
    _direction->z = i_dz.
    _direction->normalize( ).
  ENDMETHOD.


  METHOD set_direction_by_vector.
    _direction->assignment_by_vector( i_d ).
    _direction->normalize( ).
  ENDMETHOD.


  METHOD assign_by_directional.
    ASSERT i_rhs IS BOUND.
    r_directional = me.
    CHECK me <> i_rhs.

    "super->assign_by_light( i_rhs ).

    _radiance_scaling_factor = i_rhs->_radiance_scaling_factor.
    _color = zcl_art_rgb_color=>new_copy( i_rhs->_color ).
    _direction = zcl_art_vector3d=>new_copy( i_rhs->_direction ).
  ENDMETHOD.
ENDCLASS.
