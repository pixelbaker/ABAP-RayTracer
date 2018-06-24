CLASS zcl_art_math DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CLASS-METHODS:
      composite_inverse_transform
        IMPORTING
          i_rotate_around_line TYPE REF TO zcl_art_vector3d
          i_u                  TYPE REF TO zcl_art_vector3d
          i_v                  TYPE REF TO zcl_art_vector3d
          i_w                  TYPE REF TO zcl_art_vector3d
          i_angle              TYPE decfloat16
        RETURNING
          VALUE(r_matrix)      TYPE REF TO zcl_art_matrix.

ENDCLASS.



CLASS zcl_art_math IMPLEMENTATION.


  METHOD composite_inverse_transform.
    DATA(t) = NEW zcl_art_matrix( ).
    t->matrix[ 1 ][ 4 ] = i_rotate_around_line->x.
    t->matrix[ 2 ][ 4 ] = i_rotate_around_line->y.
    t->matrix[ 3 ][ 4 ] = i_rotate_around_line->z.

    DATA(rt) = NEW zcl_art_matrix( ).
    rt->matrix[ 1 ][ 1 ] = i_u->x.
    rt->matrix[ 2 ][ 1 ] = i_u->y.
    rt->matrix[ 3 ][ 1 ] = i_u->z.
    rt->matrix[ 1 ][ 2 ] = i_v->x.
    rt->matrix[ 2 ][ 2 ] = i_v->y.
    rt->matrix[ 3 ][ 2 ] = i_v->z.
    rt->matrix[ 1 ][ 3 ] = i_w->x.
    rt->matrix[ 2 ][ 3 ] = i_w->y.
    rt->matrix[ 3 ][ 3 ] = i_w->z.

    DATA(rz) = NEW zcl_art_matrix( ).
    DATA(angle) = CONV float( i_angle * zcl_art_constants=>pi_on_180 ).
    DATA dummy TYPE float.

    dummy = cos( angle ).       rz->matrix[ 1 ][ 1 ] = dummy.
    dummy = sin( angle ).       rz->matrix[ 1 ][ 2 ] = dummy.
    dummy = -1 * sin( angle ).  rz->matrix[ 2 ][ 1 ] = dummy.
    dummy = cos( angle ).       rz->matrix[ 2 ][ 2 ] = dummy.

    DATA(r) = NEW zcl_art_matrix( ).
    r->matrix[ 1 ][ 1 ] = i_u->x.
    r->matrix[ 1 ][ 2 ] = i_u->y.
    r->matrix[ 1 ][ 3 ] = i_u->z.
    r->matrix[ 2 ][ 1 ] = i_v->x.
    r->matrix[ 2 ][ 2 ] = i_v->y.
    r->matrix[ 2 ][ 3 ] = i_v->z.
    r->matrix[ 3 ][ 1 ] = i_w->x.
    r->matrix[ 3 ][ 2 ] = i_w->y.
    r->matrix[ 3 ][ 3 ] = i_w->z.

    DATA(t_back) = NEW zcl_art_matrix( ).
    t_back->matrix[ 1 ][ 4 ] = -1 * i_rotate_around_line->x.
    t_back->matrix[ 2 ][ 4 ] = -1 * i_rotate_around_line->y.
    t_back->matrix[ 3 ][ 4 ] = -1 * i_rotate_around_line->z.

    r_matrix = t->get_product_by_matrix( rt ).
    r_matrix = r_matrix->get_product_by_matrix( rz ).
    r_matrix = r_matrix->get_product_by_matrix( r ).
    r_matrix = r_matrix->get_product_by_matrix( t_back ).
  ENDMETHOD.
ENDCLASS.
