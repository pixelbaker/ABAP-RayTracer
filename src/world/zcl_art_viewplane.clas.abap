CLASS zcl_art_viewplane DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      hres              TYPE int4,
      vres              TYPE int4,
      s                 TYPE decfloat16, "pixel size

      gamma             TYPE decfloat16,
      inv_gamma         TYPE decfloat16, "the inverse of the gamma correction factor

      show_out_of_gamut TYPE abap_bool.

    METHODS:
      constructor
        IMPORTING
          i_viewplane TYPE REF TO zcl_art_viewplane OPTIONAL,

      assignment
        IMPORTING
          i_rhs              TYPE REF TO zcl_art_viewplane
        RETURNING
          VALUE(r_viewplane) TYPE REF TO zcl_art_viewplane,

      set_hres
        IMPORTING
          i_hres TYPE int4,

      set_vres
        IMPORTING
          i_vres TYPE int4,

      set_pixel_size
        IMPORTING
          i_size TYPE decfloat16,

      set_gamma
        IMPORTING
          i_gamma TYPE decfloat16,

      set_gamut_display
        IMPORTING
          i_show TYPE abap_bool.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_viewplane IMPLEMENTATION.
  METHOD assignment.
    IF me = i_rhs.
      r_viewplane = me.
      RETURN.
    ENDIF.

    hres = i_rhs->hres.
    vres = i_rhs->vres.
    s = i_rhs->s.
    gamma = i_rhs->gamma.
    inv_gamma = i_rhs->inv_gamma.
    show_out_of_gamut = i_rhs->show_out_of_gamut.

    r_viewplane = me.
  ENDMETHOD.


  METHOD constructor.
    "Copy constructor
    IF i_viewplane IS SUPPLIED.
      ASSERT i_viewplane IS BOUND.

      hres = i_viewplane->hres.
      vres = i_viewplane->vres.
      s = i_viewplane->s.
      gamma = i_viewplane->gamma.
      inv_gamma = i_viewplane->inv_gamma.
      show_out_of_gamut = i_viewplane->show_out_of_gamut.
      RETURN.
    ENDIF.


    "Default constructor
    hres = 400.
    vres = 400.
    s = '1.0'.
    gamma = '1.0'.
    inv_gamma = '1.0'.
    show_out_of_gamut = abap_false.
    RETURN.
  ENDMETHOD.


  METHOD set_gamma.
    gamma = i_gamma.
    inv_gamma = '1.0' / gamma.
  ENDMETHOD.


  METHOD set_gamut_display.
    show_out_of_gamut = i_show.
  ENDMETHOD.


  METHOD set_hres.
    hres = i_hres.
  ENDMETHOD.


  METHOD set_vres.
    vres = i_vres.
  ENDMETHOD.


  METHOD set_pixel_size.
    s = i_size.
  ENDMETHOD.
ENDCLASS.
