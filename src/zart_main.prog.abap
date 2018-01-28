*&---------------------------------------------------------------------*
*& Report zart_main
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_main.

DATA:
  t_resolution  TYPE string,
  t_render_time TYPE string,
  t_memory      TYPE string,
  t_objects     TYPE string,
  t_rays        TYPE string,
  t_dimension   TYPE string,
  t_samples     TYPE string.


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

  GET TIME STAMP FIELD DATA(start_time).
  cl_abap_memory_utilities=>get_total_used_size( IMPORTING size = DATA(start_size) ).

  PERFORM render CHANGING bitmap_stream.

  cl_abap_memory_utilities=>get_total_used_size( IMPORTING size = DATA(end_size) ).
  GET TIME STAMP FIELD DATA(end_time).

  DATA elapsed_seconds TYPE int8.
  CALL FUNCTION 'RSSM_SUBSTRACT_TIMESTAMPS'
    EXPORTING
      timestamp1 = end_time
      timestamp2 = start_time
    IMPORTING
      secs       = elapsed_seconds.

  t_render_time = NEW zcl_art_time_formater( )->make_human_readable_time_code( elapsed_seconds ).
  t_memory = NEW zcl_art_byte_formater( )->make_human_readable_byte_count( end_size - start_size ).

  PERFORM display USING bitmap_stream.
ENDMODULE.


FORM render CHANGING c_bitmap_stream.
  DATA(world) = NEW zcl_art_world( ).
  world->build( ).
  world->render_scene( ).
  c_bitmap_stream = world->bitmap->build( ).

  t_samples =  |{ world->viewplane->num_samples NUMBER = USER }|.
  t_dimension = |{ world->bitmap->image_width_in_pixel }x{ world->bitmap->image_height_in_pixel } px|.
  t_resolution = |{ ( world->bitmap->image_height_in_pixel * world->bitmap->image_width_in_pixel ) NUMBER = USER } px|.
  t_objects = world->get_num_objects( ).
  t_rays = |{ world->num_rays NUMBER = USER }|.
ENDFORM.


FORM display USING i_bitmap_stream.
  DATA(container) = NEW cl_gui_custom_container( container_name = 'PICTURE' ).
  DATA(picture) = NEW cl_gui_picture( parent = container ).

  "now we go from XSTRING back to binary
  TYPES binary_row TYPE x LENGTH 255. "255 might get better along with CL_IGS_IMAGE_CONVERTER, see set_image
  DATA binary_rows TYPE TABLE OF binary_row WITH DEFAULT KEY.


  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = i_bitmap_stream
    TABLES
      binary_tab = binary_rows.


  "and now we prepare everything for display
  DATA url TYPE cndp_url.
  CALL FUNCTION 'DP_CREATE_URL'
    EXPORTING
      type    = 'IMAGE'
      subtype = 'BMP'
    TABLES
      data    = binary_rows
    CHANGING
      url     = url.


  picture->load_picture_from_url( url ).
  picture->set_display_mode( picture->display_mode_normal ).
ENDFORM.
