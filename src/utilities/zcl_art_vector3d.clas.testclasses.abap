CLASS ucl_art_vector3d DEFINITION
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT
  FINAL.


  PRIVATE SECTION.
    METHODS:
      new_copy FOR TESTING,
      new_default FOR TESTING,
      new_from_normal FOR TESTING,
      new_from_point FOR TESTING,
      new_individual FOR TESTING,
      new_unified FOR TESTING,

      get_dot_product_by_normal1 FOR TESTING,
      get_dot_product_by_normal2 FOR TESTING,
      get_dot_product_by_normal3 FOR TESTING,
      get_dot_product_by_normal4 FOR TESTING,

      normalize1 FOR TESTING,
      normalize2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_vector3d IMPLEMENTATION.



  METHOD get_dot_product_by_normal1.
    "Normal with all components 0

    "Given
    DATA(normal) = zcl_art_normal=>new_unified( 0 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(dot_product) = cut->get_dot_product_by_normal( normal ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      act = dot_product
      exp = 0 ).
  ENDMETHOD.


  METHOD get_dot_product_by_normal2.
    "Normal with all components negative

    "Given
    DATA(normal) = zcl_art_normal=>new_unified( -1 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(dot_product) = cut->get_dot_product_by_normal( normal ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      act = dot_product
      exp = -3 ).
  ENDMETHOD.


  METHOD get_dot_product_by_normal3.
    "Normal with all components positive

    "Given
    DATA(normal) = zcl_art_normal=>new_unified( 1 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(dot_product) = cut->get_dot_product_by_normal( normal ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      act = dot_product
      exp = 3 ).
  ENDMETHOD.


  METHOD get_dot_product_by_normal4.
    "Vector and normal are orthogonal, which should result in a zero dot product

    "Given
    DATA(normal) = zcl_art_normal=>new_individual( i_x = 0  i_y = 1  i_z = 0 ).
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 ).

    "When
    DATA(dot_product) = cut->get_dot_product_by_normal( normal ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      act = dot_product
      exp = 0 ).
  ENDMETHOD.


  METHOD new_copy.
    "Copy constructor generates a new instance of a vector based on another vector

    "Given
    DATA(vector) = zcl_art_vector3d=>new_individual(
      i_x = 5
      i_y = 6
      i_z = 7 ).

    "When
    DATA(cut) = zcl_art_vector3d=>new_copy( vector ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN vector <> cut THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 6 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 7 ).
  ENDMETHOD.


  METHOD new_default.
    "Default constructor generates vector with all components zero

    "When
    DATA(cut) = zcl_art_vector3d=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 0 ).
  ENDMETHOD.


  METHOD new_from_normal.
    "Constructs a new instance of a vector based on a normal

    "Given
    DATA(normal) = zcl_art_normal=>new_individual(
      i_x = 8
      i_y = 9
      i_z = 10 ).

    "When
    DATA(cut) = zcl_art_vector3d=>new_from_normal( normal ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 8 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 9 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 10 ).
  ENDMETHOD.


  METHOD new_from_point.
    "Constructs a new instance of a vector based on a point

    "Given
    DATA(point) = zcl_art_point3d=>new_individual(
      i_x = 1
      i_y = 3
      i_z = 5 ).

    "When
    DATA(cut) = zcl_art_vector3d=>new_from_point( point ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 5 ).
  ENDMETHOD.


  METHOD new_individual.
    "Individual constructor generates vector according to components

    "When
    DATA(cut) = zcl_art_vector3d=>new_individual(
      i_x = 2
      i_y = 3
      i_z = 4 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 4 ).

  ENDMETHOD.


  METHOD new_unified.
    "Unified constructor generates vector with all components one

    "When
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD normalize1.
    "Normalize a zero vector

    "Given
    DATA(cut) = zcl_art_vector3d=>new_unified( 0 ).

    "When
    cut->normalize( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 0 ).
  ENDMETHOD.


  METHOD normalize2.
    "Normalize a vector

    "Given
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    cut->normalize( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = '0.5773502691896259' ).
  ENDMETHOD.

ENDCLASS.
