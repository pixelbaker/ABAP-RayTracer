CLASS ucl_art_viewplane DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_default FOR TESTING,
      new_copy FOR TESTING.

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
    cl_abap_unit_assert=>assert_bound( cut->Sampler ).
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sampler <> sampler ) ).
  ENDMETHOD.
ENDCLASS.
