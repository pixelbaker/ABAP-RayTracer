CLASS zcl_art_plane DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_geometric_object
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          VALUE(i_point)     TYPE REF TO zcl_art_point3d OPTIONAL "Constructor with point and normal
          VALUE(i_normal)    TYPE REF TO zcl_art_normal OPTIONAL "Constructor with point and normal
          REFERENCE(i_plane) TYPE REF TO zcl_art_plane OPTIONAL, "Copy constructor

      hit REDEFINITION.



  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      kepsilon TYPE decfloat16 VALUE '0.001'. "for shadows and secondary rays


    DATA:
      _point  TYPE REF TO zcl_art_point3d, "point through which plane passes
      _normal TYPE REF TO zcl_art_normal. "normal to the plane

ENDCLASS.



CLASS zcl_art_plane IMPLEMENTATION.


  METHOD constructor.
    "Contains a
    "  default constructor and
    "  constructor which needs point and normal and
    "  copy constructor

    super->constructor( ).

    "Constructor (point and normal)
    IF i_point IS BOUND OR
       i_normal IS BOUND.
      ASSERT i_point IS BOUND AND i_normal IS BOUND.

      _point = i_point.
      _normal = i_normal.

      _normal->normalize( ).
      RETURN.
    ENDIF.


    "Copy Constructor
    IF i_plane IS SUPPLIED.
      ASSERT i_plane IS BOUND.

      _point = i_plane->_point.
      _normal = i_plane->_normal.
      RETURN.
    ENDIF.


    "Default constructor
    CREATE OBJECT _point.
    CREATE OBJECT _normal.

  ENDMETHOD.


  METHOD hit.
    DATA t TYPE decfloat16.
    "t = (p - ray.o) * n / ( ray.d * n)
    t = _point->subtract_point( i_ray->origin )->dot_product_normal( _normal ) / i_ray->direction->dot_product_normal( _normal ).

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
