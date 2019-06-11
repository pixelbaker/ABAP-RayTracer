CLASS ucl_art_viewplane DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_default FOR TESTING,
      new_copy FOR TESTING,
      assignment FOR TESTING,

      set_gamma FOR TESTING,
      set_gammut_display FOR TESTING,
      set_hres FOR TESTING,
      set_vres FOR TESTING,
      set_pixel_size FOR TESTING,
      set_num_samples1 FOR TESTING,
      set_num_samples2 FOR TESTING,
      set_sampler FOR TESTING.

ENDCLASS.


CLASS ucl_art_viewplane IMPLEMENTATION.
  METHOD new_default.
    "Test, that the default constructor works.

    "When
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut ).
    cl_abap_unit_assert=>assert_bound( cut->sampler ).
  ENDMETHOD.


  METHOD new_copy.
    "Test, that the copy constructor works.

    "Given
    DATA(viewplane) = zcl_art_viewplane=>new_default( ).
    DATA(sampler) = zcl_art_nrooks=>new_default( ).
    viewplane->set_sampler( sampler ).

    "When
    DATA(cut) = zcl_art_viewplane=>new_copy( viewplane ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut ).
    cl_abap_unit_assert=>assert_bound( cut->sampler ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sampler <> sampler ) ).

    "Unfortunately this is true, I rather like to make a clean copy of whatever sampler there is, but its tricky
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sampler IS NOT INSTANCE OF zcl_art_nrooks ) ).
  ENDMETHOD.


  METHOD assignment.
    "Test, that an assignment works

    "Given
    DATA(viewplane) = zcl_art_viewplane=>new_default( ).
    viewplane->set_num_samples( 200 ).
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    DATA(result) = cut->assignment( viewplane ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut ).
    cl_abap_unit_assert=>assert_equals( exp = 200  act = cut->num_samples ).
  ENDMETHOD.


  METHOD set_gamma.
    "Test, that setting the gamma also changes the inverse gamma.

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_gamma( 2 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 2  act = cut->gamma ).
    cl_abap_unit_assert=>assert_equals( exp = '.5'  act = cut->inv_gamma ).
  ENDMETHOD.


  METHOD set_gammut_display.
    "Test, that toggling the gammut display works

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_gamut_display( abap_true ).

    "Then
    cl_abap_unit_assert=>assert_true( cut->show_out_of_gamut ).
  ENDMETHOD.


  METHOD set_hres.
    "Test, that setting the horizontal number of pixels work

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_hres( 111 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 111  act = cut->hres ).
  ENDMETHOD.


  METHOD set_vres.
    "Test, that setting the vertical number of pixels work

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_vres( 222 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 222  act = cut->vres ).
  ENDMETHOD.


  METHOD set_pixel_size.
    "Test, that setting the pixel size works

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_pixel_size( '1.1' ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = '1.1'  act = cut->pixel_size ).
  ENDMETHOD.


  METHOD set_num_samples1.
    "Test, that setting 1 sample will also spark a regular sampler

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_num_samples( 1 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 1  act = cut->num_samples ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sampler IS INSTANCE OF zcl_art_regular ) ).
  ENDMETHOD.


  METHOD set_num_samples2.
    "Test, that setting more than 1 sample will instantiate a multi-jittered sampler

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_num_samples( 42 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 42  act = cut->num_samples ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sampler IS INSTANCE OF zcl_art_multijittered ) ).
  ENDMETHOD.


  METHOD set_sampler.
    "Test, that setting another sampler works, which also sets the num_samples accordingly

    "Given
    DATA(cut) = zcl_art_viewplane=>new_default( ).

    "When
    cut->set_sampler( zcl_art_random=>new_by_num_samples( 35 ) ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 35  act = cut->num_samples ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sampler IS INSTANCE OF zcl_art_random ) ).
  ENDMETHOD.
ENDCLASS.
