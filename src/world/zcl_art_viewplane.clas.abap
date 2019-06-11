CLASS zcl_art_viewplane DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    DATA:
      hres              TYPE int4 READ-ONLY,
      vres              TYPE int4 READ-ONLY,
      pixel_size        TYPE decfloat16 READ-ONLY,

      "! The inverse of the gamma correction factor
      inv_gamma         TYPE decfloat16 READ-ONLY,
      gamma             TYPE decfloat16 READ-ONLY,

      show_out_of_gamut TYPE abap_bool READ-ONLY,

      num_samples       TYPE int4 VALUE 1 READ-ONLY,
      sampler           TYPE REF TO zcl_art_sampler READ-ONLY.


    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_viewplane,

      "! Note! The Sampler won't be copied at the moment.
      "! It will be either multi-jittered or regular depending on your number of samples.
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

      "! This one carries a side effect.
      "! If you already set a sampler for your viewport and it's not the regular or multi-jittered sampler,
      "! you will lose your previously set sampler. It will be replaced with the before mentioned ones.
      "!
      "! @parameter i_num_samples | Should be larger than zero.
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
          i_viewplane TYPE REF TO zcl_art_viewplane OPTIONAL. "Copy Constructor

ENDCLASS.



CLASS zcl_art_viewplane IMPLEMENTATION.


  METHOD assignment.
    ASSERT i_rhs IS BOUND.
    r_viewplane = me.
    CHECK me <> i_rhs.

    me->hres = i_rhs->hres.
    me->vres = i_rhs->vres.
    me->pixel_size = i_rhs->pixel_size.
    me->gamma = i_rhs->gamma.
    me->inv_gamma = i_rhs->inv_gamma.
    me->show_out_of_gamut = i_rhs->show_out_of_gamut.

    set_num_samples( i_rhs->num_samples ).
  ENDMETHOD.


  METHOD constructor.
    "Copy Constructor
    IF i_viewplane IS BOUND.
      assignment( i_viewplane ).
      RETURN.
    ENDIF.

    "Default Constructor
    me->hres = 400.
    me->vres = 400.
    me->pixel_size = '1.0'.
    me->gamma = '1.0'.
    me->inv_gamma = '1.0'.
    me->show_out_of_gamut = abap_false.

    set_num_samples( 1 ).
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_viewplane IS BOUND.

    r_instance = NEW #( i_viewplane = i_viewplane ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
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
    ASSERT i_num_samples > 0.

    me->num_samples = i_num_samples.

    IF me->num_samples > 1.
      me->sampler = zcl_art_multijittered=>new_by_num_samples( me->num_samples ).
    ELSE.
      me->sampler = zcl_art_regular=>new_by_num_samples( 1 ).
    ENDIF.
  ENDMETHOD.


  METHOD set_pixel_size.
    me->pixel_size = i_size.
  ENDMETHOD.


  METHOD set_sampler.
    ASSERT i_sampler IS BOUND.
    me->num_samples = i_sampler->get_num_samples( ).
    me->sampler = i_sampler.
  ENDMETHOD.


  METHOD set_vres.
    me->vres = i_vres.
  ENDMETHOD.
ENDCLASS.

