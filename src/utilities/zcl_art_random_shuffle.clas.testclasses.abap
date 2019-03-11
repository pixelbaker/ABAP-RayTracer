CLASS ucl_art_random_shuffle DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    TYPES:
      _ty_itab TYPE STANDARD TABLE OF int4 WITH EMPTY KEY.


    DATA:
      _cut TYPE REF TO zcl_art_random_shuffle.


    METHODS:
      setup,

      "! Check, that an empty array can be shuffled without anything happens
      random_shuffle1 FOR TESTING,
      "! Check, that a table gets shuffled
      random_shuffle2 FOR TESTING,

      "! Test, a simple swap works.
      swap1 FOR TESTING,
      "! Test, that swapping the same index results in the same order.
      swap2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_random_shuffle IMPLEMENTATION.
  METHOD setup.
    _cut = NEW #( ).
  ENDMETHOD.


  METHOD random_shuffle1.
    "Given
    DATA(itab) = VALUE _ty_itab(  ).

    "When
    _cut->random_shuffle( CHANGING c_itab = itab ).

    "Then
    cl_abap_unit_assert=>assert_initial( itab ).
  ENDMETHOD.


  METHOD random_shuffle2.
    "Given
    DATA(itab) = VALUE _ty_itab( ( 1 ) ( 2 ) ( 3 ) ( 4 ) ( 5 ) ( 6 ) ( 7 ) ( 8 ) ( 9 ) ).
    DATA(not_exp_itab) = itab.

    "When
    _cut->random_shuffle( CHANGING c_itab = itab ).

    "Then
    cl_abap_unit_assert=>assert_true( COND #( WHEN itab <> not_exp_itab THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = lines( not_exp_itab )
      act = lines( itab ) ).

    LOOP AT not_exp_itab INTO DATA(row).
      cl_abap_unit_assert=>assert_table_contains(
        line = row
        table = itab ).
    ENDLOOP.
  ENDMETHOD.


  METHOD swap1.
    "Given
    DATA(itab) = VALUE _ty_itab( ( 1 ) ( 2 ) ( 3 ) ).

    "When
    _cut->swap(
      EXPORTING
        i_index1 = 1
        i_index2 = 3
      CHANGING
        c_itab = itab ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = VALUE _ty_itab( ( 3 ) ( 2 ) ( 1 ) )
      act = itab ).
  ENDMETHOD.


  METHOD swap2.
    "Given
    DATA(itab) = VALUE _ty_itab( ( 1 ) ( 2 ) ( 3 ) ).

    "When
    _cut->swap(
      EXPORTING
        i_index1 = 2
        i_index2 = 2
      CHANGING
        c_itab = itab ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = VALUE _ty_itab( ( 1 ) ( 2 ) ( 3 ) )
      act = itab ).
  ENDMETHOD.

ENDCLASS.
