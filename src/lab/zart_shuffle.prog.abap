*&---------------------------------------------------------------------*
*& Report zart_shuffle
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zart_shuffle.

DATA:
  itab TYPE STANDARD TABLE OF int4 WITH DEFAULT KEY.

DO 83 TIMES.
  APPEND sy-index TO itab.
ENDDO.

NEW zcl_art_random_shuffle( )->random_shuffle(
  CHANGING
    c_itab = itab
).

cl_demo_output=>display( itab ).
