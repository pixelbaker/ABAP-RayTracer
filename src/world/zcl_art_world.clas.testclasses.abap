CLASS ucl_art_world DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_world.


    METHODS:
      setup,

      first_test FOR TESTING.

ENDCLASS.


CLASS ucl_art_world IMPLEMENTATION.
  METHOD setup.
    _cut = NEW #( ).
  ENDMETHOD.


  METHOD first_test.
    "

    "Given

    "When

    "Then
  ENDMETHOD.

ENDCLASS.
