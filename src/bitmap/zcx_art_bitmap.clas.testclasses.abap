CLASS ucx_art_bitmap DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcx_art_bitmap.


    METHODS:
      setup,

      "! Check, that the textid passing works and a meaningful error message comes out
      get_text1 FOR TESTING.

ENDCLASS.


CLASS ucx_art_bitmap IMPLEMENTATION.
  METHOD setup.
    _cut = NEW #( ).
  ENDMETHOD.


  METHOD get_text1.
    "When
    _cut = NEW #( i_textid = zcx_art_bitmap=>more_pixels_than_added ).

    "Then
    MESSAGE e000(zart_bitmap) INTO DATA(error_msg).
    cl_abap_unit_assert=>assert_equals(
      exp = error_msg
      act = _cut->get_text( ) ).
  ENDMETHOD.
ENDCLASS.
