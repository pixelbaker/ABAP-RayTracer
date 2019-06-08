CLASS zcl_art_hammersley DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_hammersley,

      new_by_num_samples
        IMPORTING
          i_num_samples     TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_hammersley,

      new_copy
        IMPORTING
          i_hammersley      TYPE REF TO zcl_art_hammersley
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_hammersley.


  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_hammersley  TYPE REF TO zcl_art_hammersley OPTIONAL,

      phi
        IMPORTING
          i_j          TYPE int4
        RETURNING
          VALUE(r_phi) TYPE decfloat16.


ENDCLASS.



CLASS zcl_art_hammersley IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_sampler = i_hammersley ).

    generate_samples( ).
  ENDMETHOD.


  METHOD generate_samples.
    DATA j TYPE int4.
    DATA p TYPE int4.

    WHILE p < _num_sets.
      j = 0.
      WHILE j < _num_samples.
        APPEND NEW zcl_art_point2d(
                     i_x = ( CONV decfloat16( j ) /
                             CONV decfloat16( _num_samples ) )
                     i_y = phi( j ) ) TO _samples.

        ADD 1 TO j.
      ENDWHILE.
      ADD 1 TO p.
    ENDWHILE.
  ENDMETHOD.


  METHOD new_by_num_samples.
    r_instance = NEW #( i_num_samples = i_num_samples ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #( i_hammersley = i_hammersley ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.


  METHOD phi.
    DATA:
      x TYPE decfloat16 VALUE '0.0',
      f TYPE decfloat16 VALUE '0.5'.

    DATA(j) = CONV decfloat16( i_j ).

    WHILE j >= 1.
      x = x + f * ( CONV int4( j ) MOD 2 ).
      j = trunc( j / '2.0' ).
      f = f * '.5'.
    ENDWHILE.

    r_phi = x.
  ENDMETHOD.
ENDCLASS.
