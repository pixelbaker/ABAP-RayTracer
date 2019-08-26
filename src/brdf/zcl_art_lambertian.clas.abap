"! Implements the perfect diffuse scatterer
CLASS zcl_art_lambertian DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_brdf
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_lambertian,

      new_copy
        IMPORTING
          i_lambertian      TYPE REF TO zcl_art_lambertian
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_lambertian.



    METHODS:
      assign_by_lambertian
        IMPORTING
          i_rhs             TYPE REF TO zcl_art_lambertian
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_lambertian,

      f REDEFINITION,

      sample_f_by_pdf REDEFINITION,

      rho REDEFINITION,

      set_ka
        IMPORTING
          i_ka TYPE decfloat16,

      set_kd
        IMPORTING
          i_kd TYPE decfloat16,

      set_cd_by_color
        IMPORTING
          i_c TYPE REF TO zcl_art_rgb_color,

      set_cd_by_components
        IMPORTING
          i_r TYPE decfloat16
          i_g TYPE decfloat16
          i_b TYPE decfloat16,

      set_cd_by_value
        IMPORTING
          i_c TYPE decfloat16.


  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_lambertian TYPE REF TO zcl_art_lambertian OPTIONAL. "Copy Constructor


    DATA:
      _kd TYPE decfloat16,
      _cd TYPE REF TO zcl_art_rgb_color.

ENDCLASS.



CLASS zcl_art_lambertian IMPLEMENTATION.


  METHOD assign_by_lambertian.
    ASSERT i_rhs IS BOUND.
    r_instance = me.
    CHECK i_rhs <> me.

    assign( i_rhs ).

    _kd = i_rhs->_kd.
    _cd->assign_by_color( i_rhs->_cd ).
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    IF i_lambertian IS BOUND.
      assign_by_lambertian( i_lambertian ).
      RETURN.
    ENDIF.

    "Default Constructor
    _kd = 0.
    _cd = zcl_art_rgb_color=>new_default( ).
  ENDMETHOD.


  METHOD f.
    "there is no sampling here
    r_color = _cd->multiply_by_decfloat( _kd * zcl_art_constants=>inv_pi ).
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_lambertian IS BOUND.

    r_instance = NEW #( i_lambertian = i_lambertian ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.


  METHOD rho.
    r_color = _cd->multiply_by_decfloat( _kd ).
  ENDMETHOD.


  METHOD sample_f_by_pdf.
    " this generates a direction by sampling the hemisphere with a cosine distribution
    " this is called in path_shade for any material with a diffuse shading component
    " the samples have to be stored with a cosine distribution

    DATA(w) = zcl_art_vector3d=>new_from_normal( i_shade_rec->normal ).

    DATA(v) = zcl_art_vector3d=>new_individual(
       i_x = '0.0034'
       i_y = '1'
       i_z = '0.0071' ).
    v = v->get_cross_product( w ).
    v->normalize( ).

    DATA(u) = v->get_cross_product( w ).

    DATA(sp) = _sampler->sample_hemisphere( ).

    DATA(temp_u) = u->get_product_by_decfloat( sp->x ).
    DATA(temp_v) = v->get_product_by_decfloat( sp->y ).
    DATA(temp_w) = w->get_product_by_decfloat( sp->z ).

    c_wi->assignment_by_vector( temp_u->get_sum_by_vector( temp_v->get_sum_by_vector( temp_w ) ) ).
    c_wi->normalize( ).

    c_pdf = c_wi->get_product_by_decfloat( zcl_art_constants=>inv_pi )->get_dot_product_by_normal( i_shade_rec->normal ).

    r_color = _cd->get_quotient_by_decfloat( _kd * zcl_art_constants=>inv_pi ).
  ENDMETHOD.


  METHOD set_cd_by_color.
    ASSERT i_c IS BOUND.
    _cd = i_c.
  ENDMETHOD.


  METHOD set_cd_by_components.
    _cd->r = i_r.
    _cd->g = i_g.
    _cd->b = i_b.
  ENDMETHOD.


  METHOD set_cd_by_value.
    _cd->r = i_c.
    _cd->g = i_c.
    _cd->b = i_c.
  ENDMETHOD.


  METHOD set_ka.
    _kd = i_ka.
  ENDMETHOD.


  METHOD set_kd.
    _kd = i_kd.
  ENDMETHOD.
ENDCLASS.
