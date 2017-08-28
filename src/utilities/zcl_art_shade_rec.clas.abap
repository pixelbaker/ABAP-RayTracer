CLASS zcl_art_shade_rec DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    DATA:
      hit_an_object   TYPE abap_bool,
      local_hit_point TYPE REF TO zcl_art_point3d,
      normal          TYPE REF TO zcl_art_normal,
      color           TYPE REF TO zcl_art_rgb_color,
      world           TYPE REF TO zcl_art_world.


    METHODS:
      constructor
        IMPORTING
          i_world     TYPE REF TO zcl_art_world OPTIONAL "Constructor with world
          i_shade_rec TYPE REF TO zcl_art_shade_rec OPTIONAL. "Copy Constructor


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_shade_rec IMPLEMENTATION.


  METHOD constructor.
    IF i_world IS SUPPLIED.
      ASSERT i_world IS BOUND.

      hit_an_object = abap_false.
      CREATE OBJECT local_hit_point.
      CREATE OBJECT normal.
      CREATE OBJECT color
        EXPORTING
          i_color = zcl_art_rgb_color=>black.
      world = i_world.
      RETURN.
    ENDIF.


    IF i_shade_rec IS SUPPLIED.
      ASSERT i_shade_rec IS BOUND.
      SYSTEM-CALL OBJMGR CLONE i_shade_rec TO me.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
