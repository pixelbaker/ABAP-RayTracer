*&---------------------------------------------------------------------*
*& Report ZHELLO_WORLD
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_display_image_test.
TYPE-POOLS: cndp.
DATA:
  ok_code    TYPE syucomm,
  container1 TYPE REF TO cl_gui_custom_container,
  picture    TYPE REF TO cl_gui_picture,
  url        TYPE cndp_url.

START-OF-SELECTION.
  CALL SCREEN 100.

MODULE status_0100 OUTPUT.
  PERFORM load_image.
ENDMODULE.


FORM load_image.
  DATA l_bytecount TYPE i.
  DATA l_content TYPE sbdst_content.

  CREATE OBJECT:
    container1 EXPORTING container_name = 'PICTURE',
    picture EXPORTING parent = container1.

  CALL FUNCTION 'SAPSCRIPT_GET_GRAPHIC_BDS'
    EXPORTING
      i_name         = 'ENJOY'
    IMPORTING
      e_bytecount    = l_bytecount
    TABLES
      content        = l_content
    EXCEPTIONS
      not_found      = 1
      bds_get_failed = 2
      bds_no_content = 3
      OTHERS         = 4.

  DATA graphic_size TYPE int4.
  DATA: BEGIN OF graphic_table OCCURS 0,
          line(255) TYPE x,
        END OF graphic_table.

  CALL FUNCTION 'SAPSCRIPT_CONVERT_BITMAP'
    EXPORTING
      old_format               = 'BDS'
      new_format               = 'BMP'
      bitmap_file_bytecount_in = l_bytecount
    IMPORTING
      bitmap_file_bytecount    = graphic_size
    TABLES
      bds_bitmap_file          = l_content
      bitmap_file              = graphic_table
    EXCEPTIONS
      OTHERS                   = 1.

  "working with xstring is easier in abap, so convert binary to xstring
  DATA x_bmp TYPE xstring.
  CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
    EXPORTING
      input_length = graphic_size
    IMPORTING
      buffer       = x_bmp
    TABLES
      binary_tab   = graphic_table
    EXCEPTIONS
      failed       = 1
      OTHERS       = 2.
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
* WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.

  DATA:
    w2(2) TYPE x,
    w4(4) TYPE x,
    xstr  TYPE xstring.

  "Macros which help reading 2 or 4 bytes and convert them to integer
  DEFINE read2.
    "#ec needed read two bytes as integer and move offset
    w2 = &1.
    CONCATENATE w2+1(1) w2+0(1) INTO xstr IN BYTE MODE.
    &2 = xstr.
  END-OF-DEFINITION.

  DEFINE read4.
    "#ec needed read four bytes as integer and move offset
    w4 = &1.
    CONCATENATE w4+3(1) w4+2(1) w4+1(1) w4+0(1) INTO xstr IN BYTE MODE.
    &2 = xstr.
  END-OF-DEFINITION.


  "-----bitmap file header

  "BMP and DIB file type
  DATA magic_number(2) TYPE x.
  magic_number = x_bmp+0(2).


  "The size of the BMP file in bytes
  DATA:
    size(4) TYPE x,
    i_size  TYPE i.
  size = x_bmp+2(4).
  read4 size i_size.


  "not read ... Reserved; actual value depends on the application that creates the image


  "The offset, i.e. starting address,
  "of the byte where the bitmap image data (pixel array) can be found.
  DATA:
    data_offset(4) TYPE x,
    i_data_offset  TYPE i.
  data_offset = x_bmp+10(4).
  read4 data_offset i_data_offset.


  "-----DIB header (bitmap information header)

  "the size of this header (40 bytes)
  "this impl. supports only BITMAPINFOHEADER size with a header size of 40
  DATA:
    header_size(4) TYPE x,
    i_header_size  TYPE i.
  header_size = x_bmp+14(4).
  read4 header_size i_header_size.


  IF i_header_size = 40.
    "windows v3 format

    "the bitmap width in pixels (signed integer)
    DATA:
      width(4) TYPE x,
      i_width  TYPE i.
    width = x_bmp+18(4).
    read4 width i_width.

    "the bitmap height in pixels (signed integer)
    DATA:
      height(4) TYPE x,
      i_height  TYPE i.
    height = x_bmp+22(4).
    read4 height i_height.

    "the number of bits per pixel, which is the color depth of the image.
    "Typical values are 1, 4, 8, 16, 24 and 32.
    DATA:
      bpp(2) TYPE x,
      i_bpp  TYPE i.
    bpp = x_bmp+28(2).
    read2 bpp i_bpp.

    "the compression method being used. See the next table for a list of possible values
    DATA:
      compression(4) TYPE x,
      i_compression  TYPE i,
      s_compression  TYPE string.
    compression = x_bmp+30(4).
    read4 compression i_compression.
  ENDIF.


  CASE i_compression.
    WHEN 0.
      s_compression = 'BI_RGB'.
    WHEN 1.
      s_compression = 'BI_RLE8'.
    WHEN 2.
      s_compression = 'BI_RLE4'.
    WHEN 3.
      s_compression = 'BI_BITFIELDS'.
    WHEN 4.
      s_compression = 'BI_JPEG'.
    WHEN 5.
      s_compression = 'BI_PNG'.
    WHEN 6.
      s_compression = 'BI_ALPHABITFIELDS'.
    WHEN 11.
      s_compression = 'BI_CMYK'.
    WHEN 12.
      s_compression = 'BI_CMYKRLE8'.
    WHEN 13.
      s_compression = 'BI_CMYKRLE4'.
  ENDCASE.



  "---- Pixel array

  "At this point we can get the data
  DATA:
    x_data       TYPE xstring,
    i_num_pixels TYPE i.
  x_data = x_bmp+i_data_offset.
  i_num_pixels = xstrlen( x_data ).
  DIVIDE i_num_pixels BY 3. "For the RGB channels i assume

*  "This flips the data
*  DATA:
*    i_counter  TYPE i,
*    x_new_data TYPE xstring.
*  DO i_height TIMES.
*    CONCATENATE x_data+i_counter(i_width) x_new_data INTO x_new_data IN BYTE MODE.
*    i_counter = i_counter + i_width.
*  ENDDO.

  "Take all information up the old data and concatenate it with the new (flipped) data
  DATA(x_new_data) = x_data.
  DATA x_new_image TYPE xstring.
  CONCATENATE x_bmp(i_data_offset) x_new_data INTO x_new_image IN BYTE MODE.

  "now we go from xstring back to binary
  DATA:
    BEGIN OF graphic_table_new OCCURS 0,
      line(255) TYPE x,
    END OF graphic_table_new.

  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = x_new_image
    TABLES
      binary_tab = graphic_table_new[].

  "and now we prepare everything for displaying the flipped image
  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type    = 'IMAGE'
      subtype = 'BMP'
    TABLES
      data    = graphic_table_new[]
    CHANGING
      url     = url.

  picture->load_picture_from_url( url ).

  picture->set_display_mode( picture->display_mode_normal ).
ENDFORM.
