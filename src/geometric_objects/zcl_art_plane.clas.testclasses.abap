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
ENDCLASS.
