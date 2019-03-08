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
          i_plane           TYPE REF TO zcl_art_plane
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_plane,

      "! Constructs a plane by a point through which the plane passes and the orientation expressed by a normal.
      "!
      "! @parameter i_normal | Normal to the plane
      "! @parameter i_point | Point through which plane passes
      "! @parameter r_instance | A freshly initialized instance
      new_by_normal_and_point
        IMPORTING
          i_normal          TYPE REF TO zcl_art_normal
          i_point           TYPE REF TO zcl_art_point3d
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_plane.


    DATA:
      point  TYPE REF TO zcl_art_point3d READ-ONLY, "point through which plane passes
      normal TYPE REF TO zcl_art_normal READ-ONLY. "normal to the plane


    METHODS:
      hit REDEFINITION.


  PROTECTED SECTION.
  PRIVATE SECTION.
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

    me->point = i_point.
    me->normal = i_normal.
  ENDMETHOD.


  METHOD hit.
    CLEAR e_tmin.

    DATA t TYPE decfloat16.

    "t = (p - ray.o) * n / ( ray.d * n)
    DATA(difference_vector) = me->point->get_difference_by_point( i_ray->origin ).
    DATA(dot_product1) = difference_vector->get_dot_product_by_normal( me->normal ).
    DATA(dot_product2) = i_ray->direction->get_dot_product_by_normal( me->normal ).

    "ABAPs float and decfloat types aren't conforming to the IEEE floating-point standard.
    "Division by zero will not return +/- infinity, that's why we need to handle that by ourselves.
    "In IEEE754 the sign if infinity changes when divided by -0, but that doesn't exist in ABAP DECFLOAT16.
    "I am curious if thats going to bite my ass some day.
    IF dot_product2 <> 0.
      t = dot_product1 / dot_product2.
    ELSE.
      IF dot_product1 < 0.
        t = cl_abap_math=>min_decfloat16.
      ELSE.
        t = cl_abap_math=>max_decfloat16.
      ENDIF.
    ENDIF.

    IF t > zcl_art_constants=>k_epsilon.
      e_tmin = t.

      c_shade_rec->normal->assignment_by_normal( me->normal ).

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
    r_instance->normal->normalize( ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #(
      i_point = zcl_art_point3d=>new_copy( i_plane->point )
      i_normal = zcl_art_normal=>new_copy( i_plane->normal ) ).
    r_instance->set_color_by_color( zcl_art_rgb_color=>new_copy( i_plane->_color ) ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #(
      i_point = zcl_art_point3d=>new_default( )
      i_normal = zcl_art_normal=>new_default( ) ).
  ENDMETHOD.
ENDCLASS.
