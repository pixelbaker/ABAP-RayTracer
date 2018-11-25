CLASS ucl_art_plane DEFINITION
FINAL
FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _shade_rec TYPE REF TO zcl_art_shade_rec.


    METHODS:
      setup,

      new_by_normal_and_point FOR TESTING,
      new_copy FOR TESTING,
      new_default FOR TESTING,

      hit1 FOR TESTING,
      hit2 FOR TESTING,
      hit3 FOR TESTING.

ENDCLASS.


CLASS ucl_art_plane IMPLEMENTATION.
  METHOD setup.
    DATA(world) = NEW zcl_art_world( ).
    _shade_rec = zcl_art_shade_rec=>new_from_world( world ).
  ENDMETHOD.


  METHOD hit1.
    "Check that positive infinity gets returned during a positive hit

    "Given
    DATA(cut) = zcl_art_plane=>new_by_normal_and_point(
      i_normal = zcl_art_normal=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_point = zcl_art_point3d=>new_individual( i_x = 0  i_y = 0  i_z = 0 ) ).

    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_origin    = zcl_art_point3d=>new_individual(  i_x = 0  i_y = 0  i_z = 0 ) ).


    "When
    DATA tmin TYPE decfloat16.
    DATA(was_hit) = cut->hit(
      EXPORTING
        i_ray = ray
      IMPORTING
        e_tmin = tmin
      CHANGING
        c_shade_rec = _shade_rec ).


    "Then
    cl_abap_unit_assert=>assert_true( was_hit ).
    cl_abap_unit_assert=>assert_equals(
      act = tmin
      exp = cl_abap_math=>max_decfloat16 ).
  ENDMETHOD.


  METHOD hit2.
    "Check that negative infinity gets returned without a hit

    "Given
    DATA(cut) = zcl_art_plane=>new_by_normal_and_point(
      i_normal = zcl_art_normal=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_point = zcl_art_point3d=>new_individual( i_x = 0  i_y = 0  i_z = 0 ) ).

    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 )
      i_origin    = zcl_art_point3d=>new_individual(  i_x = 1  i_y = 1  i_z = 1 ) ).


    "When
    DATA tmin TYPE decfloat16.
    DATA(was_hit) = cut->hit(
      EXPORTING
        i_ray = ray
      IMPORTING
        e_tmin = tmin
      CHANGING
        c_shade_rec = _shade_rec ).


    "Then
    cl_abap_unit_assert=>assert_false( was_hit ).
    cl_abap_unit_assert=>assert_equals(
      act = tmin
      exp = 0 ).
  ENDMETHOD.


  METHOD hit3.
    "Check that division not by zero works and a hit gets produced

    "Given
    DATA(cut) = zcl_art_plane=>new_by_normal_and_point(
      i_normal = zcl_art_normal=>new_individual( i_x = 0  i_y = 1  i_z = 0 )
      i_point = zcl_art_point3d=>new_individual( i_x = 0  i_y = 0  i_z = 0 ) ).

    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_individual( i_x = 0  i_y = -1  i_z = 0 )
      i_origin    = zcl_art_point3d=>new_individual(  i_x = 0  i_y = 2   i_z = 0 ) ).


    "When
    DATA tmin TYPE decfloat16.
    DATA(was_hit) = cut->hit(
      EXPORTING
        i_ray = ray
      IMPORTING
        e_tmin = tmin
      CHANGING
        c_shade_rec = _shade_rec ).


    "Then
    cl_abap_unit_assert=>assert_true( was_hit ).
    cl_abap_unit_assert=>assert_equals(
      act = tmin
      exp = 2 ).
  ENDMETHOD.


  METHOD new_by_normal_and_point.
    "Constructs a new instance of a plane based on a normal and a point and normalizes the normal

    "When
    DATA(cut) = zcl_art_plane=>new_by_normal_and_point(
      i_normal = zcl_art_normal=>new_unified( 1 )
      i_point = zcl_art_point3d=>new_unified( 2 ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->point->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->point->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->point->z  exp = 2 ).

    "Normalized
    cl_abap_unit_assert=>assert_equals( act = cut->normal->x  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->normal->y  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->normal->z  exp = '0.5773502691896259' ).

    cl_abap_unit_assert=>assert_bound( act = cut->get_color( ) ).
  ENDMETHOD.


  METHOD new_copy.
    "Copy constructor generates a new instance of a plane based on another plane

    "Given
    DATA(plane) = zcl_art_plane=>new_by_normal_and_point(
      i_normal = zcl_art_normal=>new_unified( 1 )
      i_point = zcl_art_point3d=>new_unified( 2 ) ).
    plane->set_color_by_components( i_r = 1  i_g = 2  i_b = 3 ).

    "When
    DATA(cut) = zcl_art_plane=>new_copy( plane ).

    "Then
    cl_abap_unit_assert=>assert_true( act = COND #( WHEN plane <> cut THEN abap_true ) ).

    cl_abap_unit_assert=>assert_true( act = COND #( WHEN plane->point <> cut->point THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->point->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->point->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->point->z  exp = 2 ).

    cl_abap_unit_assert=>assert_true( act = COND #( WHEN plane->normal <> cut->normal THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->normal->x  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->normal->y  exp = '0.5773502691896259' ).
    cl_abap_unit_assert=>assert_equals( act = cut->normal->z  exp = '0.5773502691896259' ).

    cl_abap_unit_assert=>assert_true( act = COND #( WHEN plane->get_color( ) <> cut->get_color( ) THEN abap_true ) ).
    cl_abap_unit_assert=>assert_equals( act = cut->get_color( )->r  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->get_color( )->g  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->get_color( )->b  exp = 3 ).
  ENDMETHOD.


  METHOD new_default.
    "Default constructor generates a plane in the world origin with a zero normal

    "When
    DATA(cut) = zcl_art_plane=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut->point->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->point->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->point->z  exp = 0 ).

    cl_abap_unit_assert=>assert_equals( act = cut->normal->x  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->normal->y  exp = 0 ).
    cl_abap_unit_assert=>assert_equals( act = cut->normal->z  exp = 0 ).
  ENDMETHOD.
ENDCLASS.
