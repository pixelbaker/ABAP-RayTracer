*&---------------------------------------------------------------------*
*& Report zart_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_main.



DATA:
  container1 TYPE REF TO cl_gui_custom_container,
  picture    TYPE REF TO cl_gui_picture,
  url        TYPE cndp_url.

START-OF-SELECTION.
  "define some objects
  "specify a material for each object
  "define some light sources
  "define a window whose surface is covered with pixels

  "for each pixel
  "   shoot a ray towards the objects from the center of the pixel
  "   compute the nearest hit point of the ray with the objects (if any)

  "   if the ray hits an object
  "       use the object's material and the lights to compute the pixel color
  "   else
  "       set the pixel color to black
  CALL SCREEN 100.


MODULE status_0100 OUTPUT.
  PERFORM render.
ENDMODULE.


FORM render.
  CREATE OBJECT:
    container1 EXPORTING container_name = 'PICTURE',
    picture EXPORTING parent = container1.

  DATA(world) = NEW zcl_art_world( ).
  world->build( ).
  world->render_scene( ).
  DATA(bitmap_stream) = world->bitmap->build( ).

  "now we go from xstring back to binary
  DATA:
    BEGIN OF graphic_table_new OCCURS 0,
      line(255) TYPE x,
    END OF graphic_table_new.

  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = bitmap_stream
    TABLES
      binary_tab = graphic_table_new[].

  "and now we prepare everything for displaying
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
