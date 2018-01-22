CLASS zcl_art_sphere DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_geometric_object
  FINAL
  CREATE PRIVATE.


  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_sphere,

      new_copy
        IMPORTING
          REFERENCE(i_sphere) TYPE REF TO zcl_art_sphere
        RETURNING
          VALUE(r_instance)   TYPE REF TO zcl_art_sphere,

      new_by_center_and_radius
        IMPORTING
          REFERENCE(i_center) TYPE REF TO zcl_art_point3d
          VALUE(i_radius)     TYPE decfloat16
        RETURNING
          VALUE(r_instance)   TYPE REF TO zcl_art_sphere.


    METHODS:
      hit REDEFINITION,

      set_center_by_value
        IMPORTING
          i_value TYPE decfloat16,

      set_center_by_components
        IMPORTING
          i_x TYPE decfloat16
          i_y TYPE decfloat16
          i_z TYPE decfloat16,

      set_center_by_point
        IMPORTING
          i_point TYPE REF TO zcl_art_point3d,

      set_radius
        IMPORTING
          i_radius TYPE decfloat16.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      _center TYPE REF TO zcl_art_point3d,
      _radius TYPE decfloat16.


    METHODS:
      constructor
        IMPORTING
          VALUE(i_center) TYPE REF TO zcl_art_point3d
          VALUE(i_radius) TYPE decfloat16,

      calc_normal_and_hit_point
        IMPORTING
          i_ray       TYPE REF TO zcl_art_ray
          i_t         TYPE decfloat16
          i_temp      TYPE REF TO zcl_art_vector3d
        CHANGING
          c_shade_rec TYPE REF TO zcl_art_shade_rec.

ENDCLASS.



CLASS zcl_art_sphere IMPLEMENTATION.
  METHOD constructor.
    ASSERT i_center IS BOUND.

    super->constructor( ).

    _center = i_center.
    _radius = i_radius.
  ENDMETHOD.


  METHOD hit.
    CLEAR e_tmin.

    DATA:
      t            TYPE decfloat16,
      temp         TYPE REF TO zcl_art_vector3d,
      a            TYPE decfloat16,
      b            TYPE decfloat16,
      c            TYPE decfloat16,
      discriminant TYPE decfloat16.

    temp = i_ray->origin->get_difference_from_point( _center ).
    a = i_ray->direction->get_dot_product_by_vector( i_ray->direction ).
    b = 2 * temp->get_dot_product_by_vector( i_ray->direction ).
    c = temp->get_dot_product_by_vector( temp ) - _radius * _radius.
    discriminant = b * b - 4 * a * c. "https://en.wikipedia.org/wiki/Discriminant

    IF discriminant < 0.
      r_hit = abap_false.
      RETURN.
    ELSE.
      DATA e TYPE decfloat16.
      e = sqrt( discriminant ).

      DATA denominator TYPE decfloat16.
      denominator = 2 * a.

      t = ( - b - e ) / denominator. "smaller root
      IF t > zcl_art_constants=>k_epsilon.
        e_tmin = t.

        calc_normal_and_hit_point(
          EXPORTING
            i_ray = i_ray
            i_t = t
            i_temp = temp
          CHANGING
            c_shade_rec = c_shade_rec ).

        r_hit = abap_true.
        RETURN.
      ENDIF.

      t = ( - b + e ) / denominator. "larger root

      IF t > zcl_art_constants=>k_epsilon.
        e_tmin = t.

        calc_normal_and_hit_point(
          EXPORTING
            i_ray = i_ray
            i_t = t
            i_temp = temp
          CHANGING
            c_shade_rec = c_shade_rec ).

        r_hit = abap_true.
        RETURN.
      ENDIF.
    ENDIF.

    r_hit = abap_false.
  ENDMETHOD.


  METHOD calc_normal_and_hit_point.
    "sr.normal = (temp + t * ray.direction) / radius;

    DATA(vector) = i_ray->direction->get_product_by_decfloat( i_t ).
    DATA(normal) = vector->get_sum_by_vector( i_temp ).
    normal = normal->get_quotient_by_decfloat( _radius ).
    c_shade_rec->normal->assignment_by_vector( normal ).
    c_shade_rec->local_hit_point = i_ray->origin->get_sum_by_vector( vector ).
  ENDMETHOD.


  METHOD new_by_center_and_radius.
    ASSERT i_center IS BOUND.

    r_instance = NEW #(
      i_center = zcl_art_point3d=>new_copy( i_center )
      i_radius = i_radius ).
  ENDMETHOD.


  METHOD new_copy.
    ASSERT i_sphere IS BOUND.

    r_instance = NEW #(
      i_center = zcl_art_point3d=>new_copy( i_sphere->_center )
      i_radius = i_sphere->_radius ).
    r_instance->set_color_by_color( zcl_art_rgb_color=>new_copy( i_sphere->_color ) ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #(
      i_center = zcl_art_point3d=>new_default( )
      i_radius = '1.0' ).
  ENDMETHOD.


  METHOD set_center_by_components.
    _center->x = i_x.
    _center->y = i_y.
    _center->z = i_z.
  ENDMETHOD.


  METHOD set_center_by_point.
    ASSERT i_point IS BOUND.
    _center = i_point.
  ENDMETHOD.


  METHOD set_center_by_value.
    _center->x = _center->y = _center->z = i_value.
  ENDMETHOD.


  METHOD set_radius.
    _radius = i_radius.
  ENDMETHOD.
ENDCLASS.
