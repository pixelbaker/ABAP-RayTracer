CLASS zcl_art_matrix DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      columns TYPE STANDARD TABLE OF decfloat16 WITH EMPTY KEY,
      rows    TYPE STANDARD TABLE OF columns WITH EMPTY KEY.


    DATA:
      matrix TYPE rows.


    METHODS:
      constructor
        IMPORTING
          i_matrix TYPE REF TO zcl_art_matrix OPTIONAL, "Copy Constructor

      "! operator=
      "!
      "! @parameter i_matrix | <p class="shorttext synchronized" lang="en"></p>
      "! @parameter r_matrix | <p class="shorttext synchronized" lang="en"></p>
      assignment
        IMPORTING
          i_matrix        TYPE REF TO zcl_art_matrix
        RETURNING
          VALUE(r_matrix) TYPE REF TO zcl_art_matrix,

      get_product
        IMPORTING
          i_matrix        TYPE REF TO zcl_art_matrix
        RETURNING
          VALUE(r_matrix) TYPE REF TO zcl_art_matrix,

      set_identity.


ENDCLASS.



CLASS zcl_art_matrix IMPLEMENTATION.


  METHOD assignment.
    r_matrix = me.
    ASSERT i_matrix IS BOUND.
    CHECK me <> i_matrix.

    me->matrix = VALUE rows( FOR i = 0 UNTIL i = 4 (
                   VALUE columns( FOR j = 0 UNTIL j = 4
                     ( i_matrix->matrix[ i ][ j ] ) ) ) ).
  ENDMETHOD.


  METHOD constructor.
    "Copy Constructor
    IF i_matrix IS SUPPLIED.
      ASSERT i_matrix IS BOUND.
      assignment( i_matrix ).
      RETURN.
    ENDIF.

    "Default Constructor
    set_identity( ).
  ENDMETHOD.


  METHOD get_product.
    r_matrix = NEW #( ).

    DO 4 TIMES.
      DATA(y) = sy-index.
      DO 4 TIMES.
        DATA(x) = sy-index.
        DATA thesum TYPE decfloat16 VALUE 0.
        DO 4 TIMES.
          DATA(j) = sy-index.
          DATA(product) = me->matrix[ x ][ j ] * i_matrix->matrix[ j ][ y ].
          ADD product TO thesum.
        ENDDO.

        r_matrix->matrix[ x ][ y ] = thesum.
      ENDDO.
    ENDDO.
  ENDMETHOD.


  METHOD set_identity.
    me->matrix = VALUE rows( FOR i = 0 UNTIL i = 4 (
                   VALUE columns( FOR j = 0 UNTIL j = 4
                     ( COND #( WHEN i = j THEN 1 ELSE 0 ) ) ) ) ).
  ENDMETHOD.

ENDCLASS.
