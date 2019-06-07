CLASS lcl_dummy DEFINITION
  INHERITING FROM zcl_art_geometric_object
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      hit REDEFINITION.

ENDCLASS.

CLASS lcl_dummy IMPLEMENTATION.
  METHOD hit.
  ENDMETHOD.
ENDCLASS.



CLASS ucl_art_geometric_object DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO zcl_art_geometric_object.


    METHODS:
      constructor1 FOR TESTING,
      constructor2 FOR TESTING,

      set_color_by_color1 FOR TESTING,
      set_color_by_components1 FOR TESTING.

ENDCLASS.


CLASS ucl_art_geometric_object IMPLEMENTATION.
  METHOD constructor1.
    "Test, that the default constructor works.

    "When
    DATA(cut) = NEW lcl_dummy( ).

    "Then
    cl_abap_unit_assert=>assert_bound( cut->get_color( ) ).
  ENDMETHOD.


  METHOD constructor2.
    "Test, that the copy constructor works.

    "Given
    DATA(dummy) = NEW lcl_dummy( ).
    dummy->set_color_by_components( i_r = 1  i_g = 0  i_b = 0 ).

    "When
    DATA(cut) = NEW lcl_dummy( i_object = dummy ).

    "Then
    DATA(color_cut) = cut->get_color( ).
    DATA(color_dummy) = dummy->get_color( ).

    cl_abap_unit_assert=>assert_bound( color_cut ).
    cl_abap_unit_assert=>assert_true( xsdbool( color_cut <> color_dummy ) ).
    cl_abap_unit_assert=>assert_equals(
      exp = 1
      act = color_cut->r ).
  ENDMETHOD.


  METHOD set_color_by_color1.
    "Test, setting a color by a color works

    "Given
    DATA(cut) = NEW lcl_dummy( ).

    "When
    cut->set_color_by_color( zcl_art_rgb_color=>new_unified( '.5' ) ).

    "Then
    DATA(result) = cut->get_color( ).
    cl_abap_unit_assert=>assert_equals(
      exp = '.5'
      act = result->r ).
  ENDMETHOD.


  METHOD set_color_by_components1.
    "Test, setting a color by individual values works

    "Given
    DATA(cut) = NEW lcl_dummy( ).

    "When
    cut->set_color_by_components( i_r = '.25'  i_g = '.5'  i_b = '.75' ).

    "Then
    DATA(result) = cut->get_color( ).
    cl_abap_unit_assert=>assert_equals( exp = '.25'  act = result->r ).
    cl_abap_unit_assert=>assert_equals( exp = '.50'  act = result->g ).
    cl_abap_unit_assert=>assert_equals( exp = '.75'  act = result->b ).
  ENDMETHOD.
ENDCLASS.
