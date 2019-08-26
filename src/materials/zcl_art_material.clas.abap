CLASS zcl_art_material DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_material TYPE REF TO zcl_art_material OPTIONAL, "Copy Constructor

      shade
        CHANGING
          c_shading_record TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_color)   TYPE REF TO zcl_art_rgb_color.



  PROTECTED SECTION.
    METHODS:
      "! operator=
      assign
        IMPORTING
          i_rhs           TYPE REF TO zcl_art_material
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_material.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_material IMPLEMENTATION.


  METHOD assign.
    ASSERT i_rhs IS BOUND.
    r_result = me.
    CHECK i_rhs <> me.
  ENDMETHOD.


  METHOD constructor.
    "Copy Constructor
    IF i_material IS BOUND.
      assign( i_material ).
      RETURN.
    ENDIF.

    "Default Constructor
  ENDMETHOD.


  METHOD shade.
    r_color = zcl_art_rgb_color=>new_black( ).
  ENDMETHOD.
ENDCLASS.
