CLASS zcl_art_jittered DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_jittered,

      new_by_num_samples
        IMPORTING
          i_num_samples     TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_jittered,

      new_by_num_samples_and_sets
        IMPORTING
          i_num_samples     TYPE int4
          i_num_sets        TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_jittered,

      new_copy
        IMPORTING
          i_jittered        TYPE REF TO zcl_art_jittered
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_jittered.


    METHODS:
      assigment_by_jittered
        IMPORTING
          i_rhs             TYPE REF TO zcl_art_jittered
        RETURNING
          VALUE(r_jittered) TYPE REF TO zcl_art_jittered.


  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_num_sets    TYPE int4 OPTIONAL
          i_jittered    TYPE REF TO zcl_art_jittered OPTIONAL.

ENDCLASS.



CLASS zcl_art_jittered IMPLEMENTATION.


  METHOD assigment_by_jittered.
    IF me = i_rhs.
      r_jittered = me.
      RETURN.
    ENDIF.

    assignment_by_sampler( i_rhs ).

    r_jittered = me.
  ENDMETHOD.


  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_num_sets = i_num_sets
      i_sampler = i_jittered ).

    generate_samples( ).
  ENDMETHOD.


  METHOD generate_samples.

    DATA(n) = CONV int4( sqrt( _num_samples ) ).

    DATA:
      p TYPE int4,
      j TYPE int4,
      k TYPE int4.

    DATA(rand) = cl_abap_random_decfloat16=>create( seed = cl_abap_random=>seed( ) ).

    WHILE p < _num_sets.
      j = 0.

      WHILE j < n.
        k = 0.

        WHILE k < n.
          APPEND NEW zcl_art_point2d(
                       i_x = ( k + rand->get_next( ) ) / n
                       i_y = ( j + rand->get_next( ) ) / n ) TO _samples.

          ADD 1 TO k.
        ENDWHILE.

        ADD 1 TO j.
      ENDWHILE.

      ADD 1 TO p.
    ENDWHILE.
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
    r_instance = NEW #( i_jittered = i_jittered ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.
ENDCLASS.
