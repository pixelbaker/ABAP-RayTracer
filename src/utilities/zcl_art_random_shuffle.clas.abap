CLASS zcl_art_random_shuffle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      random_shuffle
        CHANGING
          c_itab TYPE STANDARD TABLE,

      swap
        IMPORTING
          i_index1 TYPE int4
          i_index2 TYPE int4
        CHANGING
          c_itab   TYPE STANDARD TABLE.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_random_shuffle IMPLEMENTATION.


  METHOD random_shuffle.
    "Converted from:
    "http://en.cppreference.com/w/cpp/algorithm/random_shuffle
    "First Version


    CHECK lines( c_itab ) > 0.

    DATA(rand) = cl_abap_random_int=>create(
      seed = cl_abap_random=>seed( )
      min = 0 ).

    DATA(num_lines) = lines( c_itab ).
    DO num_lines TIMES.
      DATA(idx) = num_lines + 1 - sy-index.
      swap(
        EXPORTING
          i_index1 = idx
          i_index2 = ( rand->get_next( ) MOD idx ) + 1
        CHANGING
          c_itab = c_itab ).
    ENDDO.
  ENDMETHOD.


  METHOD swap.
    ASSERT i_index1 BETWEEN 1 AND lines( c_itab ) AND
           i_index2 BETWEEN 1 AND lines( c_itab ).

    CHECK i_index1 <> i_index2.

    FIELD-SYMBOLS <temp> TYPE any.

    DATA dref TYPE REF TO data.
    CREATE DATA dref LIKE LINE OF c_itab.
    ASSIGN dref->* TO <temp>.

    <temp> = c_itab[ i_index1 ].
    c_itab[ i_index1 ] = c_itab[ i_index2 ].
    c_itab[ i_index2 ] = <temp>.

    CLEAR dref.
  ENDMETHOD.
ENDCLASS.
