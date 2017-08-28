CLASS zcl_art_sphere DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_geometric_object
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          VALUE(i_center)     TYPE REF TO zcl_art_point3d OPTIONAL "Constructor with center and radius
          VALUE(i_radius)     TYPE decfloat16 OPTIONAL "Constructor with center and radius
          REFERENCE(i_sphere) TYPE REF TO zcl_art_sphere OPTIONAL, "Copy constructor

      hit REDEFINITION.


  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      kepsilon TYPE decfloat16 VALUE '0.001'. "for shadows and secondary rays


    DATA:
      _center TYPE REF TO zcl_art_point3d,
      _radius TYPE decfloat16.


ENDCLASS.



CLASS zcl_art_sphere IMPLEMENTATION.
  METHOD constructor.
    "Contains a
    "  default constructor and
    "  constructor which needs center and radius and
    "  copy constructor

    super->constructor( ).

    "Constructor (center and radius)
    IF i_center IS SUPPLIED OR
       i_radius IS SUPPLIED.
      ASSERT i_center IS BOUND AND i_radius IS SUPPLIED.

      _center = i_center.
      _radius = i_radius.
      RETURN.
    ENDIF.


    "Copy Constructor
    IF i_sphere IS SUPPLIED.
      ASSERT i_sphere IS BOUND.

      _center = i_sphere->_center.
      _radius = i_sphere->_radius.
      set_color( i_sphere->color ).
      RETURN.
    ENDIF.


    "Default constructor
    CREATE OBJECT _center.
    _radius = '1.0'.
  ENDMETHOD.


  METHOD hit.
    DATA:
      t    TYPE decfloat16,
      temp TYPE REF TO zcl_art_vector3d,
      a    TYPE decfloat16,
      b    TYPE decfloat16,
      c    TYPE decfloat16,
      disc TYPE decfloat16.

    temp = i_ray->origin->get_difference_from_point( _center ).
    a = i_ray->direction->get_dot_product_by_vector( i_ray->direction ).
    b = 2 * temp->get_dot_product_by_vector( i_ray->direction ).
    c = temp->get_dot_product_by_vector( temp ) - _radius * _radius.
    disc = b * b - 4 * a * c.

    IF disc < 0.
      e_hit = abap_false.
      RETURN.
    ELSE.
      DATA e TYPE decfloat16.
      e = sqrt( disc ).

      DATA denom TYPE decfloat16.
      denom = 2 * a.

      t = ( - b - e ) / denom. "smaller root

      IF t > kepsilon.
        e_tmin = t.
        c_shade_rec->normal->assignment_by_vector( i_ray->direction->get_product_by_decfloat( t
            )->get_sum_by_vector( temp
            )->get_quotient_by_decfloat( _radius ) ).
        c_shade_rec->local_hit_point = i_ray->origin->get_sum_by_vector( i_ray->direction->get_product_by_decfloat( t ) ).
        e_hit = abap_true.
        RETURN.
      ENDIF.

      t = ( - b + e ) / denom. "larger root

      IF t > kepsilon.
        e_tmin = t.
        c_shade_rec->normal->assignment_by_vector( i_ray->direction->get_product_by_decfloat( t
            )->get_sum_by_vector( temp
            )->get_quotient_by_decfloat( _radius ) ).
        c_shade_rec->local_hit_point = i_ray->origin->get_sum_by_vector( i_ray->direction->get_product_by_decfloat( t ) ).
        e_hit = abap_true.
        RETURN.
      ENDIF.
    ENDIF.

    e_hit = abap_false.
  ENDMETHOD.

ENDCLASS.
