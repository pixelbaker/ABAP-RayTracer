CLASS ucl_art_time_formater DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_time_formater.


    METHODS:
      setup,

      make_human_readable_time_code1 FOR TESTING,
      make_human_readable_time_code2 FOR TESTING,
      make_human_readable_time_code3 FOR TESTING,
      make_human_readable_time_code4 FOR TESTING,
      make_human_readable_time_code5 FOR TESTING,
      make_human_readable_time_code6 FOR TESTING,
      make_human_readable_time_code7 FOR TESTING.

ENDCLASS.


CLASS ucl_art_time_formater IMPLEMENTATION.
  METHOD setup.
    _cut = NEW zcl_art_time_formater( ).
  ENDMETHOD.


  METHOD make_human_readable_time_code1.
    "Format zero seconds

    "When
    DATA(result) = _cut->make_human_readable_time_code( 0 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '0:00:00'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_time_code2.
    "Format a few seconds (single digit) but less than a minute

    "When
    DATA(result) = _cut->make_human_readable_time_code( 9 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '0:00:09'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_time_code3.
    "Format a double digit seconds but less than a minute

    "When
    DATA(result) = _cut->make_human_readable_time_code( 59 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '0:00:59'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_time_code4.
    "Format one minute

    "When
    DATA(result) = _cut->make_human_readable_time_code( 60 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '0:01:00'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_time_code5.
    "Format 59 minutes and 59 seconds

    "When
    DATA(result) = _cut->make_human_readable_time_code( 3599 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '0:59:59'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_time_code6.
    "Format one hour

    "When
    DATA(result) = _cut->make_human_readable_time_code( 3600 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '1:00:00'
      act = result ).
  ENDMETHOD.


  METHOD make_human_readable_time_code7.
    "Format multiple hours minutes and seconds

    "When
    DATA(result) = _cut->make_human_readable_time_code( 204451 ).

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '56:47:31'
      act = result ).
  ENDMETHOD.
ENDCLASS.
