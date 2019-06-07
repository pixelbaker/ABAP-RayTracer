CLASS ucl_art_ray DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_default FOR TESTING,
      new_copy FOR TESTING,
      new_from_point_and_vector FOR TESTING,

      assignment1 FOR TESTING,
      assignment2 FOR TESTING.

ENDCLASS.


CLASS ucl_art_ray IMPLEMENTATION.

  METHOD new_default.
    "Check that the default constructor works

    "When
    DATA(cut) = zcl_art_ray=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut ).
    cl_abap_unit_assert=>assert_bound( cut->direction ).
    cl_abap_unit_assert=>assert_bound( cut->origin ).
  ENDMETHOD.


  METHOD new_copy.
    "Check that the copy constructor works

    "Given
    DATA(ray) = zcl_art_ray=>new_default( ).
    ray->direction->x = 1.
    ray->direction->y = 2.
    ray->direction->z = 3.
    ray->origin->x = 4.
    ray->origin->y = 5.
    ray->origin->z = 6.

    "When
    DATA(cut) = zcl_art_ray=>new_copy( ray ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut ).
    cl_abap_unit_assert=>assert_bound( cut->direction ).
    cl_abap_unit_assert=>assert_bound( cut->origin ).

    cl_abap_unit_assert=>assert_true( xsdbool( cut <> ray ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->origin <> ray->origin ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->direction <> ray->direction ) ).

    cl_abap_unit_assert=>assert_equals( exp = 1  act = cut->direction->x ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = cut->direction->y ).
    cl_abap_unit_assert=>assert_equals( exp = 3  act = cut->direction->z ).
    cl_abap_unit_assert=>assert_equals( exp = 4  act = cut->origin->x ).
    cl_abap_unit_assert=>assert_equals( exp = 5  act = cut->origin->y ).
    cl_abap_unit_assert=>assert_equals( exp = 6  act = cut->origin->z ).
  ENDMETHOD.


  METHOD new_from_point_and_vector.
    "Check that supplying a point and a vector constructs a valid ray

    "Given
    DATA(direction) = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).
    DATA(origin) = zcl_art_point3d=>new_individual( i_x = 4  i_y = 5  i_z = 6 ).

    "When
    DATA(cut) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = direction
      i_origin = origin ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut ).
    cl_abap_unit_assert=>assert_bound( cut->direction ).
    cl_abap_unit_assert=>assert_bound( cut->origin ).

    cl_abap_unit_assert=>assert_true( xsdbool( cut->origin <> origin ) ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->direction <> direction ) ).

    cl_abap_unit_assert=>assert_equals( exp = 1  act = cut->direction->x ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = cut->direction->y ).
    cl_abap_unit_assert=>assert_equals( exp = 3  act = cut->direction->z ).
    cl_abap_unit_assert=>assert_equals( exp = 4  act = cut->origin->x ).
    cl_abap_unit_assert=>assert_equals( exp = 5  act = cut->origin->y ).
    cl_abap_unit_assert=>assert_equals( exp = 6  act = cut->origin->z ).
  ENDMETHOD.


  METHOD assignment1.
    "Assign the same ray to itself.

    "Given
    DATA(ray) = zcl_art_ray=>new_default( ).

    "When
    DATA(cut) = ray->assignment( ray ).

    "Then
    cl_abap_unit_assert=>assert_equals( act = cut  exp = ray ).
  ENDMETHOD.


  METHOD assignment2.
    "Assign a different ray

    "Given
    DATA(ray) = zcl_art_ray=>new_from_point_and_vector(
      i_direction = zcl_art_vector3d=>new_unified( 1 )
      i_origin = zcl_art_point3d=>new_unified( 2 ) ).


    DATA(cut) = zcl_art_ray=>new_default( ).

    "When
    DATA(result) = cut->assignment( ray ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( ray <> cut ) ).
    cl_abap_unit_assert=>assert_equals( act = cut  exp = result ).
    cl_abap_unit_assert=>assert_equals( act = cut->direction->x  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->direction->y  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->direction->z  exp = 1 ).
    cl_abap_unit_assert=>assert_equals( act = cut->origin->x  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->origin->y  exp = 2 ).
    cl_abap_unit_assert=>assert_equals( act = cut->origin->z  exp = 2 ).
  ENDMETHOD.
ENDCLASS.
