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
          i_sampler     TYPE REF TO zcl_art_sampler OPTIONAL,

      prepare_copy_constructor_test,

      prepare_map_samples2unit_disk.


  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.

ENDCLASS.

CLASS lcl_dummy IMPLEMENTATION.
  METHOD generate_samples.
    DO _num_sets * _num_samples TIMES.
      APPEND NEW zcl_art_point2d( i_x = ( '1' / sy-index )
                                  i_y = ( '1' / sy-index ) ) TO _samples.
    ENDDO.
  ENDMETHOD.


  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_num_sets    = i_num_sets
      i_sampler     = i_sampler ).

    generate_samples( ).
  ENDMETHOD.


  METHOD prepare_map_samples2unit_disk.
    CLEAR _samples.

    APPEND NEW zcl_art_point2d( i_x = 1
                                i_y = 1 ) TO _samples.

    APPEND NEW zcl_art_point2d( i_x = 0
                                i_y = 0 ) TO _samples.

    APPEND NEW zcl_art_point2d( i_x = 0
                                i_y = 1 ) TO _samples.

    APPEND NEW zcl_art_point2d( i_x = 1
                                i_y = '.5' ) TO _samples.

    APPEND NEW zcl_art_point2d( i_x = '.5'
                                i_y = '.5' ) TO _samples.

  ENDMETHOD.


  METHOD prepare_copy_constructor_test.
    "We fill the various attributes,
    "so the copy constructor has something to do later on inside the copy constructor test

    DO _num_sets * _num_samples TIMES.
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

      map_samples_to_hemisphere FOR TESTING,
      map_samples_to_sphere FOR TESTING,
      map_samples_to_unit_disk FOR TESTING,

      shuffle_x_coordinates for testing,
      shuffle_y_coordinates for testing.

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
    sampler->prepare_copy_constructor_test( ).

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
      i_num_samples = 1
      i_num_sets = 1 ).

    "When
    DATA(sample_point) = cut->sample_unit_square( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD sample_unit_disk.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1
      i_num_sets = 1 ).
    cut->map_samples_to_unit_disk( ).

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
    cut->map_samples_to_sphere( ).

    "When
    DATA(sample_point) = cut->sample_sphere( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD sample_one_set.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1
      i_num_sets = 1 ).

    "When
    DATA(sample_point) = cut->sample_one_set( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD sample_hemisphere.
    "Test, that a pre calculated sample point gets returned

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1
      i_num_sets = 1 ).
    cut->map_samples_to_hemisphere( i_exponent = 1 ).

    "When
    DATA(sample_point) = cut->sample_hemisphere( ).

    "Then
    cl_abap_unit_assert=>assert_bound( sample_point ).
  ENDMETHOD.


  METHOD map_samples_to_hemisphere.
    "Test, that the the unit square sample points are being mapped to a hemisphere

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1
      i_num_sets = 1 ).

    "When
    cut->map_samples_to_hemisphere( i_exponent = 1 ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut->sample_hemisphere( ) ).
  ENDMETHOD.


  METHOD map_samples_to_sphere.
    "Test, that the the unit square sample points are being mapped to a sphere

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1
      i_num_sets = 1 ).

    "When
    cut->map_samples_to_sphere( ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut->sample_sphere( ) ).
  ENDMETHOD.


  METHOD map_samples_to_unit_disk.
    "Test, that the the unit square sample points are being mapped to a unit disk

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1
      i_num_sets = 1 ).
    cut->prepare_map_samples2unit_disk( ).

    "When
    cut->map_samples_to_unit_disk( ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut->sample_unit_disk( ) ).
  ENDMETHOD.


  METHOD shuffle_x_coordinates.
    "Test, that shuffling the x values around works

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1000
      i_num_sets = 1 ).

    "When
    cut->shuffle_x_coordinates( ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sample_one_set( )->x <> 1 ) ).
  ENDMETHOD.


  METHOD shuffle_y_coordinates.
    "Test, that shuffling the y values around works

    "Given
    DATA(cut) = NEW lcl_dummy(
      i_num_samples = 1000
      i_num_sets = 1 ).

    "When
    cut->shuffle_y_coordinates( ).

    "Then
    cl_abap_unit_assert=>assert_true( xsdbool( cut->sample_one_set( )->y <> 1 ) ).
  ENDMETHOD.
ENDCLASS.
