CLASS zcl_art_matte DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_material
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_matte,

      new_copy
        IMPORTING
          i_matte           TYPE REF TO zcl_art_matte
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_matte.


    METHODS:
      assign_by_matte
        IMPORTING
          i_rhs             TYPE REF TO zcl_art_matte
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_matte,


      set_ka
        IMPORTING
          i_k TYPE decfloat16,

      set_kd
        IMPORTING
          i_k TYPE decfloat16,


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
          i_c TYPE decfloat16,

      shade REDEFINITION.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_matte TYPE REF TO zcl_art_matte OPTIONAL. "Copy Constructor


    DATA:
      _ambient_brdf TYPE REF TO zcl_art_lambertian,
      _diffuse_brdf TYPE REF TO zcl_art_lambertian.

ENDCLASS.



CLASS zcl_art_matte IMPLEMENTATION.
  METHOD assign_by_matte.
    ASSERT i_rhs IS BOUND.
    r_instance = me.
    CHECK i_rhs <> me.

    IF i_rhs->_ambient_brdf IS BOUND.
      _ambient_brdf = zcl_art_lambertian=>new_copy( i_rhs->_ambient_brdf ).
    ENDIF.

    IF i_rhs->_diffuse_brdf IS BOUND.
      _diffuse_brdf = zcl_art_lambertian=>new_copy( i_rhs->_diffuse_brdf ).
    ENDIF.
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_matte IS BOUND.
    r_instance = NEW #( i_matte = i_matte ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.


  METHOD set_cd_by_color.
    _ambient_brdf->set_cd_by_color( i_c ).
    _diffuse_brdf->set_cd_by_color( i_c ).
  ENDMETHOD.


  METHOD set_cd_by_components.
    _ambient_brdf->set_cd_by_components( i_r = i_r  i_g = i_g  i_b = i_b ).
    _diffuse_brdf->set_cd_by_components( i_r = i_r  i_g = i_g  i_b = i_b ).
  ENDMETHOD.


  METHOD set_cd_by_value.
    _ambient_brdf->set_cd_by_value( i_c ).
    _diffuse_brdf->set_cd_by_value( i_c ).
  ENDMETHOD.


  METHOD set_ka.
    _ambient_brdf->set_kd( i_k ).
  ENDMETHOD.


  METHOD set_kd.
    _diffuse_brdf->set_kd( i_k ).
  ENDMETHOD.


  METHOD shade.
    DATA(wo) = c_shade_rec->ray->direction->reverse( ).

    DATA(rho_color) = _ambient_brdf->rho( i_wo = wo
                                          i_shade_rec = c_shade_rec ).

    DATA(l_color) = c_shade_rec->world->ambient_light->l( c_shade_rec ).

    r_color = rho_color->multiply_by_color( l_color ).

    LOOP AT c_shade_rec->world->lights INTO DATA(light).
      DATA(wi) = light->get_direction( c_shade_rec ).
      DATA(ndotwi) = c_shade_rec->normal->dot_product_by_vector( wi ).

      IF ndotwi > 0.
        DATA(brdf_color) = _diffuse_brdf->f(
          i_wo = wo
          i_wi = wi
          i_shade_rec = c_shade_rec ).
        DATA(light_color) = light->l( c_shade_rec ).

        DATA(new_color) = brdf_color->multiply_by_color( light_color->multiply_by_decfloat( ndotwi ) ).

        r_color->add_and_assign_by_color( new_color ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD constructor.
    super->constructor( ).

    "Copy Constructor
    IF i_matte IS BOUND.
      assign_by_matte( i_matte ).
      RETURN.
    ENDIF.

    "Default Constructor
    _ambient_brdf = zcl_art_lambertian=>new_default( ).
    _diffuse_brdf = zcl_art_lambertian=>new_default( ).
  ENDMETHOD.

ENDCLASS.
