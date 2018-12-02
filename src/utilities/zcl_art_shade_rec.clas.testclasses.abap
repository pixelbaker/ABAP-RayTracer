CLASS ucl_art_shade_rec DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_copy1 FOR TESTING,
      new_from_world1 FOR TESTING.

ENDCLASS.


CLASS ucl_art_shade_rec IMPLEMENTATION.

  METHOD new_copy1.
    "Check, that the copy constructor works

    "Given
    DATA(world) = NEW zcl_art_world( ).
    DATA(shade_rec) = zcl_art_shade_rec=>new_from_world( world ).
    shade_rec->hit_an_object = abap_true.
    shade_rec->local_hit_point = zcl_art_point3d=>new_unified( 2 ).
    shade_rec->normal = zcl_art_normal=>new_unified( 3 ).
    shade_rec->color = zcl_art_rgb_color=>new_unified( 4 ).

    "When
    DATA(result) = zcl_art_shade_rec=>new_copy( shade_rec ).

    "Then
    cl_abap_unit_assert=>assert_true( COND #( WHEN result <> shade_rec THEN abap_true ) ).
    cl_abap_unit_assert=>assert_true( COND #( WHEN result->color <> shade_rec->color THEN abap_true ) ).
    cl_abap_unit_assert=>assert_true( COND #( WHEN result->local_hit_point <> shade_rec->local_hit_point THEN abap_true ) ).
    cl_abap_unit_assert=>assert_true( COND #( WHEN result->normal <> shade_rec->normal THEN abap_true ) ).

    cl_abap_unit_assert=>assert_equals(
      exp = world
      act = result->world ).

    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->hit_an_object
      act = result->hit_an_object ).

    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->local_hit_point->x
      act = result->local_hit_point->x ).
    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->local_hit_point->y
      act = result->local_hit_point->y ).
    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->local_hit_point->z
      act = result->local_hit_point->z ).

    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->normal->x
      act = result->normal->x ).
    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->normal->y
      act = result->normal->y ).
    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->normal->z
      act = result->normal->z ).

    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->color->r
      act = result->color->r ).
    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->color->g
      act = result->color->g ).
    cl_abap_unit_assert=>assert_equals(
      exp = shade_rec->color->b
      act = result->color->b ).
  ENDMETHOD.


  METHOD new_from_world1.
    "Check that the constructor from a world object works

    "Given
    DATA(world) = NEW zcl_art_world( ).

    "When
    DATA(result) = zcl_art_shade_rec=>new_from_world( world ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = world  act = result->world ).
    cl_abap_unit_assert=>assert_bound( result->color ).
    cl_abap_unit_assert=>assert_bound( result->local_hit_point ).
    cl_abap_unit_assert=>assert_bound( result->normal ).
  ENDMETHOD.
ENDCLASS.
