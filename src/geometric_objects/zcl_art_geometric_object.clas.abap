CLASS zcl_art_geometric_object DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

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
      _color TYPE REF TO zcl_art_rgb_color.


    METHODS:
      set_color
        IMPORTING
          i_color TYPE REF TO zcl_art_rgb_color.


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
    _color = zcl_art_rgb_color=>new_copy( zcl_art_rgb_color=>black ).
  ENDMETHOD.


  METHOD get_color.
    r_color = _color.
  ENDMETHOD.


  METHOD set_color.
    _color = i_color.
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
ENDCLASS.
