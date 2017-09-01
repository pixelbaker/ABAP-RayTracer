CLASS zcl_art_vector3d DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      x TYPE decfloat16 READ-ONLY,
      y TYPE decfloat16 READ-ONLY,
      z TYPE decfloat16 READ-ONLY.


    METHODS:
      constructor
        IMPORTING
          VALUE(i_value)      TYPE decfloat16 OPTIONAL
          VALUE(i_x)          TYPE decfloat16 OPTIONAL
          VALUE(i_y)          TYPE decfloat16 OPTIONAL
          VALUE(i_z)          TYPE decfloat16 OPTIONAL
          REFERENCE(i_vector) TYPE REF TO zcl_art_vector3d OPTIONAL
          REFERENCE(i_normal) TYPE REF TO zcl_art_normal OPTIONAL
          REFERENCE(i_point)  TYPE REF TO zcl_art_point3d OPTIONAL,

      get_dot_product_by_normal
        IMPORTING
          i_normal             TYPE REF TO zcl_art_normal
        RETURNING
          VALUE(r_dot_product) TYPE decfloat16,

      get_dot_product_by_vector
        IMPORTING
          i_vector             TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_dot_product) TYPE decfloat16,

      get_sum_by_vector
        IMPORTING
          i_vector        TYPE REF TO zcl_art_vector3d
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      get_product_by_decfloat
        IMPORTING
          i_value         TYPE decfloat16
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d,

      get_quotient_by_decfloat
        IMPORTING
          i_value         TYPE decfloat16
        RETURNING
          VALUE(r_vector) TYPE REF TO zcl_art_vector3d.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ART_VECTOR3D IMPLEMENTATION.


  METHOD constructor.
    IF i_value IS SUPPLIED.
      x = y = z = i_value.
      RETURN.
    ENDIF.


    IF i_x IS SUPPLIED OR
       i_y IS SUPPLIED OR
       i_z IS SUPPLIED.

      ASSERT i_x IS SUPPLIED AND i_y IS SUPPLIED AND i_z IS SUPPLIED.

      x = i_x.
      y = i_y.
      z = i_z.
      RETURN.
    ENDIF.


    "Constructs a vector from a point
    IF i_point IS SUPPLIED.
      ASSERT i_point IS BOUND.

      x = i_point->x.
      y = i_point->y.
      z = i_point->z.
      RETURN.
    ENDIF.


    "Copy Constructor
    IF i_vector IS SUPPLIED.
      ASSERT i_vector IS BOUND.

      x = i_vector->x.
      y = i_vector->y.
      z = i_vector->z.
      RETURN.
    ENDIF.


    "Constructs a vector from a Normal
    IF i_normal IS SUPPLIED.
      ASSERT i_normal IS BOUND.

      x = i_normal->x.
      y = i_normal->y.
      z = i_normal->z.
      RETURN.
    ENDIF.


    "Default constructor
    x = y = z = '0.0'.
  ENDMETHOD.


  METHOD get_dot_product_by_normal.
    r_dot_product = x * i_normal->x + y * i_normal->y + z * i_normal->z.
  ENDMETHOD.


  METHOD get_dot_product_by_vector.
    r_dot_product = x * i_vector->x + y * i_vector->y + z * i_vector->z.
  ENDMETHOD.


  METHOD get_product_by_decfloat.
    CREATE OBJECT r_vector
      EXPORTING
        i_x = x * i_value
        i_y = y * i_value
        i_z = z * i_value.
  ENDMETHOD.


  METHOD get_quotient_by_decfloat.
    CREATE OBJECT r_vector
      EXPORTING
        i_x = x / i_value
        i_y = y / i_value
        i_z = z / i_value.
  ENDMETHOD.


  METHOD get_sum_by_vector.
    CREATE OBJECT r_vector
      EXPORTING
        i_x = x + i_vector->x
        i_y = y + i_vector->y
        i_z = z + i_vector->z.
  ENDMETHOD.
ENDCLASS.