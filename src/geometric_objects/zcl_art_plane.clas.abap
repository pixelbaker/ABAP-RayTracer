CLASS zcl_art_plane DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_geometric_object
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          VALUE(i_point)  TYPE REF TO zcl_art_point3d OPTIONAL "Constructor with point and normal
          VALUE(i_normal) TYPE REF TO zcl_art_normal OPTIONAL, "Constructor with point and normal


      hit REDEFINITION.



  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      kepsilon TYPE decfloat16 VALUE 0.


    DATA:
      _point  TYPE REF TO zcl_art_point3d,
      _normal TYPE REF TO zcl_art_normal.

ENDCLASS.



CLASS zcl_art_plane IMPLEMENTATION.


  METHOD constructor.
    super->constructor( ).

    IF i_point IS BOUND OR
       i_normal IS BOUND.
      ASSERT i_point IS BOUND AND i_normal IS BOUND.

      _point = i_point.
      _normal = i_normal.
    ENDIF.
  ENDMETHOD.


  METHOD hit.
    DATA t TYPE decfloat16.
    "t = ( _point - i_ray->origin ) * _normal / ( i_ray->direction * _normal ).

    IF t > kepsilon.
      e_tmin = t.
      c_shade_rec->normal = _normal.
      "c_shade_rec->local_hit_point = i_ray->origin + t * i_ray->direction.

      e_hit = abap_true.
    ELSE.
      e_hit = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
