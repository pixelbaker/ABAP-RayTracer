"! This class generates an image with the bitmap file format specs.
"! The specs can be found here: https://en.wikipedia.org/wiki/BMP_file_format
CLASS zcl_art_bitmap DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES:
      BEGIN OF pixel,
        x TYPE int4, "X Position
        y TYPE int4, "Y Position
        r TYPE int4, "Red
        g TYPE int4, "Green
        b TYPE int4, "Blue
      END OF pixel .

    DATA:
      image_height_in_pixel TYPE int4 READ-ONLY,
      image_width_in_pixel  TYPE int4 READ-ONLY.

    METHODS:
      "! Creates an instance of a bitmap class representation
      "!
      "! @parameter i_image_height_in_pixel | Height of the bitmap in pixels. Must be greater zero.
      "!   Positive for bottom to top pixel order.
      "! @parameter i_image_width_in_pixel | Width of the bitmap in pixels. Must be greater zero.
      constructor
        IMPORTING
          i_image_height_in_pixel TYPE int4
          i_image_width_in_pixel  TYPE int4,

      add_pixel
        IMPORTING
          i_pixel TYPE pixel,

      "! Generates and assembles the header and pixel information into a valid bitmap format.
      "!
      "! @parameter r_bitmap | A binary representation of a bitmap.
      "!
      "! @raising zcx_art_bitmap | Gets raised, if not all pixels have been added before calling this method.
      build
        RETURNING
          VALUE(r_bitmap) TYPE xstring
        RAISING
          zcx_art_bitmap.


  PRIVATE SECTION.
    CONSTANTS:
      _co_bi_rgb_compression      TYPE x LENGTH 4 VALUE '00000000',
      _co_empty_byte              TYPE x LENGTH 1 VALUE '00',
      _co_header_size_in_byte     TYPE int4 VALUE 54,
      _co_magic_number_in_ascii   TYPE c LENGTH 2 VALUE 'BM',
      _co_application_specific    TYPE x LENGTH 2 VALUE '0000',
      _co_dib_header_size_in_byte TYPE int4 VALUE 40,
      _co_num_color_palettes      TYPE int4 VALUE 1,
      _co_important_colors        TYPE x LENGTH 4 VALUE '00000000',
      _co_num_colors_in_palettes  TYPE x LENGTH 4 VALUE '00000000',
      _co_print_resolution        TYPE int4 VALUE 2835.


    DATA:
      _bits_per_pixel  TYPE int4 VALUE 24,
      _header          TYPE xstring,
      _data            TYPE xstring,
      _remaining_bytes TYPE xstring,
      _converter       TYPE REF TO cl_abap_conv_out_ce.


    METHODS:
      build_header,

      get_row_size
        RETURNING
          VALUE(r_row_size_in_byte) TYPE int4,

      "! Gives you the byte size of all the pixels, but without the header information
      get_pixel_array_size
        RETURNING
          VALUE(r_array_size_in_byte) TYPE int4,

      get_bmp_file_size
        RETURNING
          VALUE(r_bmp_file_size_in_byte) TYPE int4,

      precalc_empty_remaining_bytes,

      validate_all_pixels_added
        RAISING
          zcx_art_bitmap.

ENDCLASS.



CLASS ZCL_ART_BITMAP IMPLEMENTATION.


  METHOD add_pixel.
    DATA:
      r TYPE x LENGTH 1,
      g TYPE x LENGTH 1,
      b TYPE x LENGTH 1.

    _converter->convert( EXPORTING data = i_pixel-r IMPORTING buffer = r ).
    _converter->convert( EXPORTING data = i_pixel-g IMPORTING buffer = g ).
    _converter->convert( EXPORTING data = i_pixel-b IMPORTING buffer = b ).

    CONCATENATE _data b g r INTO _data IN BYTE MODE.

    IF _remaining_bytes IS NOT INITIAL AND
       i_pixel-x + 1 = me->image_width_in_pixel.
      CONCATENATE _data _remaining_bytes INTO _data IN BYTE MODE.
    ENDIF.
  ENDMETHOD.


  METHOD build.
    validate_all_pixels_added( ).
    CLEAR _header.
    build_header( ).
    CONCATENATE _header _data INTO r_bitmap IN BYTE MODE.
  ENDMETHOD.


  METHOD build_header.
    DATA magic_number TYPE x LENGTH 2.
    _converter->convert( EXPORTING data = _co_magic_number_in_ascii IMPORTING buffer = magic_number ).

    DATA file_size TYPE x LENGTH 4.
    DATA(bmp_file_size_in_byte) = get_bmp_file_size( ).
    _converter->convert( EXPORTING data = bmp_file_size_in_byte IMPORTING buffer = file_size ).

    DATA offset TYPE x LENGTH 4.
    _converter->convert( EXPORTING data = _co_header_size_in_byte IMPORTING buffer = offset ).

    DATA dib_header_size TYPE x LENGTH 4.
    _converter->convert( EXPORTING data = _co_dib_header_size_in_byte IMPORTING buffer = dib_header_size ).

    DATA image_width TYPE x LENGTH 4.
    _converter->convert( EXPORTING data = me->image_width_in_pixel IMPORTING buffer = image_width ).

    DATA image_height TYPE x LENGTH 4.
    _converter->convert( EXPORTING data = me->image_height_in_pixel IMPORTING buffer = image_height ).

    DATA num_color_palates TYPE x LENGTH 2.
    _converter->convert( EXPORTING data = _co_num_color_palettes IMPORTING buffer = num_color_palates ).

    DATA bits_per_pixel TYPE x LENGTH 2.
    _converter->convert( EXPORTING data = _bits_per_pixel IMPORTING buffer = bits_per_pixel ).

    DATA raw_bitmap_size TYPE x LENGTH 4.
    DATA raw_bitmap_size_in_int TYPE int4.
    raw_bitmap_size_in_int = bmp_file_size_in_byte - _co_header_size_in_byte.
    _converter->convert( EXPORTING data = raw_bitmap_size_in_int IMPORTING buffer = raw_bitmap_size ).

    DATA print_resolution TYPE x LENGTH 4.
    _converter->convert( EXPORTING data = _co_print_resolution IMPORTING buffer = print_resolution ).

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
                _co_bi_rgb_compression
                raw_bitmap_size
                print_resolution
                print_resolution
                _co_num_colors_in_palettes
                _co_important_colors
                INTO _header IN BYTE MODE.
  ENDMETHOD.


  METHOD constructor.
    ASSERT i_image_height_in_pixel > 0 AND
           i_image_width_in_pixel > 0.

    me->image_height_in_pixel = i_image_height_in_pixel.
    me->image_width_in_pixel = i_image_width_in_pixel.

    precalc_empty_remaining_bytes( ).

    _converter = cl_abap_conv_out_ce=>create( endian = cl_abap_char_utilities=>endian ).
  ENDMETHOD.


  METHOD get_bmp_file_size.
    r_bmp_file_size_in_byte = _co_header_size_in_byte + get_pixel_array_size( ).
  ENDMETHOD.


  METHOD get_pixel_array_size.
    DATA(row_size) = get_row_size( ).
    r_array_size_in_byte = row_size * abs( me->image_height_in_pixel ).
  ENDMETHOD.


  METHOD get_row_size.
    DATA temp TYPE decfloat16.
    temp = ( _bits_per_pixel * me->image_width_in_pixel + 31 ) / 32.
    r_row_size_in_byte = floor( temp ) * 4.
  ENDMETHOD.


  METHOD precalc_empty_remaining_bytes.
    DATA(num_bytes) = me->image_width_in_pixel * 3.
    DATA(remainder) = num_bytes MOD 4.
    IF remainder > 0.
      DATA(num_remaining_bytes) = 4 - ( num_bytes MOD 4 ).
      DO num_remaining_bytes TIMES.
        CONCATENATE _remaining_bytes _co_empty_byte INTO _remaining_bytes IN BYTE MODE.
      ENDDO.
    ENDIF.
  ENDMETHOD.


  METHOD validate_all_pixels_added.
    IF get_pixel_array_size( ) > xstrlen( _data ).
      RAISE EXCEPTION TYPE zcx_art_bitmap
        EXPORTING
          i_textid = zcx_art_bitmap=>more_pixels_than_added.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
