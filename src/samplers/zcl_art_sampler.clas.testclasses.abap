CLASS lcl_dummy DEFINITION
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_num_sets    TYPE int4 OPTIONAL
          i_sampler     TYPE REF TO zcl_art_sampler OPTIONAL.

  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.

ENDCLASS.

CLASS lcl_dummy IMPLEMENTATION.
  METHOD generate_samples.
    "We fill the various attributes,
    "so the copy constructor has something to do later on inside the copy constructor test

    DO _num_sets * _num_samples TIMES.
      APPEND NEW zcl_art_point2d( i_x = CONV #( '1.0' / sy-index )
                                  i_y = CONV #( '1.0' / sy-index ) ) TO _samples.

      APPEND NEW zcl_art_point2d( i_x = CONV #( '1.0' / sy-index )
                                  i_y = CONV #( '1.0' / sy-index ) ) TO _disk_samples.

      APPEND zcl_art_point3d=>new_individual( i_x = CONV #( '1.0' / sy-index )
                                              i_y = CONV #( '1.0' / sy-index )
                                              i_z = CONV #( '1.0' / sy-index ) ) TO _sphere_samples.

      APPEND zcl_art_point3d=>new_individual( i_x = CONV #( '1.0' / sy-index )
                                              i_y = CONV #( '1.0' / sy-index )
                                              i_z = CONV #( '1.0' / sy-index ) ) TO _hemisphere_samples.
    ENDDO.
  ENDMETHOD.


  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_num_sets    = i_num_sets
      i_sampler     = i_sampler ).

    generate_samples( ).
  ENDMETHOD.
ENDCLASS.


CLASS lcl_dummy_for_hemisphere_Test DEFINITION
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_num_sets    TYPE int4 OPTIONAL
          i_sampler     TYPE REF TO zcl_art_sampler OPTIONAL.

  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.

ENDCLASS.

CLASS lcl_dummy_for_hemisphere_Test IMPLEMENTATION.
  METHOD generate_samples.
    "We fill the various attributes,
    "so the copy constructor has something to do later on inside the copy constructor test

    DO _num_sets * _num_samples TIMES.
      APPEND NEW zcl_art_point2d( i_x = CONV #( '1.0' / sy-index )
                                  i_y = CONV #( '1.0' / sy-index ) ) TO _samples.
    ENDDO.
  ENDMETHOD.


  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_num_sets    = i_num_sets
      i_sampler     = i_sampler ).

    generate_samples( ).
  ENDMETHOD.
ENDCLASS.




CLASS ucl_art_sampler DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_sampler.


    METHODS:
      setup,

      constructor1 FOR TESTING,
      constructor2 FOR TESTING,
      constructor3 FOR TESTING,
      constructor4 FOR TESTING,

      sample_unit_square FOR TESTING,
      sample_unit_disk FOR TESTING,
      sample_sphere FOR TESTING,
      sample_one_set FOR TESTING,
      sample_hemisphere FOR TESTING,

      map_samples_to_hemisphere FOR TESTING.

ENDCLASS.


CLASS ucl_art_sampler IMPLEMENTATION.
  METHOD setup.
  ENDMETHOD.


  METHOD constructor1.
    "Test the default constructor

    "When
    DATA(cut) = NEW lcl_dummy( ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 1   act = cut->get_num_samples( ) ).
  ENDMETHOD.


  METHOD constructor2.
    "Test the copy constructor

    "Given
    DATA(sampler) = NEW lcl_dummy( i_num_samples = 42 ).

    "When
    DATA(cut) = NEW lcl_dummy( i_sampler = sampler ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 42   act = cut->get_num_samples( ) ).
  ENDMETHOD.


  METHOD constructor3.
    "Test the constructor with num_samples/num_sets provided

    "When
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 42
      i_num_sets = 2 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 42   act = cut->get_num_samples( ) ).
  ENDMETHOD.


  METHOD constructor4.
    "Test the constructor with num_samples provided

    "When
    DATA(cut) = NEW lcl_dummy( i_num_samples = 42 ).

    "Then
    cl_abap_unit_assert=>assert_equals( exp = 42   act = cut->get_num_samples( ) ).
  ENDMETHOD.


  METHOD sample_unit_square.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 2
      i_num_sets = 2 ).

    "When
    DATA(sample_point) = cut->sample_unit_square( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD sample_unit_disk.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 2
      i_num_sets = 2 ).

    "When
    DATA(sample_point) = cut->sample_unit_disk( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD sample_sphere.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 2
      i_num_sets = 2 ).

    "When
    DATA(sample_point) = cut->sample_sphere( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD sample_one_set.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 2
      i_num_sets = 2 ).

    "When
    DATA(sample_point) = cut->sample_one_set( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
    cl_abap_unit_assert=>assert_equals( exp = 1   act = sample_point->x ).
  ENDMETHOD.


  METHOD sample_hemisphere.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 2
      i_num_sets = 2 ).

    "When
    DATA(sample_point) = cut->sample_hemisphere( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD map_samples_to_hemisphere.
    "

    "Given
    DATA(cut) = NEW lcl_dummy_for_hemisphere_Test(
      i_num_samples = 2
      i_num_sets = 1 ).

    "When
    cut->map_samples_to_hemisphere( i_exponent = 1 ).
    DATA(sample_point) = cut->sample_hemisphere( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.
ENDCLASS.
