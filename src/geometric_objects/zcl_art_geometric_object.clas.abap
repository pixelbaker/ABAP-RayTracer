CLASS zcl_art_geometric_object DEFINITION
  PUBLIC
  ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_object TYPE REF TO zcl_art_geometric_object OPTIONAL, "Copy Constructor

      hit ABSTRACT
        IMPORTING
          i_ray        TYPE REF TO zcl_art_ray
        EXPORTING
          e_tmin       TYPE decfloat16
        CHANGING
          c_shade_rec  TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_hit) TYPE abap_bool,

      get_color
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      get_material
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_material,

      set_material
        IMPORTING
          i_material TYPE REF TO zcl_art_material,

      set_color_by_color
        IMPORTING
          i_color TYPE REF TO zcl_art_rgb_color,

      set_color_by_components
        IMPORTING
          i_r TYPE decfloat16
          i_g TYPE decfloat16
          i_b TYPE decfloat16.


  PROTECTED SECTION.
    DATA:
      _color    TYPE REF TO zcl_art_rgb_color,
      _material TYPE REF TO zcl_art_material.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_geometric_object IMPLEMENTATION.


  METHOD constructor.
    "Copy Constructor
    IF i_object IS SUPPLIED.
      ASSERT i_object IS BOUND.

      _color = zcl_art_rgb_color=>new_copy( i_object->_color ).
      RETURN.
    ENDIF.

    "Default Constructor
    _color = zcl_art_rgb_color=>new_black( ).
  ENDMETHOD.


  METHOD get_color.
    r_color = zcl_art_rgb_color=>new_copy( _color ).
  ENDMETHOD.


  METHOD get_material.
    r_result = _material.
  ENDMETHOD.


  METHOD set_color_by_color.
    ASSERT i_color IS BOUND.
    _color = i_color.
  ENDMETHOD.


  METHOD set_color_by_components.
    _color->r = i_r.
    _color->g = i_g.
    _color->b = i_b.
  ENDMETHOD.


  METHOD set_material.
    ASSERT i_material IS BOUND.
    _material = i_material.
  ENDMETHOD.
ENDCLASS.
