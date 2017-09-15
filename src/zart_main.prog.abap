*&---------------------------------------------------------------------*
*& Report zart_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_main.


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
  DATA bitmap_stream TYPE xstring.
  PERFORM render CHANGING bitmap_stream.
  PERFORM display USING bitmap_stream.
ENDMODULE.


FORM render CHANGING c_bitmap_stream.
  DATA(world) = NEW zcl_art_world( ).
  world->build( ).
  world->render_scene( ).
  c_bitmap_stream = world->bitmap->build( ).
ENDFORM.


FORM display USING i_bitmap_stream.
  DATA(container) = NEW cl_gui_custom_container( container_name = 'PICTURE' ).
  DATA(picture) = NEW cl_gui_picture( parent = container ).

  "now we go from XSTRING back to binary
  DATA:
    BEGIN OF graphic_table_new OCCURS 0,
      line(255) TYPE x,
    END OF graphic_table_new.

  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = i_bitmap_stream
    TABLES
      binary_tab = graphic_table_new[].


  "and now we prepare everything for displaying
  DATA url TYPE cndp_url.
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
