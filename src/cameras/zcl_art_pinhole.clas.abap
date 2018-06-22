CLASS zcl_art_pinhole DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_camera
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_pinhole TYPE REF TO zcl_art_pinhole OPTIONAL, "Copy constructor

      render_scene REDEFINITION,

      assignment_by_pinhole
        IMPORTING
          i_pinhole        TYPE REF TO zcl_art_pinhole
        RETURNING
          VALUE(r_pinhole) TYPE REF TO zcl_art_pinhole,

      set_view_plane_distance
        IMPORTING
          i_view_plane_distance TYPE decfloat16,

      set_zoom_factor
        IMPORTING
          i_zoom_factor TYPE decfloat16,

      get_direction
        IMPORTING
          i_point            TYPE REF TO zcl_art_point2d
        RETURNING
          VALUE(r_direction) TYPE REF TO zcl_art_vector3d.


  PRIVATE SECTION.
    DATA:
      _view_plane_distance TYPE decfloat16,
      _zoom_factor         TYPE decfloat16.

ENDCLASS.



CLASS zcl_art_pinhole IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).

    "Copy constructor
    IF i_pinhole IS SUPPLIED.
      ASSERT i_pinhole IS BOUND.
      assignment_by_pinhole( i_pinhole ).
      RETURN.
    ENDIF.

    "Default Constructor.
    _view_plane_distance = '500'.
    _zoom_factor = '1'.
  ENDMETHOD.


  METHOD render_scene.
    DATA:
      "! Sample point on a pixel
      sample_point TYPE REF TO zcl_art_point2d,
      depth        TYPE int4.

    DATA(viewplane) = zcl_art_viewplane=>new_copy( i_world->viewplane ).

    DATA num TYPE int4.
    num = sqrt( viewplane->num_samples ).

    viewplane->set_pixel_size( viewplane->pixel_size / _zoom_factor ).

    DATA(ray) = zcl_art_ray=>new_default( ).
    ray->origin = zcl_art_point3d=>new_copy( _eye ).

    DATA:
      row              TYPE int4,
      column           TYPE int4,
      sub_pixel_row    TYPE int4,
      sub_pixel_column TYPE int4.

    WHILE row < viewplane->vres.
      column = 0.
      WHILE column < viewplane->hres.
        "! Also called L, which is a symbol for radiance
        DATA(radiance) = zcl_art_rgb_color=>new_copy( zcl_art_rgb_color=>black ).

        sub_pixel_row = 0.
        WHILE sub_pixel_row < num.
          sub_pixel_column = 0.
          WHILE sub_pixel_column < num.

            sample_point->x = viewplane->pixel_size * ( column - '0.5' * viewplane->hres + ( '0.5' + sub_pixel_column ) ).
            sample_point->y = viewplane->pixel_size * ( row - '0.5' * viewplane->vres + ( '0,5' + sub_pixel_row  ) ).

            ray->direction = zcl_art_vector3d=>new_copy( get_direction( sample_point ) ).

            radiance->add_and_assign_by_color( i_world->tracer->trace_ray( i_ray = ray  i_depth = depth ) ).
*            ADD 1 TO me->num_rays.
            ADD 1 TO sub_pixel_column.
          ENDWHILE.
          ADD 1 TO sub_pixel_row.
        ENDWHILE.

        radiance->divide_and_assign_by_float( CONV #( viewplane->num_samples ) ).
        radiance->multiply_and_assign_by_float( CONV #( _exposure_time ) ).

        i_world->display_pixel(
          i_row = row
          i_column = column
          i_pixel_color = radiance ).
        ADD 1 TO column.
      ENDWHILE.

      ADD 1 TO row.
    ENDWHILE.
  ENDMETHOD.


  METHOD assignment_by_pinhole.
    ASSERT i_pinhole IS BOUND.
    r_pinhole = me.
    CHECK me <> i_pinhole.

    assignment_by_camera( i_pinhole ).

    _view_plane_distance = i_pinhole->_view_plane_distance.
    _zoom_factor = i_pinhole->_zoom_factor.
  ENDMETHOD.


  METHOD get_direction.
    DATA:
      u TYPE REF TO zcl_art_vector3d,
      v TYPE REF TO zcl_art_vector3d,
      w TYPE REF TO zcl_art_vector3d.

    u = _u->get_product_by_decfloat( i_point->x ).
    v = _v->get_product_by_decfloat( i_point->y ).
    w = _w->get_product_by_decfloat( _view_plane_distance ).

    r_direction = zcl_art_vector3d=>new_copy(
      u->get_sum_by_vector( v )->get_difference_by_vector( w ) ).

    r_direction->normalize( ).
  ENDMETHOD.


  METHOD set_view_plane_distance.
    _view_plane_distance = i_view_plane_distance.
  ENDMETHOD.


  METHOD set_zoom_factor.
    _zoom_factor = i_zoom_factor.
  ENDMETHOD.
ENDCLASS.
