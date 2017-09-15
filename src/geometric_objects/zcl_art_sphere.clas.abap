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

      hit REDEFINITION,

      set_center
        IMPORTING
          i_point TYPE REF TO zcl_art_point3d OPTIONAL
          i_value TYPE decfloat16 OPTIONAL
          i_x     TYPE decfloat16 OPTIONAL
          i_y     TYPE decfloat16 OPTIONAL
          i_z     TYPE decfloat16 OPTIONAL,

      set_radius
        IMPORTING
          i_radius TYPE decfloat16.


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
      set_color( i_sphere->_color ).
      RETURN.
    ENDIF.


    "Default constructor
    _center = zcl_art_point3d=>new_default( ).
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
    b = '2.0' * temp->get_dot_product_by_vector( i_ray->direction ).
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


  METHOD set_center.
    IF i_point IS SUPPLIED.
      ASSERT i_point IS BOUND.
      _center = i_point.
      RETURN.
    ENDIF.


    IF i_value IS SUPPLIED.
      _center->x = _center->y = _center->z = i_value.
      RETURN.
    ENDIF.


    IF i_x IS SUPPLIED OR i_y IS SUPPLIED OR i_z IS SUPPLIED.
      ASSERT i_x IS SUPPLIED AND i_y IS SUPPLIED AND i_z IS SUPPLIED.
      _center->x = i_x.
      _center->y = i_y.
      _center->z = i_z.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD set_radius.
    _radius = i_radius.
  ENDMETHOD.
ENDCLASS.
