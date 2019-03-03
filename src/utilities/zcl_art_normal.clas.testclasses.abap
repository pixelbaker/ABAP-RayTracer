CLASS ucl_art_normal DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_copy FOR TESTING,
      new_unified FOR TESTING,
      new_default FOR TESTING,
      new_individual FOR TESTING,
      new_from_vector FOR TESTING,

      assignment_by_normal1 FOR TESTING,
      assignment_by_normal2 FOR TESTING,
      assignment_by_vector FOR TESTING,

      normalize1 FOR TESTING,
      normalize2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_normal IMPLEMENTATION.
  METHOD new_copy.
    "Copy constructor generates a new instance of a normal based on another normal

    "Given
    DATA(normal) = zcl_art_normal=>new_individual(
      i_x = 5
      i_y = 6
      i_z = 7 ).

    "When
    DATA(cut) = zcl_art_normal=>new_copy( normal ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN normal <> cut THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 5 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 6 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 7 ).
  ENDMETHOD.


  METHOD new_individual.
    "Individual constructor generates normal according to components

    "When
    DATA(cut) = zcl_art_normal=>new_individual(
      i_x = 2
      i_y = 3
      i_z = 4 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 3 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 4 ).
  ENDMETHOD.


  METHOD new_from_vector.
    "Constructs a new instance of a normal based on a vector

    "Given
    DATA(vector) = zcl_art_vector3d=>new_individual(
      i_x = 8
      i_y = 9
      i_z = 10 ).

    "When
    DATA(cut) = zcl_art_normal=>new_from_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 8 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 9 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 10 ).
  ENDMETHOD.


  METHOD new_default.
    "Default constructor generates normal with all components zero

    "When
    DATA(cut) = zcl_art_normal=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 0 ).
  ENDMETHOD.


  METHOD new_unified.
    "Unified constructor generates normal with all components one

    "When
    DATA(cut) = zcl_art_normal=>new_unified( 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD assignment_by_normal1.
    "Assign the same normal to itself.

    "Given
    DATA(normal) = zcl_art_normal=>new_unified( 1 ).

    "When
    DATA(cut) = normal->assignment_by_normal( normal ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut  exp = normal ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 1 ).
  ENDMETHOD.


  METHOD assignment_by_normal2.
    "Assign a different normal

    "Given
    DATA(normal) = zcl_art_normal=>new_unified( 2 ).
    DATA(cut) = zcl_art_normal=>new_unified( 1 ).

    "When
    DATA(result) = cut->assignment_by_normal( normal ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN normal <> cut THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut  exp = result ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 2 ).
  ENDMETHOD.


  METHOD assignment_by_vector.
    "Assign a different vector

    "Given
    DATA(vector) = zcl_art_vector3d=>new_unified( 2 ).
    DATA(cut) = zcl_art_normal=>new_unified( 1 ).

    "When
    DATA(result) = cut->assignment_by_vector( vector ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut  exp = result ).
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 2 ).
  ENDMETHOD.


  METHOD normalize1.
    "Normalize a zero normal

    "Given
    DATA(cut) = zcl_art_normal=>new_unified( 0 ).

    "When
    cut->normalize( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = 0 ).
  ENDMETHOD.


  METHOD normalize2.
    "Normalize a normal normal ;)

    "Given
    DATA(cut) = zcl_art_normal=>new_unified( 1 ).

    "When
    cut->normalize( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->x  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->y  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->z  exp = '0.5773502691896259' ).
  ENDMETHOD.

ENDCLASS.
