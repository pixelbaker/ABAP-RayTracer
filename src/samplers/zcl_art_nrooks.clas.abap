CLASS zcl_art_nrooks DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_nrooks,

      new_by_num_samples
        IMPORTING
          i_num_samples     TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_nrooks,

      new_by_num_samples_and_sets
        IMPORTING
          i_num_samples     TYPE int4
          i_num_sets        TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_nrooks,

      new_copy
        IMPORTING
          i_nrooks          TYPE REF TO zcl_art_nrooks
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_nrooks.



  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_num_sets    TYPE int4 OPTIONAL
          i_nrooks      TYPE REF TO zcl_art_nrooks OPTIONAL.

ENDCLASS.



CLASS zcl_art_nrooks IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_num_sets = i_num_sets
      i_sampler = i_nrooks ).

    generate_samples( ).
  ENDMETHOD.


  METHOD generate_samples.
    DATA:
      p TYPE int4,
      j TYPE int4.

    DATA(rand) = cl_abap_random_decfloat16=>create( seed = cl_abap_random=>seed( ) ).

    WHILE p < _num_sets.
      j = 0.

      WHILE j < _num_samples.
        DATA(sample_point) = NEW zcl_art_point2d(
          i_x = ( j + rand->get_next( ) ) / _num_samples
          i_y = ( j + rand->get_next( ) ) / _num_samples ).

        APPEND sample_point TO _samples.

        ADD 1 TO j.
      ENDWHILE.

      ADD 1 TO p.
    ENDWHILE.

    shuffle_x_coordinates( ).
    shuffle_y_coordinates( ).
  ENDMETHOD.


  METHOD new_by_num_samples.
    r_instance = NEW #( i_num_samples = i_num_samples ).
  ENDMETHOD.


  METHOD new_by_num_samples_and_sets.
    r_instance = NEW #(
      i_num_samples = i_num_samples
      i_num_sets = i_num_sets ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #( i_nrooks = i_nrooks ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.
ENDCLASS.
