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
  ENDMETHOD.


  METHOD new_Copy.
    "Test, that the copy constructor works.

    "Given
    DATA(viewplane) = zcl_art_viewplane=>new_default( ).

    "When
    DATA(cut) = zcl_art_viewplane=>new_copy( viewplane ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut ).
  ENDMETHOD.
ENDCLASS.
