CLASS zcx_art_bitmap DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      if_t100_dyn_msg,
      if_t100_message.


    CONSTANTS:
      BEGIN OF more_pixels_than_added,
        msgid TYPE symsgid VALUE 'ZART_BITMAP',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF more_pixels_than_added.


    METHODS:
      constructor
        IMPORTING
          i_textid   LIKE if_t100_message=>t100key OPTIONAL
          i_previous LIKE previous OPTIONAL.

ENDCLASS.



CLASS zcx_art_bitmap IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = i_previous ).

    CLEAR me->textid.

    IF i_textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = i_textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
