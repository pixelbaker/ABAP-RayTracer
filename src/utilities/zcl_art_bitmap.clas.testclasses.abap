CLASS ucl_art_bitmap DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_bitmap.

    METHODS:
      setup,

      "! Check, that an exception gets raised, when not all pixels have been added
      build1 FOR TESTING,
      "! Check, that an image can be correctly added
      build2 FOR TESTING,
      "! Check, that the binary representation is as expected
      build3 FOR TESTING.

ENDCLASS.


CLASS ucl_art_bitmap IMPLEMENTATION.
  METHOD setup.
  ENDMETHOD.


  METHOD build1.
    "Given
    _cut = NEW #(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ).

    "When
    TRY.
        DATA(result) = _cut->build( ).
        cl_abap_unit_assert=>fail( ).

      CATCH zcx_art_bitmap INTO DATA(exception).
        "Then
        MESSAGE e000(zart) INTO DATA(error_msg).
        cl_abap_unit_assert=>assert_equals(
          exp = error_msg
          act = exception->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD build2.
    "Given
    _cut = NEW #(
      i_image_height_in_pixel = 1
      i_image_width_in_pixel = 1 ).
    _cut->add_pixel( VALUE #( x = 0  y = 0  r = 255  g = 0  b = 0 ) ).

    "When
    TRY.
        DATA(result) = _cut->build( ).
      CATCH zcx_art_bitmap INTO DATA(exception).
        cl_abap_unit_assert=>fail( ).
    ENDTRY.

    "Then
    cl_abap_unit_assert=>assert_not_initial( result ).
  ENDMETHOD.


  METHOD build3.
    "Given
    _cut = NEW #(
      i_image_height_in_pixel = 2
      i_image_width_in_pixel = 2 ).
    _cut->add_pixel( VALUE #( x = 0  y = 1  r = 255  g = 0    b = 0 ) ).
    _cut->add_pixel( VALUE #( x = 1  y = 1  r = 255  g = 255  b = 255 ) ).
    _cut->add_pixel( VALUE #( x = 0  y = 0  r = 255  g = 0    b = 255 ) ).
    _cut->add_pixel( VALUE #( x = 1  y = 0  r = 255  g = 255  b = 0 ) ).

    "When
    TRY.
        DATA(result) = _cut->build( ).
      CATCH zcx_art_bitmap INTO DATA(exception).
        cl_abap_unit_assert=>fail( ).
    ENDTRY.

    "Then
    cl_abap_unit_assert=>assert_equals(
      exp = '424D460000000000000036000000280000000200000002000000010018000000000010000000130B0000130B000000000000000000000000FFFFFFFF0000FF00FF00FFFF0000'
      act = result ).
  ENDMETHOD.
ENDCLASS.
