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

      "! operator*
      "! Multiplication of two matrices
      "!
      "! @parameter i_matrix | <p class="shorttext synchronized" lang="en"></p>
      "! @parameter r_matrix | <p class="shorttext synchronized" lang="en"></p>
      get_product_by_matrix
        IMPORTING
          i_matrix        TYPE REF TO zcl_art_matrix
        RETURNING
          VALUE(r_matrix) TYPE REF TO zcl_art_matrix,

      "! operator/
      "! Division by a double
      "! Pretty strange, the C++ code applies the division to the itself and then returns a copy of itself
      "!
      "! @parameter i_value | <p class="shorttext synchronized" lang="en"></p>
      "! @parameter r_matrix | <p class="shorttext synchronized" lang="en"></p>
      get_quotient_by_decfloat
        IMPORTING
          i_value         TYPE decfloat16
        RETURNING
          VALUE(r_matrix) TYPE REF TO zcl_art_matrix,


      "! Set to the identity matrix
      set_identity.


ENDCLASS.



CLASS zcl_art_matrix IMPLEMENTATION.


  METHOD assignment.
    r_matrix = me.
    ASSERT i_matrix IS BOUND.
    CHECK me <> i_matrix.

    me->matrix = VALUE rows( FOR i = 1 UNTIL i > 4 (
                   VALUE columns( FOR j = 1 UNTIL j > 4
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


  METHOD get_product_by_matrix.
    r_matrix = NEW #( ).
    DATA thesum TYPE decfloat16.

    DO 4 TIMES.
      DATA(y) = sy-index.
      DO 4 TIMES.
        DATA(x) = sy-index.
        thesum = '0.0'.

        DO 4 TIMES.
          DATA(j) = sy-index.
          thesum = thesum + me->matrix[ x ][ j ] * i_matrix->matrix[ j ][ y ].
        ENDDO.

        r_matrix->matrix[ x ][ y ] = thesum.
      ENDDO.
    ENDDO.
  ENDMETHOD.


  METHOD get_quotient_by_decfloat.
    DO 4 TIMES.
      DATA(x) = sy-index.
      DO 4 TIMES.
        DATA(y) = sy-index.

        me->matrix[ x ][ y ] = me->matrix[ x ][ y ] / i_value.
      ENDDO.
    ENDDO.

    r_matrix = NEW #( i_matrix = me ).
  ENDMETHOD.


  METHOD set_identity.
    me->matrix = VALUE rows( FOR i = 1 UNTIL i > 4 (
                   VALUE columns( FOR j = 1 UNTIL j > 4
                     ( COND #( WHEN i = j THEN 1 ELSE 0 ) ) ) ) ).
  ENDMETHOD.
ENDCLASS.
