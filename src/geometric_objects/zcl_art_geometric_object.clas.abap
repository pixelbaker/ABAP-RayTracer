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
          REFERENCE(i_ray)       TYPE REF TO zcl_art_ray
        EXPORTING
          VALUE(e_tmin)          TYPE decfloat16
          VALUE(e_hit)           TYPE abap_bool
        CHANGING
          REFERENCE(c_shade_rec) TYPE REF TO zcl_art_shade_rec,

      get_color
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color.


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
    _color = zcl_art_rgb_color=>black.
  ENDMETHOD.


  METHOD get_color.
    r_color = _color.
  ENDMETHOD.


  METHOD set_color.
    _color = i_color.
  ENDMETHOD.
ENDCLASS.
