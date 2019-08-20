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
    shade_rec->hit_point = zcl_art_point3d=>new_unified( 5 ).

    "When
    DATA(result) = zcl_art_shade_rec=>new_copy( shade_rec ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( result <> shade_rec ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( result->color <> shade_rec->color ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( result->local_hit_point <> shade_rec->local_hit_point ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( result->hit_point <> shade_rec->hit_point ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( result->normal <> shade_rec->normal ) ).

    cl_abap_unit_assert=>assert_equals( exp = world  act = result->world ).

    cl_abap_unit_assert=>assert_equals( exp = shade_rec->hit_an_object  act = result->hit_an_object ).

    cl_abap_unit_assert=>assert_equals( exp = shade_rec->local_hit_point->x  act = result->local_hit_point->x ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->local_hit_point->y  act = result->local_hit_point->y ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->local_hit_point->z  act = result->local_hit_point->z ).

    cl_abap_unit_assert=>assert_equals( exp = shade_rec->hit_point->x  act = result->hit_point->x ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->hit_point->y  act = result->hit_point->y ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->hit_point->z  act = result->hit_point->z ).

    cl_abap_unit_assert=>assert_equals( exp = shade_rec->normal->x  act = result->normal->x ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->normal->y  act = result->normal->y ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->normal->z  act = result->normal->z ).

    cl_abap_unit_assert=>assert_equals( exp = shade_rec->color->r  act = result->color->r ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->color->g  act = result->color->g ).
    cl_abap_unit_assert=>assert_equals( exp = shade_rec->color->b  act = result->color->b ).
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
    cl_abap_unit_assert=>assert_bound( result->hit_point ).
    cl_abap_unit_assert=>assert_bound( result->normal ).
  ENDMETHOD.
ENDCLASS.
