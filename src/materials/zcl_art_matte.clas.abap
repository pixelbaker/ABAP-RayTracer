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
*    DATA:
*    lambertian*   ambient_brdf;
*    lambertian*   diffuse_brdf;
ENDCLASS.



CLASS zcl_art_matte IMPLEMENTATION.
  METHOD assign_by_matte.

  ENDMETHOD.

  METHOD new_copy.

  ENDMETHOD.

  METHOD new_default.

  ENDMETHOD.

  METHOD set_cd_by_color.

  ENDMETHOD.

  METHOD set_cd_by_components.

  ENDMETHOD.

  METHOD set_cd_by_value.

  ENDMETHOD.

  METHOD set_ka.

  ENDMETHOD.

  METHOD set_kd.

  ENDMETHOD.

  METHOD shade.

  ENDMETHOD.

ENDCLASS.
