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

  DATA(world) = NEW zcl_art_world( ).
  world->build( ).
  world->render_scene( ).
