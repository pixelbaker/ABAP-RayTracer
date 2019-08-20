CLASS ucl_art_vector3d DEFINITION
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT
  FINAL.


  PRIVATE SECTION.
    METHODS:
      assignment_by_vector1 FOR TESTING,
      assignment_by_vector2 FOR TESTING,

      get_cross_product1 FOR TESTING,
      get_cross_product2 FOR TESTING,

      get_difference_by_vector1 FOR TESTING,

      get_dot_product_by_normal1 FOR TESTING,
      get_dot_product_by_normal2 FOR TESTING,
      get_dot_product_by_normal3 FOR TESTING,
      get_dot_product_by_normal4 FOR TESTING,

      get_dot_product_by_vector1 FOR TESTING,
      get_dot_product_by_vector2 FOR TESTING,
      get_dot_product_by_vector3 FOR TESTING,
      get_dot_product_by_vector4 FOR TESTING,

      get_product_by_decfloat1 FOR TESTING,
      get_product_by_decfloat2 FOR TESTING,
      get_product_by_decfloat3 FOR TESTING,

      get_product_by_matrix1 FOR TESTING,
      get_product_by_matrix2 FOR TESTING,

      get_quotient_by_decfloat1 FOR TESTING,
      get_quotient_by_decfloat2 FOR TESTING,
      get_quotient_by_decfloat3 FOR TESTING,

      get_sum_by_vector1 FOR TESTING,

      new_copy FOR TESTING,
      new_default FOR TESTING,
      new_from_normal FOR TESTING,
      new_from_point FOR TESTING,
      new_individual FOR TESTING,
      new_unified FOR TESTING,

      hat FOR TESTING,
      normalize1 FOR TESTING,
      normalize2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_vector3d IMPLEMENTATION.
  METHOD get_cross_product1.
    "Create cross product between two zero vectors

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( 0 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 0 ).

    "When
    DATA(result) = cut->get_cross_product( vector ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> cut ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( result <> vector ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 0 ).
  ENDMETHOD.


  METHOD get_cross_product2.
    "Create cross product between two valid vectors and check that no component from vector or cut has been changed.

    "Given
    DATA(vector) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 4  i_y = 5  i_z = 6 ).

    "When
    DATA(result) = cut->get_cross_product( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = -6 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 3 ).

    cl_abap_unit_assert=>assert_equals( act = vector->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = vector->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = vector->z  exp = 3 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 6 ).
  ENDMETHOD.


  METHOD get_difference_by_vector1.
    "Get the difference between two vectors expressed by a new instance of a vector

    "Given
    DATA(vector) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 4  i_y = 5  i_z = 6 ).

    "When
    DATA(result) = cut->get_difference_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 3 ).

    cl_abap_unit_assert=>assert_equals( act = vector->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = vector->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = vector->z  exp = 3 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 6 ).
  ENDMETHOD.


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


  METHOD get_dot_product_by_vector1.
    "Vector with all components 0

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( 0 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(dot_product) = cut->get_dot_product_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      act = dot_product
      exp = 0 ).
  ENDMETHOD.


  METHOD get_dot_product_by_vector2.
    "Vector with all components negative

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( -1 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(dot_product) = cut->get_dot_product_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      act = dot_product
      exp = -3 ).
  ENDMETHOD.


  METHOD get_dot_product_by_vector3.
    "Vector with all components positive

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


  METHOD get_dot_product_by_vector4.
    "Both vectors are orthogonal, which should result in a zero dot product

    "Given
    DATA(vector) = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 ).
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 ).

    "When
    DATA(dot_product) = cut->get_dot_product_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      act = dot_product
      exp = 0 ).
  ENDMETHOD.


  METHOD get_product_by_decfloat1.
    "Multiplying a vector with zero

    "Given
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 1  i_z = 1 ).

    "When
    DATA(result) = cut->get_product_by_decfloat( 0 ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 0 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD get_product_by_decfloat2.
    "Multiplying a vector with a positive number

    "Given
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 1  i_z = 1 ).

    "When
    DATA(result) = cut->get_product_by_decfloat( 2 ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 2 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD get_product_by_decfloat3.
    "Multiplying a vector with a negative number

    "Given
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 1  i_z = 1 ).

    "When
    DATA(result) = cut->get_product_by_decfloat( -1 ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = -1 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD get_product_by_matrix1.
    "Multiply a vector with an identity matrix

    "Given
    DATA(matrix) = NEW zcl_art_matrix( ).
    DATA(vector) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).

    "When
    DATA(result) = zcl_art_vector3d=>get_product_by_matrix(
      i_matrix = matrix
      i_vector = vector ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> vector ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 3 ).

    cl_abap_unit_assert=>assert_equals( act = vector->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = vector->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = vector->z  exp = 3 ).
  ENDMETHOD.


  METHOD get_product_by_matrix2.
    "Multiply a vector with a matrix which changes the result from the vector

    "Given
    DATA(matrix) = NEW zcl_art_matrix( ).
    matrix->matrix[ 1 ][ 1 ] = 2.
    matrix->matrix = VALUE zcl_art_matrix=>rows( FOR i = 1 UNTIL i > 3 (
                       VALUE zcl_art_matrix=>columns( FOR j = 1 UNTIL j > 3
                         ( COND #( WHEN i = j THEN 2 ELSE 0 ) ) ) ) ).
    DATA(vector) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).

    "When
    DATA(result) = zcl_art_vector3d=>get_product_by_matrix(
      i_matrix = matrix
      i_vector = vector ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> vector ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 6 ).

    cl_abap_unit_assert=>assert_equals( act = vector->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = vector->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = vector->z  exp = 3 ).
  ENDMETHOD.


  METHOD get_quotient_by_decfloat1.
    "Dividing a vector by zero

    "Given
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 1  i_z = 1 ).

    "When and Then
    TRY.
        DATA(result) = cut->get_quotient_by_decfloat( 0 ).
        cl_abap_unit_assert=>fail( ).
      CATCH cx_sy_zerodivide ##NO_HANDLER.
    ENDTRY.
  ENDMETHOD.


  METHOD get_quotient_by_decfloat2.
    "Dividing a vector by a positive number

    "Given
    DATA(cut) = zcl_art_vector3d=>new_individual( i_x = 2  i_y = 2  i_z = 2 ).

    "When
    DATA(result) = cut->get_quotient_by_decfloat( 2 ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 1 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 2 ).
  ENDMETHOD.


  METHOD get_quotient_by_decfloat3.
    "Dividing a vector by a negative number

    "Given
    DATA(cut) = zcl_art_vector3d=>new_unified( 2 ).

    "When
    DATA(result) = cut->get_quotient_by_decfloat( -2 ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = -1 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = -1 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 2 ).
  ENDMETHOD.


  METHOD get_sum_by_vector1.
    "Adding a vector to a vector

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( 1 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(result) = cut->get_sum_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 2 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
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
    cl_abap_unit_assert=>assert_true( xsdbool( vector <> cut ) ).
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


  METHOD hat.
    "Normalize and return a vector

    "Given
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    data(result) = cut->hat( ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result = cut ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = '0.5773502691896259' ).
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


  METHOD assignment_by_vector1.
    "Assign the same vector to itself.

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(cut) = vector->assignment_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut  exp = vector ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD assignment_by_vector2.
    "Assign a different vector

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( 2 ).
    DATA(cut) = zcl_art_vector3d=>new_unified( 1 ).

    "When
    DATA(result) = cut->assignment_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( vector <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = cut  exp = result ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 2 ).
  ENDMETHOD.
ENDCLASS.
