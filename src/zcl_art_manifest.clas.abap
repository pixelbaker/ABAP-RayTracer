CLASS zcl_art_manifest DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      zif_apack_manifest.


    METHODS:
      constructor.

ENDCLASS.



CLASS zcl_art_manifest IMPLEMENTATION.
  METHOD constructor.
    zif_apack_manifest~descriptor = VALUE #(
      group_id = 'pixelbaker.com'
      artifact_id = 'abap-raytracer'
      version = '0.14.0'
      git_url = 'https://github.com/pixelbaker/ABAP-RayTracer.git' ).
  ENDMETHOD.
ENDCLASS.
