CLASS zcl_art_random DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_random,

      new_by_num_samples
        IMPORTING
          i_num_samples     TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_random,

      new_copy
        IMPORTING
          i_random          TYPE REF TO zcl_art_random
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_random.


    METHODS:
      assigment_by_random
        IMPORTING
          i_rhs           TYPE REF TO zcl_art_random
        RETURNING
          VALUE(r_random) TYPE REF TO zcl_art_random.


  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_random      TYPE REF TO zcl_art_random OPTIONAL.

ENDCLASS.



CLASS ZCL_ART_RANDOM IMPLEMENTATION.


  METHOD assigment_by_random.
    IF me = i_rhs.
      r_random = me.
      RETURN.
    ENDIF.

    assignment_by_sampler( i_rhs ).

    r_random = me.
  ENDMETHOD.


  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_sampler = i_random ).

    generate_samples( ).
  ENDMETHOD.


  METHOD generate_samples.
    DATA:
      p TYPE int4,
      q TYPE int4.

    DATA(rand) = cl_abap_random_decfloat16=>create( seed = cl_abap_random=>seed( ) ).

    WHILE p < _num_sets.
      q = 0.
      WHILE q < _num_samples.
        APPEND NEW zcl_art_point2d( i_x = rand->get_next( )
                                    i_y = rand->get_next( ) ) TO _samples.

        ADD 1 TO q.
      ENDWHILE.
      ADD 1 TO p.
    ENDWHILE.
  ENDMETHOD.


  METHOD new_by_num_samples.
    r_instance = NEW #( i_num_samples = i_num_samples ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #( i_random = i_random ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.
ENDCLASS.
