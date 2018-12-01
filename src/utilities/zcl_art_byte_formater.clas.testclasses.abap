CLASS ucl_art_byte_formater DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_byte_formater.


    METHODS:
      setup,

      make_human_readable_byte_cnt1 FOR TESTING,
      make_human_readable_byte_cnt2 FOR TESTING,
      make_human_readable_byte_cnt3 FOR TESTING.

ENDCLASS.


CLASS ucl_art_byte_formater IMPLEMENTATION.
  METHOD setup.
    _cut = NEW #( ).
  ENDMETHOD.


  METHOD make_human_readable_byte_cnt1.
    "Check string when byte count is 0.

    "When
    DATA(result) = _cut->make_human_readable_byte_count( 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '0 B'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_byte_cnt2.
    "Check string when byte count larger than 0 but smaller than 1 kilobyte.

    "When
    DATA(result) = _cut->make_human_readable_byte_count( 1023 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '1023 B'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_byte_cnt3.
    "Check string when byte count is really big.

    "When
    DATA(result) = _cut->make_human_readable_byte_count( 7582042 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '7.2 MiB'
      act = result ).
  ENDMETHOD.
ENDCLASS.
