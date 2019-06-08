CLASS zcl_art_multijittered DEFINITION
  PUBLIC
  INHERITING FROM zcl_art_sampler
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-METHODS:
      new_default
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_multijittered,

      new_by_num_samples
        IMPORTING
          i_num_samples     TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_multijittered,

      new_by_num_samples_and_sets
        IMPORTING
          i_num_samples     TYPE int4
          i_num_sets        TYPE int4
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_multijittered,

      new_copy
        IMPORTING
          i_multijittered   TYPE REF TO zcl_art_multijittered
        RETURNING
          VALUE(r_instance) TYPE REF TO zcl_art_multijittered.


  PROTECTED SECTION.
    METHODS:
      generate_samples REDEFINITION.


  PRIVATE SECTION.
    METHODS:
      constructor
        IMPORTING
          i_num_samples   TYPE int4 OPTIONAL
          i_num_sets      TYPE int4 OPTIONAL
          i_multijittered TYPE REF TO zcl_art_multijittered OPTIONAL,

      distribute_initial_pattern
        IMPORTING
          i_n TYPE int4,

      shuffle_x_coordinates_mj
        IMPORTING
          i_n TYPE int4,

      shuffle_y_coordinates_mj
        IMPORTING
          i_n TYPE int4.

ENDCLASS.



CLASS zcl_art_multijittered IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      i_num_samples = i_num_samples
      i_num_sets = i_num_sets
      i_sampler = i_multijittered ).

    generate_samples( ).
  ENDMETHOD.


  METHOD generate_samples.
    "This is based on code in Chui et al. (1994), cited in the references of the book

    "_num_samples needs to be a perfect square
    DATA(n) = CONV int4( sqrt( _num_samples ) ).

    "Fill the samples array with dummy points to allow us to use the [ ] notation when we set the initial patterns
    DO _num_samples * _num_sets TIMES.
      APPEND NEW zcl_art_point2d( ) TO _samples.
    ENDDO.

    distribute_initial_pattern( n ).
    shuffle_x_coordinates_mj( n ).
    shuffle_y_coordinates_mj( n ).
  ENDMETHOD.

  METHOD distribute_initial_pattern.
    DATA:
      p TYPE int4,
      q TYPE int4,
      j TYPE int4.

    DATA(subcell_width) = '1.0' / CONV decfloat16( _num_samples ).
    DATA(rand) = cl_abap_random_decfloat16=>create( seed = cl_abap_random=>seed( ) ).

    p = 0.
    WHILE p < _num_sets.
      q = 0.
      WHILE q < i_n.
        j = 0.
        WHILE j < i_n.
          _samples[ ( q * i_n + j + p * _num_samples ) + 1 ]->x =
            ( q * i_n + j ) * subcell_width + ( subcell_width * rand->get_next( ) ).
          _samples[ ( q * i_n + j + p * _num_samples ) + 1 ]->y =
            ( j * i_n + q ) * subcell_width + ( subcell_width * rand->get_next( ) ).

          ADD 1 TO j.
        ENDWHILE.
        ADD 1 TO q.
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
    r_instance = NEW #( i_multijittered = i_multijittered ).
  ENDMETHOD.


  METHOD new_default.
    r_instance = NEW #( ).
  ENDMETHOD.


  METHOD shuffle_x_coordinates_mj.
    DATA:
      p    TYPE int4,
      q    TYPE int4,
      j    TYPE int4,
      k    TYPE int4,
      temp TYPE decfloat16.


    DATA(n) = i_n.

    p = 0.
    WHILE p < _num_sets.
      q = 0.
      WHILE q < n.
        j = 0.
        WHILE j < n.
          k = cl_abap_random_int=>create(
            seed = cl_abap_random=>seed( )
            min = j
            max = ( n - 1 ) )->get_next( ).
          temp = _samples[ ( q * n + j + p * _num_samples ) + 1 ]->x.
          _samples[ ( q * n + j + p * _num_samples ) + 1 ]->x = _samples[ ( q * n + k + p * _num_samples ) + 1 ]->x.
          _samples[ ( q * n + k + p * _num_samples ) + 1 ]->x = temp.
          ADD 1 TO j.
        ENDWHILE.
        ADD 1 TO q.
      ENDWHILE.
      ADD 1 TO p.
    ENDWHILE.
  ENDMETHOD.


  METHOD shuffle_y_coordinates_mj.
    DATA:
      p    TYPE int4,
      q    TYPE int4,
      j    TYPE int4,
      k    TYPE int4,
      temp TYPE decfloat16.

    DATA(rand) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( ) min = 0 ).

    DATA(n) = i_n.

    p = 0.
    WHILE p < _num_sets.
      q = 0.
      WHILE q < n.
        j = 0.
        WHILE j < n.
          k = cl_abap_random_int=>create(
            seed = cl_abap_random=>seed( )
            min = j
            max = ( n - 1 ) )->get_next( ).
          temp = _samples[ ( j * n + q + p * _num_samples ) + 1 ]->y.
          _samples[ ( j * n + q + p * _num_samples ) + 1 ]->y = _samples[ ( k * n + q + p * _num_samples ) + 1 ]->y.
          _samples[ ( k * n + q + p * _num_samples ) + 1 ]->y = temp.
          ADD 1 TO j.
        ENDWHILE.
        ADD 1 TO q.
      ENDWHILE.
      ADD 1 TO p.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
