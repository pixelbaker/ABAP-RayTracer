CLASS zcl_art_plane DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_geometric_object
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_plane,

      new_copy
        IMPORTING
          i_plane TYPE REF TO zcl_art_plane
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_plane,

      new_by_normal_and_point
        IMPORTING
          i_normal TYPE REF TO zcl_art_normal
          i_point  TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_plane.


    METHODS:
      hit REDEFINITION.


  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      _co_kepsilon TYPE decfloat16 VALUE '0.001'. "for shadows and secondary rays


    DATA:
      _point  TYPE REF TO zcl_art_point3d, "point through which plane passes
      _normal TYPE REF TO zcl_art_normal. "normal to the plane


    METHODS:
      constructor
        IMPORTING
          i_point  TYPE REF TO zcl_art_point3d
          i_normal TYPE REF TO zcl_art_normal.

ENDCLASS.



CLASS zcl_art_plane IMPLEMENTATION.


  METHOD constructor.
    ASSERT i_point IS BOUND AND
           i_normal IS BOUND.

    super->constructor( ).

    _point = i_point.
    _normal = i_normal.
  ENDMETHOD.


  METHOD hit.
    CLEAR e_tmin.

    DATA t TYPE decfloat16.

    "t = (p - ray.o) * n / ( ray.d * n)
    DATA(difference_vector) = _point->get_difference_from_point( i_ray->origin ).
    DATA(dot_product1) = difference_vector->get_dot_product_by_normal( _normal ).
    DATA(dot_product2) = i_ray->direction->get_dot_product_by_normal( _normal ).
    t = dot_product1 / dot_product2.

    IF t > _co_kepsilon.
      e_tmin = t.

      c_shade_rec->normal = _normal.

      "shadeRec = ray.o + t * ray.d
      DATA(product_vector) = i_ray->direction->get_product_by_decfloat( t ).
      c_shade_rec->local_hit_point = i_ray->origin->get_sum_by_vector( product_vector ).

      r_hit = abap_true.
    ELSE.
      r_hit = abap_false.
    ENDIF.
  ENDMETHOD.


  METHOD new_by_normal_and_point.
    r_instance = NEW #(
      i_point = zcl_art_point3d=>new_copy( i_point )
      i_normal = zcl_art_normal=>new_copy( i_normal ) ).
    r_instance->_normal->normalize( ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #(
      i_point = zcl_art_point3d=>new_copy( i_plane->_point )
      i_normal = zcl_art_normal=>new_copy( i_plane->_normal ) ).
    r_instance->set_color_by_color( zcl_art_rgb_color=>new_copy( i_plane->_color ) ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #(
      i_point = zcl_art_point3d=>new_default( )
      i_normal = zcl_art_normal=>new_default( ) ).
  ENDMETHOD.
ENDCLASS.
