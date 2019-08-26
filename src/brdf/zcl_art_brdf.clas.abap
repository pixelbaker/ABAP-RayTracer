CLASS zcl_art_brdf DEFINITION
  PUBLIC
  ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_brdf TYPE REF TO zcl_art_brdf OPTIONAL, "copy constructor

      assign
        IMPORTING
          i_rhs             TYPE REF TO zcl_art_brdf
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_brdf,

      set_sampler
        IMPORTING
          i_sampler TYPE REF TO zcl_art_sampler,

      f
        IMPORTING
          i_wo           TYPE REF TO zcl_art_vector3d
          i_wi           TYPE REF TO zcl_art_vector3d
          i_shade_rec    TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      sample_f
        IMPORTING
          i_wo           TYPE REF TO zcl_art_vector3d
          i_shade_rec    TYPE REF TO zcl_art_shade_rec
        CHANGING
          c_wi           TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      sample_f_by_pdf
        IMPORTING
          i_wo           TYPE REF TO zcl_art_vector3d
          i_shade_rec    TYPE REF TO zcl_art_shade_rec
        CHANGING
          c_wi           TYPE REF TO zcl_art_vector3d
          c_pdf          TYPE decfloat16
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color,

      rho
        IMPORTING
          i_wo           TYPE REF TO zcl_art_vector3d
          i_shade_rec    TYPE REF TO zcl_art_shade_rec
        RETURNING
          VALUE(r_color) TYPE REF TO zcl_art_rgb_color.


  PROTECTED SECTION.
    DATA:
      "! for indirect illumination
      _sampler TYPE REF TO zcl_art_sampler.

ENDCLASS.



CLASS zcl_art_brdf IMPLEMENTATION.
  METHOD assign.
    ASSERT i_rhs IS BOUND.
    r_instance = me.
    CHECK i_rhs <> me.

    IF i_rhs->_sampler IS BOUND.
      SYSTEM-CALL OBJMGR CLONE i_rhs->_sampler TO me->_sampler.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    "Copy Constructor
    IF i_brdf IS BOUND.
      assign( i_brdf ).
      RETURN.
    ENDIF.

    "Default Constructor
  ENDMETHOD.


  METHOD set_sampler.
    ASSERT i_sampler IS BOUND.
    _sampler = i_sampler.

    "For perfect diffuse
    _sampler->map_samples_to_hemisphere( 1 ).
  ENDMETHOD.


  METHOD f.
    r_color = zcl_art_rgb_color=>new_black( ).
  ENDMETHOD.


  METHOD rho.
    r_color = zcl_art_rgb_color=>new_black( ).
  ENDMETHOD.


  METHOD sample_f.
    r_color = zcl_art_rgb_color=>new_black( ).
  ENDMETHOD.


  METHOD sample_f_by_pdf.
    r_color = zcl_art_rgb_color=>new_black( ).
  ENDMETHOD.
ENDCLASS.
