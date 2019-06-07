CLASS ucl_art_point3d DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_copy FOR TESTING,
      new_default FOR TESTING,
      new_individual FOR TESTING RAISING cx_static_check,
      new_unified FOR TESTING RAISING cx_static_check,
      get_sum_by_vector1 FOR TESTING RAISING cx_static_check,
      get_difference_by_vector1 FOR TESTING RAISING cx_static_check,
      get_difference_by_point1 FOR TESTING RAISING cx_static_check,
      assignment1 FOR TESTING RAISING cx_static_check,
      assignment2 FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ucl_art_point3d IMPLEMENTATION.
  METHOD new_copy.
    "Copy constructor generates a new instance of a normal 3D point based on another 3D point

    "Given
    DATA(point) = zcl_art_point3d=>new_individual(
      i_x = 5
      i_y = 6
      i_z = 7 ).

    "When
    DATA(cut) = zcl_art_point3d=>new_copy( point ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( point <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 6 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 7 ).
  ENDMETHOD.


  METHOD new_default.
    "Default constructor generates a 3D point with all components zero

    "When
    DATA(cut) = zcl_art_point3d=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 0 ).
  ENDMETHOD.


  METHOD new_individual.
    "Individual constructor generates a 3D point according to components

    "When
    DATA(cut) = zcl_art_point3d=>new_individual(
      i_x = 2
      i_y = 3
      i_z = 4 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 4 ).
  ENDMETHOD.


  METHOD new_unified.
    "Unified constructor generates a 3D point with all components one

    "When
    DATA(cut) = zcl_art_point3d=>new_unified( 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD get_sum_by_vector1.
    "Adding a vector to a 3D point

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( 1 ).
    DATA(cut) = zcl_art_point3d=>new_unified( 1 ).

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


  METHOD get_difference_by_vector1.
    "Get the difference between a vector and a 3D point expressed by a new instance of a 3d point

    "Given
    DATA(vector) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).
    DATA(cut) = zcl_art_point3d=>new_individual( i_x = 4  i_y = 5  i_z = 6 ).

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


  METHOD get_difference_by_point1.
    "Get the difference between two 3D points expressed by a new instance of a vector

    "Given
    DATA(point) = zcl_art_point3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).
    DATA(cut) = zcl_art_point3d=>new_individual( i_x = 4  i_y = 5  i_z = 6 ).

    "When
    DATA(result) = cut->get_difference_by_point( point ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = result->x  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = result->y  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = result->z  exp = 3 ).

    cl_abap_unit_assert=>assert_equals( act = point->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = point->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = point->z  exp = 3 ).

    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 4 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 6 ).
  ENDMETHOD.


  METHOD assignment1.
    "Assign the same 3D point to itself.

    "Given
    DATA(point) = zcl_art_point3d=>new_unified( 1 ).

    "When
    DATA(cut) = point->assignment( point ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut  exp = point ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD assignment2.
    "Assign a different 3D point

    "Given
    DATA(point) = zcl_art_point3d=>new_unified( 2 ).
    DATA(cut) = zcl_art_point3d=>new_unified( 1 ).

    "When
    DATA(result) = cut->assignment( point ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( point <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = cut  exp = result ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 2 ).
  ENDMETHOD.
ENDCLASS.
