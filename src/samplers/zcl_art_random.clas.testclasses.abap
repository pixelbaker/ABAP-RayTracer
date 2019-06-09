CLASS ucl_art_random DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    METHODS:
      new_by_num_samples FOR TESTING,
      new_default FOR TESTING,
      new_copy FOR TESTING.

ENDCLASS.


CLASS ucl_art_random IMPLEMENTATION.
  METHOD new_by_num_samples.
    "Test, that the constructor by num_samples works

    "When
    DATA(cut) = zcl_art_random=>new_by_num_samples( 2 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 2  act = cut->get_num_samples( ) ).
    cl_abap_unit_assert=>assert_bound( cut->sample_unit_square( ) ).
  ENDMETHOD.


  METHOD new_default.
    "Test, that the default constructor works

    "When
    DATA(cut) = zcl_art_random=>new_default( ).

    "Then
    cl_abap_unit_assert=>assert_not_initial( cut->get_num_samples( ) ).
    cl_abap_unit_assert=>assert_bound( cut->sample_unit_square( ) ).
  ENDMETHOD.


  METHOD new_copy.
    "Test, that the copy constructor works

    "Given
    DATA(sampler) = zcl_art_random=>new_by_num_samples( 2 ).

    "When
    DATA(cut) = zcl_art_random=>new_copy( sampler ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 2  act = cut->get_num_samples( ) ).
    cl_abap_unit_assert=>assert_bound( cut->sample_unit_square( ) ).
  ENDMETHOD.
ENDCLASS.
