CLASS zcl_art_regular DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_regular,

      new_by_num_samples
        IMPORTING
          i_num_samples     TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_regular,

      new_copy
        IMPORTING
          i_regular         TYPE REF TO zcl_art_regular
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_regular.


  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_regular     TYPE REF TO zcl_art_regular OPTIONAL.

ENDCLASS.



CLASS zcl_art_regular IMPLEMENTATION.


  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_sampler = i_regular ).

    generate_samples( ).
  ENDMETHOD.


  METHOD generate_samples.
    DATA(n) = CONV int4( sqrt( _num_samples ) ).

    DATA j TYPE int4.
    DATA p TYPE int4.
    DATA q TYPE int4.

    WHILE j < _num_sets.
      p = 0.
      WHILE p < n.
        q = 0.
        WHILE q <= n.
          APPEND NEW zcl_art_point2d( i_x = ( q + '0.5' ) / n
                                      i_y = ( p + '0.5' ) / n ) TO _samples.

          ADD 1 TO q.
        ENDWHILE.
        ADD 1 TO p.
      ENDWHILE.
      ADD 1 TO j.
    ENDWHILE.
  ENDMETHOD.


  METHOD new_by_num_samples.
    r_instance = NEW #( i_num_samples = i_num_samples ).
  ENDMETHOD.


  METHOD new_copy.
    r_instance = NEW #( i_regular = i_regular ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.
ENDCLASS.
