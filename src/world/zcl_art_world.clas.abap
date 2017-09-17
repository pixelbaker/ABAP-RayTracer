CLASS zcl_art_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  " The World class does not have a copy constructor or an assignment operator, for the following reasons:
  " 1    There's no need to copy construct or assign the World
  " 2    We wouldn't want to do this anyway, because the world can contain an arbitrary amount of data
  " 3    These operations wouldn't work because the world is self-referencing:
  "      the Tracer base class contains a pointer to the world. If we wrote a correct copy constructor for the
  "      Tracer class, the World copy constructor would call itself recursively until we ran out of memory.

  PUBLIC SECTION.
    TYPES:
      geometric_objects TYPE TABLE OF REF TO zcl_art_geometric_object WITH DEFAULT KEY.


    DATA:
      viewplane        TYPE REF TO zcl_art_viewplane,
      background_color TYPE REF TO zcl_art_rgb_color,
      tracer           TYPE REF TO zcl_art_tracer,
      sphere           TYPE REF TO zcl_art_sphere,

      objects          TYPE geometric_objects,

      bitmap           TYPE REF TO zcl_art_bitmap.


    METHODS:
      constructor,

      add_objects
        IMPORTING
          i_object TYPE REF TO zcl_art_geometric_object,

      build,

      render_scene,

      max_to_one
        IMPORTING
          REFERENCE(i_color) TYPE REF TO zcl_art_rgb_color
        RETURNING
          VALUE(r_color)     TYPE REF TO zcl_art_rgb_color,

      clamp_to_color
        IMPORTING
          REFERENCE(i_color) TYPE REF TO zcl_art_rgb_color
        RETURNING
          VALUE(r_color)     TYPE REF TO zcl_art_rgb_color,

      display_pixel
        IMPORTING
          i_row         TYPE int4
          i_column      TYPE int4
          i_pixel_color TYPE REF TO zcl_art_rgb_color,

      hit_bare_bones_objects
        IMPORTING
          i_ray              TYPE REF TO zcl_art_ray
        RETURNING
          VALUE(r_shade_rec) TYPE REF TO zcl_art_shade_rec.


  PRIVATE SECTION.
    METHODS:
      delete_objects,

      build_single_sphere.

ENDCLASS.



CLASS zcl_art_world IMPLEMENTATION.


  METHOD add_objects.
    INSERT i_object INTO TABLE objects.
  ENDMETHOD.


  METHOD build.
    build_single_sphere( ).

    bitmap = NEW zcl_art_bitmap(
      i_image_height_in_pixel = viewplane->vres
      i_image_width_in_pixel = viewplane->hres ).
  ENDMETHOD.


  METHOD build_single_sphere.
    viewplane->set_hres( 200 ).
    viewplane->set_vres( 200 ).
    viewplane->set_pixel_size( '1.0' ).
    viewplane->set_gamma( '1.0' ).

    background_color = zcl_art_rgb_color=>white.
    tracer = NEW zcl_art_single_sphere( me ).

    sphere->set_center( i_value = '0.0' ).
    sphere->set_radius( '85.0' ).
  ENDMETHOD.


  METHOD clamp_to_color.
    "Set color to red if any component is greater than one

    r_color = zcl_art_rgb_color=>new_copy( i_color ).

    IF r_color->r > '1.0' OR
       r_color->g > '1.0' OR
       r_color->b > '1.0'.

      r_color->r = '1.0'.
      r_color->g = '0.0'.
      r_color->b = '0.0'.
    ENDIF.
  ENDMETHOD.


  METHOD constructor.
    viewplane = NEW zcl_art_viewplane( ).
    background_color = zcl_art_rgb_color=>black.
    sphere = zcl_art_sphere=>new_default( ).
  ENDMETHOD.


  METHOD delete_objects.

  ENDMETHOD.


  METHOD display_pixel.
    " raw_color is the pixel color computed by the ray tracer
    " its RGB floating point components can be arbitrarily large
    " mapped_color has all components in the range [0, 1], but still floating point
    " display color has integer components for computer display
    " the Mac's components are in the range [0, 65535]
    " a PC's components will probably be in the range [0, 255]
    " the system-dependent code is in the function convert_to_display_color
    " the function SetCPixel is a Mac OS function

    DATA mapped_color TYPE REF TO zcl_art_rgb_color.

    IF viewplane->show_out_of_gamut = abap_true.
      mapped_color = clamp_to_color( i_pixel_color ).
    ELSE.
      mapped_color = max_to_one( i_pixel_color ).
    ENDIF.

    IF viewplane->gamma <> '1.0'.
      mapped_color = mapped_color->powc( viewplane->inv_gamma ).
    ENDIF.

    DATA(x) = i_column.
    DATA(y) = viewplane->vres - i_row - 1.

    DATA r TYPE int4.
    DATA g TYPE int4.
    DATA b TYPE int4.
    r = mapped_color->r * 255.
    g = mapped_color->g * 255.
    b = mapped_color->b * 255.

    bitmap->add_pixel(
      VALUE #(
        x = x
        y = y
        r = r
        g = g
        b = b ) ).

*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*    IF x = 0.
*      WRITE /1(*) y NO-GAP.
*    ENDIF.
*
*    IF r > 0 OR g > 0 OR b > 0.
*      WRITE AT x(1) '#'.
*    ENDIF.
*    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  ENDMETHOD.


  METHOD hit_bare_bones_objects.
    DATA t TYPE decfloat16.
    DATA tmin TYPE decfloat16 VALUE '10000000000'.
    r_shade_rec = zcl_art_shade_rec=>new_from_world( me ).

    LOOP AT objects ASSIGNING FIELD-SYMBOL(<object>).
      <object>->hit(
        EXPORTING
          i_ray = i_ray
        IMPORTING
          e_tmin = t
          e_hit = DATA(hit)
        CHANGING
          c_shade_rec = r_shade_rec ).

      IF hit = abap_true AND ( t < tmin ).
        r_shade_rec->hit_an_object = abap_true.
        tmin = t.
        r_shade_rec->color = <object>->get_color( ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD max_to_one.
    DATA max_value TYPE decfloat16.
    max_value = nmax(
      val1 = i_color->r
      val2 = nmax( val1 = i_color->g
                   val2 = i_color->b  ) ).

    IF max_value > '1.0'.
      r_color = i_color->get_quotient_by_decfloat( max_value ).
    ELSE.
      r_color = i_color.
    ENDIF.
  ENDMETHOD.


  METHOD render_scene.
    DATA:
      hres TYPE int4,
      vres TYPE int4,
      s    TYPE decfloat16,
      zw   TYPE decfloat16 VALUE '100.0'. "hard wired in

    hres = viewplane->hres.
    vres = viewplane->vres.
    s = viewplane->s.

    DATA(ray) = zcl_art_ray=>new_default( ).
    ray->direction = zcl_art_vector3d=>new_individual( i_x = 0 i_y = 0 i_z = -1 ).

    DATA row TYPE int4.
    DATA column TYPE int4.
    WHILE row < vres.
      column = 0.
      WHILE column < hres.
        ray->origin = zcl_art_point3d=>new_individual(
          i_x = s * ( column - hres / '2.0' + '0.5' )
          i_y = s * ( row - vres / '2.0' + '0.5' )
          i_z = zw ).

        DATA(pixel_color) = tracer->trace_ray( ray ).

        display_pixel(
          i_row = row
          i_column = column
          i_pixel_color = pixel_color ).
        ADD 1 TO column.
      ENDWHILE.

      ADD 1 TO row.
    ENDWHILE.
  ENDMETHOD.

ENDCLASS.
