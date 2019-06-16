CLASS lcl_dummy DEFINITION
  INHERITING FROM zcl_art_camera
  FINAL.

  PUBLIC SECTION.
    METHODS:
      render_scene REDEFINITION,

      get_u
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_vector3d,

      get_v
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_vector3d,

      get_w
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_vector3d,

      get_eye
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_point3d,

      get_lookat
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_point3d,

      get_roll_angle
        RETURNING
          VALUE(r_result) TYPE decfloat16,

      get_yaw_angle
        RETURNING
          VALUE(r_result) TYPE decfloat16,

      get_pitch_angle
        RETURNING
          VALUE(r_result) TYPE decfloat16,

      get_up
        RETURNING
          VALUE(r_result) TYPE REF TO zcl_art_vector3d,

      get_exposure_time
        RETURNING
          VALUE(r_result) TYPE decfloat16.

ENDCLASS.

CLASS lcl_dummy IMPLEMENTATION.
  METHOD render_scene.
  ENDMETHOD.

  METHOD get_exposure_time.
    r_result = _exposure_time.
  ENDMETHOD.

  METHOD get_eye.
    r_result = _eye.
  ENDMETHOD.

  METHOD get_lookat.
    r_result = _lookat.
  ENDMETHOD.

  METHOD get_pitch_angle.
    r_result = _pitch_angle.
  ENDMETHOD.

  METHOD get_roll_angle.
    r_result = _roll_angle.
  ENDMETHOD.

  METHOD get_up.
    r_result = _up.
  ENDMETHOD.

  METHOD get_yaw_angle.
    r_result = _yaw_angle.
  ENDMETHOD.

  METHOD get_u.
    r_result = _u.
  ENDMETHOD.

  METHOD get_v.
    r_result = _v.
  ENDMETHOD.

  METHOD get_w.
    r_result = _w.
  ENDMETHOD.
ENDCLASS.



CLASS ucl_art_camera DEFINITION
  FINAL
  FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      _cut TYPE REF TO lcl_dummy.


    METHODS:
      setup,

      copy_constructor FOR TESTING,

      compute_uvw1 FOR TESTING,
      compute_uvw2 FOR TESTING,

      set_lookat_by_components FOR TESTING,
      set_up_vector_by_components FOR TESTING,
      set_eye_by_components FOR TESTING,

      render_scene FOR TESTING.


ENDCLASS.


CLASS ucl_art_camera IMPLEMENTATION.
  METHOD setup.
    _cut = NEW lcl_dummy( ).
  ENDMETHOD.


  METHOD copy_constructor.
    "Test, that the copy constructor works

    "Given
    DATA(camera) = NEW lcl_dummy( ).

    camera->set_exposure_time( 2 ).

    DATA(eye) = zcl_art_point3d=>new_individual( i_x = 1  i_y = 2  i_z = 3 ).
    camera->set_eye_by_point( eye ).

    DATA(lookat) = zcl_art_point3d=>new_individual( i_x = 4  i_y = 5  i_z = 6 ).
    camera->set_lookat_by_point( lookat ).

    DATA(up) = zcl_art_vector3d=>new_individual( i_x = 7  i_y = 8  i_z = 9 ).
    camera->set_up_vector_by_vector( up ).

    camera->set_pitch( 10 ).
    camera->set_roll( 20 ).
    camera->set_yaw( 30 ).


    "When
    _cut = NEW lcl_dummy( i_camera = camera ).


    "Then
    cl_abap_unit_assert=>assert_equals( exp = 2  act = _cut->get_exposure_time( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 10  act = _cut->get_pitch_angle( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 20  act = _cut->get_roll_angle( ) ).
    cl_abap_unit_assert=>assert_equals( exp = 30  act = _cut->get_yaw_angle( ) ).

    DATA(new_eye) = _cut->get_eye( ).
    cl_abap_unit_assert=>assert_true( xsdbool( eye <> new_eye ) ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = new_eye->x ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = new_eye->y ).
    cl_abap_unit_assert=>assert_equals( exp = 3  act = new_eye->z ).

    DATA(new_lookat) = _cut->get_lookat( ).
    cl_abap_unit_assert=>assert_true( xsdbool( lookat <> new_lookat ) ).
    cl_abap_unit_assert=>assert_equals( exp = 4  act = new_lookat->x ).
    cl_abap_unit_assert=>assert_equals( exp = 5  act = new_lookat->y ).
    cl_abap_unit_assert=>assert_equals( exp = 6  act = new_lookat->z ).

    DATA(new_up) = _cut->get_up( ).
    cl_abap_unit_assert=>assert_true( xsdbool( up <> new_up ) ).
    cl_abap_unit_assert=>assert_equals( exp = 7  act = new_up->x ).
    cl_abap_unit_assert=>assert_equals( exp = 8  act = new_up->y ).
    cl_abap_unit_assert=>assert_equals( exp = 9  act = new_up->z ).
  ENDMETHOD.


  METHOD compute_uvw1.
    "Test, that a camera looking vertically down is handled

    "Given
    DATA(eye) = zcl_art_point3d=>new_individual( i_x = 1  i_y = 2  i_z = 1 ).
    _cut->set_eye_by_point( eye ).

    DATA(lookat) = zcl_art_point3d=>new_individual( i_x = 1  i_y = 1  i_z = 1 ).
    _cut->set_lookat_by_point( lookat ).


    "When
    _cut->compute_uvw( ).


    "Then
    DATA(u) = _cut->get_u( ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = u->x ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = u->y ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = u->z ).
    DATA(v) = _cut->get_v( ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = v->x ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = v->y ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = v->z ).
    DATA(w) = _cut->get_w( ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = w->x ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = w->y ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = w->z ).
  ENDMETHOD.


  METHOD compute_uvw2.
    "Test, that a camera looking vertically up is handled

    "Given
    DATA(eye) = zcl_art_point3d=>new_individual( i_x = 1  i_y = 1  i_z = 1 ).
    _cut->set_eye_by_point( eye ).

    DATA(lookat) = zcl_art_point3d=>new_individual( i_x = 1  i_y = 2  i_z = 1 ).
    _cut->set_lookat_by_point( lookat ).


    "When
    _cut->compute_uvw( ).


    "Then
    DATA(u) = _cut->get_u( ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = u->x ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = u->y ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = u->z ).
    DATA(v) = _cut->get_v( ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = v->x ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = v->y ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = v->z ).
    DATA(w) = _cut->get_w( ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = w->x ).
    cl_abap_unit_assert=>assert_equals( exp = -1  act = w->y ).
    cl_abap_unit_assert=>assert_equals( exp = 0  act = w->z ).
  ENDMETHOD.


  METHOD set_eye_by_components.
    "Test, setting the eye point by components works

    "When
    _cut->set_eye_by_components( i_x = 1  i_y = 2  i_z = 3 ).

    "Then
    DATA(eye) = _cut->get_eye( ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = eye->x ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = eye->y ).
    cl_abap_unit_assert=>assert_equals( exp = 3  act = eye->z ).
  ENDMETHOD.


  METHOD set_lookat_by_components.
    "Test, setting the lookat point by components works

    "When
    _cut->set_lookat_by_components( i_x = 1  i_y = 2  i_z = 3 ).

    "Then
    DATA(lookat) = _cut->get_lookat( ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = lookat->x ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = lookat->y ).
    cl_abap_unit_assert=>assert_equals( exp = 3  act = lookat->z ).
  ENDMETHOD.


  METHOD set_up_vector_by_components.
    "Test, setting up vector by components works

    "When
    _cut->set_up_vector_by_components( i_x = 1  i_y = 2  i_z = 3 ).

    "Then
    DATA(up) = _cut->get_up( ).
    cl_abap_unit_assert=>assert_equals( exp = 1  act = up->x ).
    cl_abap_unit_assert=>assert_equals( exp = 2  act = up->y ).
    cl_abap_unit_assert=>assert_equals( exp = 3  act = up->z ).
  ENDMETHOD.


  METHOD render_scene.
    "Just to get the 100% code coverage :)

    DATA world TYPE REF TO zcl_art_world.
    _cut->render_scene( world ).
  ENDMETHOD.
ENDCLASS.
