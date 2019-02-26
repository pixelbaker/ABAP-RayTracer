CLASS cl_unittest DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_matrix.


    METHODS:
      setup,

      constructor1 FOR TESTING,
      constructor2 FOR TESTING,

      assignment1 FOR TESTING,

      get_product_by_matrix1 FOR TESTING,

      get_quotient_by_decfloat1 FOR TESTING,

      set_identity1 FOR TESTING,

      get_matrix_with_uniform_value
        IMPORTING
          i_value         TYPE decfloat16
        RETURNING
          VALUE(r_matrix) TYPE REF TO zcl_art_matrix,

      assert_uniform_value
        IMPORTING
          i_matrix TYPE REF TO zcl_art_matrix
          i_value  TYPE decfloat16,

      assert_identity_matrix
        IMPORTING
          i_matrix TYPE REF TO zcl_art_matrix.

ENDCLASS.


CLASS cl_unittest IMPLEMENTATION.
  METHOD setup.
    _cut = NEW #( ).
  ENDMETHOD.


  METHOD constructor1.
    "Check that the default constructor works as expected and inits an identity matrix

    "When
    _cut = NEW #( ).

    "Then
    assert_identity_matrix( _cut ).
  ENDMETHOD.


  METHOD assert_identity_matrix.
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 1 ][ 1 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 1 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 1 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 1 ][ 4 ]  exp = 0 ).

    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 2 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 2 ][ 2 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 2 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 2 ][ 4 ]  exp = 0 ).

    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 3 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 3 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 3 ][ 3 ]  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 3 ][ 4 ]  exp = 0 ).

    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 4 ][ 1 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 4 ][ 2 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 4 ][ 3 ]  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = i_matrix->matrix[ 4 ][ 4 ]  exp = 1 ).
  ENDMETHOD.


  METHOD constructor2.
    "Check that the copy constructor works as expected and copies the values over

    "Given
    DATA(mat) = get_matrix_with_uniform_value( '2' ).

    "When
    _cut = NEW #( i_matrix = mat ).

    "Then
    assert_uniform_value( i_matrix = _cut  i_value = '2' ).
  ENDMETHOD.


  METHOD assert_uniform_value.
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 1 ][ 1 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 1 ][ 2 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 1 ][ 3 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 1 ][ 4 ]  exp = i_value ).

    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 2 ][ 1 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 2 ][ 2 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 2 ][ 3 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 2 ][ 4 ]  exp = i_value ).

    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 3 ][ 1 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 3 ][ 2 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 3 ][ 3 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 3 ][ 4 ]  exp = i_value ).

    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 4 ][ 1 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 4 ][ 2 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 4 ][ 3 ]  exp = i_value ).
    cl_abap_unit_assert=>assert_equals( act = _cut->matrix[ 4 ][ 4 ]  exp = i_value ).
  ENDMETHOD.


  METHOD get_matrix_with_uniform_value.
    r_matrix  = NEW zcl_art_matrix( ).
    r_matrix->matrix = VALUE zcl_art_matrix=>rows( FOR i = 1 UNTIL i > 4 (
                         VALUE zcl_art_matrix=>columns( FOR j = 1 UNTIL j > 4 ( i_value ) ) ) ).
  ENDMETHOD.


  METHOD assignment1.
    "Check that assignment (operator=) works

    "Given
    DATA(matrix) = get_matrix_with_uniform_value( '3' ).

    "When
    DATA(result) = _cut->assignment( matrix ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = _cut  act = result ).
    assert_uniform_value( i_matrix = _cut  i_value = '3' ).
  ENDMETHOD.


  METHOD get_product_by_matrix1.
    "Check that multiplying (operator*) works

    "When
    DATA(matrix) = get_matrix_with_uniform_value( '2' ).
    _cut->matrix = VALUE zcl_art_matrix=>rows( FOR i = 0 UNTIL i = 4 (
                     VALUE zcl_art_matrix=>columns( FOR j = 1 UNTIL j > 4 ( CONV #( i * 4 + j ) ) ) ) ).

    "Then
    DATA(result) = _cut->get_product_by_matrix( matrix ).

    "Given
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 1 ]  exp = 20 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 2 ]  exp = 20 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 3 ]  exp = 20 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 1 ][ 4 ]  exp = 20 ).

    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 1 ]  exp = 52 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 2 ]  exp = 52 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 3 ]  exp = 52 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 2 ][ 4 ]  exp = 52 ).

    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 1 ]  exp = 84 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 2 ]  exp = 84 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 3 ]  exp = 84 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 3 ][ 4 ]  exp = 84 ).

    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 1 ]  exp = 116 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 2 ]  exp = 116 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 3 ]  exp = 116 ).
    cl_abap_unit_assert=>assert_equals( act = result->matrix[ 4 ][ 4 ]  exp = 116 ).
  ENDMETHOD.


  METHOD set_identity1.
    "Check that a matrix can be reset to an identity matrix

    "Given
    _cut = get_matrix_with_uniform_value( '2' ).

    "When
    _cut->set_identity( ).

    "Then
    assert_identity_matrix( _cut ).
  ENDMETHOD.


  METHOD get_quotient_by_decfloat1.
    "Check that dividing (operator/) works

    "Given
    _cut = get_matrix_with_uniform_value( '4' ).

    "When
    DATA(result) = _cut->get_quotient_by_decfloat( '2' ).

    "Then
    IF _cut = result. cl_abap_unit_assert=>fail( ). ENDIF.
    assert_uniform_value( i_matrix = result  i_value = '2' ).
    assert_uniform_value( i_matrix = _cut  i_value = '2' ).
  ENDMETHOD.

ENDCLASS.
