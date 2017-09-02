CLASS zcl_art_bitmap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF pixel,
        x TYPE int4,
        y TYPE int4,
        r TYPE int4,
        g TYPE int4,
        b TYPE int4,
      END OF pixel.


    METHODS:
      constructor
        IMPORTING
          i_image_height_in_pixel TYPE int4 "Height of the bitmap in pixels. Positive for bottom to top pixel order.
          i_image_width_in_pixel  TYPE int4,

      add_pixel
        IMPORTING
          i_pixel TYPE pixel,

      build
        RETURNING
          VALUE(r_bitmap) TYPE xstring.


  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS:
      _co_bi_rgb_comporession     TYPE x LENGTH 4 VALUE '00000000',
      _co_empty_byte              TYPE x LENGTH 1 VALUE '00',
      _co_header_size_in_byte     TYPE int4 VALUE 54,
      _co_magic_number            TYPE x LENGTH 2 VALUE '424D',
      _co_magic_number_in_ascii   TYPE c LENGTH 2 VALUE 'BM',
      _co_application_specific    TYPE x LENGTH 2 VALUE '0000',
      _co_dib_header_size_in_byte TYPE int4 VALUE 40,
      _co_num_color_palettes      TYPE int4 VALUE 1,
      _co_important_colors        TYPE x LENGTH 4 VALUE '00000000',
      _co_num_colors_in_palettes  TYPE x LENGTH 4 VALUE '00000000',
      _co_print_resolution        TYPE int4 VALUE 2835.


    DATA:
      _bits_per_pixel        TYPE int4 VALUE 24,
      _header                TYPE xstring,
      _data                  TYPE xstring,
      _image_height_in_pixel TYPE int4,
      _image_width_in_pixel  TYPE int4,

      _pixels                TYPE SORTED TABLE OF pixel WITH UNIQUE KEY x y,
      _num_remaining_bytes   TYPE int4,
      _remaining_bytes       TYPE xstring,
      _conv                  TYPE REF TO cl_abap_conv_out_ce.


    METHODS:
      build_header,

      build_pixel_array,

      get_row_size
        RETURNING
          VALUE(r_row_size_in_byte) TYPE int4,

      get_array_size
        RETURNING
          VALUE(r_array_size_in_byte) TYPE int4,

      get_bmp_file_size
        RETURNING
          VALUE(r_bmp_file_size_in_byte) TYPE int4.

ENDCLASS.



CLASS zcl_art_bitmap IMPLEMENTATION.


  METHOD add_pixel.
*    INSERT i_pixel INTO TABLE _pixels.
    DATA r TYPE x LENGTH 1.
    DATA g TYPE x LENGTH 1.
    DATA b TYPE x LENGTH 1.
    _conv->convert( EXPORTING data = i_pixel-r IMPORTING buffer = r ).
    _conv->convert( EXPORTING data = i_pixel-g IMPORTING buffer = g ).
    _conv->convert( EXPORTING data = i_pixel-b IMPORTING buffer = b ).
*    r = i_pixel-r.
*    g = i_pixel-g.
*    b = i_pixel-b.

    CONCATENATE _data b g r INTO _data IN BYTE MODE.

    IF i_pixel-x + 1 = _image_width_in_pixel.
      CONCATENATE _data _remaining_bytes INTO _data IN BYTE MODE.
    ENDIF.
  ENDMETHOD.


  METHOD build.
    CLEAR _header.
    build_header( ).
*    build_pixel_array( ).

    CONCATENATE _header _data INTO r_bitmap IN BYTE MODE.
*    r_bitmap = _header && _data.
  ENDMETHOD.


  METHOD build_header.
    "cl_abap_char_utilities=>ENDIAN

    DATA magic_number TYPE x LENGTH 2.
    _conv->convert( EXPORTING data = _co_magic_number_in_ascii IMPORTING buffer = magic_number ).
*    magic_number = _co_magic_number_in_ascii.
*    magic_number = _co_magic_number.

    DATA file_size TYPE x LENGTH 4.
    DATA(bmp_file_size_in_byte) = get_bmp_file_size( ).
    _conv->convert( EXPORTING data = bmp_file_size_in_byte IMPORTING buffer = file_size ).
*    file_size = bmp_file_size_in_byte.

    DATA offset TYPE x LENGTH 4.
    _conv->convert( EXPORTING data = _co_header_size_in_byte IMPORTING buffer = offset ).
*    offset = _co_header_size_in_byte.

    DATA dib_header_size TYPE x LENGTH 4.
    _conv->convert( EXPORTING data = _co_dib_header_size_in_byte IMPORTING buffer = dib_header_size ).
*    dib_header_size = _co_dib_header_size_in_byte.

    DATA image_width TYPE x LENGTH 4.
    _conv->convert( EXPORTING data = _image_width_in_pixel IMPORTING buffer = image_width ).
*    image_width = _image_width_in_pixel.

    DATA image_height TYPE x LENGTH 4.
    _conv->convert( EXPORTING data = _image_height_in_pixel IMPORTING buffer = image_height ).
*    image_height = _image_height_in_pixel.

    DATA num_color_palates TYPE x LENGTH 2.
    _conv->convert( EXPORTING data = _co_num_color_palettes IMPORTING buffer = num_color_palates ).
*    num_color_palates = _co_num_color_palettes.

    DATA bits_per_pixel TYPE x LENGTH 2.
    _conv->convert( EXPORTING data = _bits_per_pixel IMPORTING buffer = bits_per_pixel ).
*    bits_per_pixel = _bits_per_pixel.

    DATA raw_bitmap_size TYPE x LENGTH 4.
    _conv->convert( EXPORTING data = ( bmp_file_size_in_byte - _co_header_size_in_byte ) IMPORTING buffer = raw_bitmap_size ).
*    raw_bitmap_size = bmp_file_size_in_byte - _co_header_size_in_byte.

    DATA print_resolution TYPE x LENGTH 4.
    _conv->convert( EXPORTING data = _co_print_resolution IMPORTING buffer = print_resolution ).
*    print_resolution = _co_print_resolution.


    CONCATENATE magic_number
                file_size
                _co_application_specific
                _co_application_specific
                offset
                dib_header_size
                image_width
                image_height
                num_color_palates
                bits_per_pixel
                _co_bi_rgb_comporession
                raw_bitmap_size
                print_resolution
                print_resolution
                _co_num_colors_in_palettes
                _co_important_colors
                INTO _header IN BYTE MODE.
*    _header = magic_number &&
*              file_size &&
*              _co_application_specific &&
*              _co_application_specific &&
*              offset &&
*              dib_header_size &&
*              image_width &&
*              image_height &&
*              num_color_palates &&
*              bits_per_pixel &&
*              _co_bi_rgb_comporession &&
*              raw_bitmap_size &&
*              print_resolution &&
*              print_resolution &&
*              _co_num_colors_in_palettes &&
*              _co_important_colors.
  ENDMETHOD.


  METHOD build_pixel_array.

  ENDMETHOD.


  METHOD constructor.
    _image_height_in_pixel = i_image_height_in_pixel.
    _image_width_in_pixel = i_image_width_in_pixel.


    DATA(num_bytes) = _image_width_in_pixel * 3.
    _num_remaining_bytes = num_bytes MOD 4.
    DO _num_remaining_bytes TIMES.
      CONCATENATE _remaining_bytes _co_empty_byte INTO _remaining_bytes IN BYTE MODE.
    ENDDO.

    _conv = cl_abap_conv_out_ce=>create( endian = cl_abap_char_utilities=>endian ).
  ENDMETHOD.


  METHOD get_array_size.
    DATA(row_size) = get_row_size( ).
    r_array_size_in_byte = row_size * abs( _image_height_in_pixel ).
  ENDMETHOD.


  METHOD get_bmp_file_size.
    r_bmp_file_size_in_byte = _co_header_size_in_byte + get_array_size( ).
  ENDMETHOD.


  METHOD get_row_size.
    r_row_size_in_byte = floor( ( _bits_per_pixel * _image_width_in_pixel + 31 ) / 32 ) * 4.
  ENDMETHOD.
ENDCLASS.
