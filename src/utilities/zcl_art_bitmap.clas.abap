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
          i_height_resolution TYPE int4
          i_width_resoultion  TYPE int4,

      add_pixel
        IMPORTING
          i_pixel TYPE pixel,

      build
        RETURNING
          VALUE(r_bitmap) TYPE xstring.


  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      _bitmap            TYPE xstring,
      _height_resolution TYPE int4,
      _width_resolution  TYPE int4,

      _pixels            TYPE SORTED TABLE OF pixel WITH UNIQUE KEY x y.


    METHODS:
      build_header,

      build_pixel_array.

ENDCLASS.



CLASS zcl_art_bitmap IMPLEMENTATION.


  METHOD add_pixel.
    INSERT i_pixel INTO TABLE _pixels.
  ENDMETHOD.


  METHOD build.
    CLEAR _bitmap.
    build_header( ).
    build_pixel_array( ).
    r_bitmap = _bitmap.
  ENDMETHOD.


  METHOD build_header.
    _bitmap = |424D|.
  ENDMETHOD.


  METHOD build_pixel_array.

  ENDMETHOD.


  METHOD constructor.
    _height_resolution = i_height_resolution.
    _width_resolution = i_width_resoultion.
  ENDMETHOD.
ENDCLASS.
