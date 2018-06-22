CLASS zcl_art_viewplane DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    DATA:
      hres              TYPE int4 READ-ONLY,
      vres              TYPE int4 READ-ONLY,
      pixel_size        TYPE decfloat16 READ-ONLY,

      gamma             TYPE decfloat16 READ-ONLY,
      inv_gamma         TYPE decfloat16 READ-ONLY, "the inverse of the gamma correction factor

      show_out_of_gamut TYPE abap_bool READ-ONLY,

      num_samples       TYPE int4 VALUE 1 READ-ONLY,
      sampler           TYPE REF TO zcl_art_sampler READ-ONLY.


    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_viewplane,

      new_copy
        IMPORTING
          i_viewplane       TYPE REF TO zcl_art_viewplane
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_viewplane.


    METHODS:
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
          i_show TYPE abap_bool,

      set_num_samples
        IMPORTING
          i_num_samples LIKE num_samples,

      set_sampler
        IMPORTING
          i_sampler TYPE REF TO zcl_art_sampler.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_hres              TYPE int4
          i_vres              TYPE int4
          i_num_samples       TYPE int4
          i_pixel_size        TYPE decfloat16
          i_gamma             TYPE decfloat16
          i_inv_gamma         TYPE decfloat16
          i_show_out_of_gamut TYPE abap_bool.

ENDCLASS.



CLASS zcl_art_viewplane IMPLEMENTATION.


  METHOD assignment.
    r_viewplane = me.

    IF me = i_rhs.
      RETURN.
    ENDIF.

    me->hres = i_rhs->hres.
    me->vres = i_rhs->vres.
    me->pixel_size = i_rhs->pixel_size.
    me->gamma = i_rhs->gamma.
    me->inv_gamma = i_rhs->inv_gamma.
    me->show_out_of_gamut = i_rhs->show_out_of_gamut.
  ENDMETHOD.


  METHOD constructor.
    me->hres = i_hres.
    me->vres = i_vres.
    me->pixel_size = i_pixel_size.
    me->gamma = i_gamma.
    me->inv_gamma = i_inv_gamma.
    me->show_out_of_gamut = i_show_out_of_gamut.
    set_num_samples( i_num_samples ).
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_viewplane IS BOUND.

    r_instance = NEW #(
      i_hres = i_viewplane->hres
      i_vres = i_viewplane->vres
      i_num_samples = i_viewplane->num_samples
      i_pixel_size = i_viewplane->pixel_size
      i_gamma = i_viewplane->gamma
      i_inv_gamma = i_viewplane->inv_gamma
      i_show_out_of_gamut = i_viewplane->show_out_of_gamut ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #(
      i_hres = 400
      i_vres = 400
      i_num_samples = 1
      i_pixel_size = '1.0'
      i_gamma = '1.0'
      i_inv_gamma = '1.0'
      i_show_out_of_gamut = abap_false ).
  ENDMETHOD.


  METHOD set_gamma.
    me->gamma = i_gamma.
    me->inv_gamma = '1.0' / gamma.
  ENDMETHOD.


  METHOD set_gamut_display.
    me->show_out_of_gamut = i_show.
  ENDMETHOD.


  METHOD set_hres.
    me->hres = i_hres.
  ENDMETHOD.


  METHOD set_num_samples.
    me->num_samples = i_num_samples.

    IF me->num_samples > 1.
      me->sampler = zcl_art_multijittered=>new_by_num_samples( i_num_samples ).
    ELSE.
      me->sampler = zcl_art_regular=>new_by_num_samples( 1 ).
    ENDIF.
  ENDMETHOD.


  METHOD set_pixel_size.
    me->pixel_size = i_size.
  ENDMETHOD.


  METHOD set_sampler.
    me->num_samples = i_sampler->get_num_samples( ).
    me->sampler = i_sampler.
  ENDMETHOD.


  METHOD set_vres.
    me->vres = i_vres.
  ENDMETHOD.
ENDCLASS.
