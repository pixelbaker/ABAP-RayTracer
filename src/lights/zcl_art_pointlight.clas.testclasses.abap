CLASS ucl_art_pointlight DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_default FOR TESTING,
      new_copy FOR TESTING,

      get_direction FOR TESTING,
      l FOR TESTING,

      assign_by_pointlight FOR TESTING,
      scale_radiance FOR TESTING,
      set_color_by_color FOR TESTING,
      set_color_by_components FOR TESTING,
      set_color_by_decfloat FOR TESTING,
      set_location_by_components FOR TESTING,
      set_location_by_point FOR TESTING.

ENDCLASS.


CLASS ucl_art_pointlight IMPLEMENTATION.
  METHOD new_default.
    "Test, that the default constructor works

    "When
    DATA(cut) = zcl_art_pointlight=>new_default( ).

    "Then
    DATA(shading_record) = zcl_art_shade_rec=>new_from_world( NEW zcl_art_world( ) ).

    cl_abap_unit_assert=>assert_bound( cut->get_direction( shading_record ) ).
    cl_abap_unit_assert=>assert_bound( cut->l( shading_record ) ).
  ENDMETHOD.


  METHOD new_copy.
    "Test, that the copy constructor works

    "Given
    DATA(pointlight) = zcl_art_pointlight=>new_default( ).
    pointlight->scale_radiance( '4.0' ).
    pointlight->set_color_by_decfloat( '0.5' ).
    pointlight->set_location_by_components( i_dx = '2'  i_dy = '2'  i_dz = '1' ).

    "When
    DATA(cut) = zcl_art_pointlight=>new_copy( pointlight ).

    "Then
    DATA(shading_record) = zcl_art_shade_rec=>new_from_world( NEW zcl_art_world( ) ).

    cl_abap_unit_assert=>assert_true( xsdbool( cut <> pointlight ) ).
    DATA(direction) = cut->get_direction( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '0.6666666666666667'  act = direction->x ).
    cl_abap_unit_assert=>assert_equals( exp = '0.6666666666666667'  act = direction->y ).
    cl_abap_unit_assert=>assert_equals( exp = '0.3333333333333333'  act = direction->z ).

    DATA(radiance) = cut->l( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->r ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->g ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->b ).
  ENDMETHOD.


  METHOD get_direction.
    "Test, that the direction of the light gets returned

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).
    DATA(shading_record) = zcl_art_shade_rec=>new_from_world( NEW zcl_art_world( ) ).

    "When
    DATA(direction) = cut->get_direction( shading_record ).

    "Then
    cl_abap_unit_assert=>assert_bound( direction ).
  ENDMETHOD.


  METHOD l.
    "Test, that the incident radiance of the light gets returned

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).
    cut->scale_radiance( '4.0' ).
    cut->set_color_by_decfloat( '0.5' ).

    DATA shading_record TYPE REF TO zcl_art_shade_rec.

    "When
    DATA(radiance) = cut->l( shading_record ).

    "Then
    cl_abap_unit_assert=>assert_bound( radiance ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->r ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->g ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->b ).
  ENDMETHOD.


  METHOD assign_by_pointlight.
    "Test, that the assignment (operation=) works

    "Given
    DATA(pointlight) = zcl_art_pointlight=>new_default( ).
    pointlight->scale_radiance( '4.0' ).
    pointlight->set_color_by_decfloat( '0.5' ).
    pointlight->set_location_by_components( i_dx = '2'  i_dy = '2'  i_dz = '1' ).

    DATA(cut) = zcl_art_pointlight=>new_default( ).

    "When
    cut->assign_by_pointlight( pointlight ).

    "Then
    DATA(shading_record) = zcl_art_shade_rec=>new_from_world( NEW zcl_art_world( ) ).

    DATA(act_direction) = cut->get_direction( shading_record ).
    DATA(exp_direction) = pointlight->get_direction( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = exp_direction->x  act = act_direction->x ).
    cl_abap_unit_assert=>assert_equals( exp = exp_direction->y  act = act_direction->y ).
    cl_abap_unit_assert=>assert_equals( exp = exp_direction->z  act = act_direction->z ).

    DATA(act_radiance) = cut->l( shading_record ).
    DATA(exp_radiance) = pointlight->l( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = exp_radiance->r  act = act_radiance->r ).
    cl_abap_unit_assert=>assert_equals( exp = exp_radiance->g  act = act_radiance->g ).
    cl_abap_unit_assert=>assert_equals( exp = exp_radiance->b  act = act_radiance->b ).
  ENDMETHOD.


  METHOD scale_radiance.
    "Test, that scaling the radiance works

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).
    cut->set_color_by_components( i_r = '0.0'  i_g = '0.5'  i_b = '1.0' ).


    "When
    cut->scale_radiance( '4.0' ).


    "Then
    DATA shading_record TYPE REF TO zcl_art_shade_rec.

    DATA(radiance) = cut->l( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '0'  act = radiance->r ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->g ).
    cl_abap_unit_assert=>assert_equals( exp = '4'  act = radiance->b ).
  ENDMETHOD.


  METHOD set_color_by_color.
    "Test, that the directional color can be set by a color instance

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).


    "When
    cut->set_color_by_color( zcl_art_rgb_color=>new_red( ) ).


    "Then
    DATA shading_record TYPE REF TO zcl_art_shade_rec.

    DATA(radiance) = cut->l( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '1'  act = radiance->r ).
    cl_abap_unit_assert=>assert_equals( exp = '0'  act = radiance->g ).
    cl_abap_unit_assert=>assert_equals( exp = '0'  act = radiance->b ).
  ENDMETHOD.


  METHOD set_color_by_components.
    "Test, that the directional color can be set by the RGB components

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).


    "When
    cut->set_color_by_components( i_r = 1  i_g = 2  i_b = 3 ).


    "Then
    DATA shading_record TYPE REF TO zcl_art_shade_rec.

    DATA(radiance) = cut->l( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '1'  act = radiance->r ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->g ).
    cl_abap_unit_assert=>assert_equals( exp = '3'  act = radiance->b ).
  ENDMETHOD.


  METHOD set_color_by_decfloat.
    "Test, that the directional color can be set by a single value for all the RGB components

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).


    "When
    cut->set_color_by_decfloat( 2 ).


    "Then
    DATA shading_record TYPE REF TO zcl_art_shade_rec.

    DATA(radiance) = cut->l( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->r ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->g ).
    cl_abap_unit_assert=>assert_equals( exp = '2'  act = radiance->b ).
  ENDMETHOD.


  METHOD set_location_by_components.
    "Test, that the direction of the light can be set by its XYZ components

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).


    "When
    cut->set_location_by_components( i_dx = '1'  i_dy = '1'  i_dz = '1' ).


    "Then
    DATA(shading_record) = zcl_art_shade_rec=>new_from_world( NEW zcl_art_world( ) ).

    DATA(direction) = cut->get_direction( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '0.5773502691896259'  act = direction->x ).
    cl_abap_unit_assert=>assert_equals( exp = '0.5773502691896259'  act = direction->y ).
    cl_abap_unit_assert=>assert_equals( exp = '0.5773502691896259'  act = direction->z ).
  ENDMETHOD.


  METHOD set_location_by_point.
    "Test, that the direction of the light can be set by another 3D vector

    "Given
    DATA(cut) = zcl_art_pointlight=>new_default( ).


    "When
    cut->set_location_by_point( zcl_art_point3d=>new_unified( '1' ) ).


    "Then
    DATA(shading_record) = zcl_art_shade_rec=>new_from_world( NEW zcl_art_world( ) ).

    DATA(direction) = cut->get_direction( shading_record ).
    cl_abap_unit_assert=>assert_equals( exp = '0.5773502691896259'  act = direction->x ).
    cl_abap_unit_assert=>assert_equals( exp = '0.5773502691896259'  act = direction->y ).
    cl_abap_unit_assert=>assert_equals( exp = '0.5773502691896259'  act = direction->z ).
  ENDMETHOD.
ENDCLASS.
