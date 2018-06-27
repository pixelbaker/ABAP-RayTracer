CLASS zcl_art_camera DEFINITION
  PUBLIC
  CREATE PUBLIC
  ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          i_camera TYPE REF TO zcl_art_camera OPTIONAL, "Copy Constructor

      render_scene ABSTRACT
        IMPORTING
          i_world TYPE REF TO zcl_art_world,

      set_eye_by_components
        IMPORTING
          i_x TYPE decfloat16
          i_y TYPE decfloat16
          i_z TYPE decfloat16,

      set_eye_by_point
        IMPORTING
          i_point TYPE REF TO zcl_art_point3d,

      set_lookat_by_components
        IMPORTING
          i_x TYPE decfloat16
          i_y TYPE decfloat16
          i_z TYPE decfloat16,

      set_lookat_by_point
        IMPORTING
          i_point TYPE REF TO zcl_art_point3d,

      set_up_vector_by_components
        IMPORTING
          i_x TYPE decfloat16
          i_y TYPE decfloat16
          i_z TYPE decfloat16,

      set_up_vector_by_vector
        IMPORTING
          i_up TYPE REF TO zcl_art_vector3d,

      set_roll
        IMPORTING
          i_roll_angle TYPE decfloat16,

      set_yaw
        IMPORTING
          i_yaw_angle TYPE decfloat16,

      set_pitch
        IMPORTING
          i_pitch_angle TYPE decfloat16,

      set_exposure_time
        IMPORTING
          i_exposure_time TYPE decfloat16,

      "! This computes an orthornormal basis given the view point, lookat point, and up vector
      compute_uvw.


  PROTECTED SECTION.
    DATA:
      _eye           TYPE REF TO zcl_art_point3d,
      _lookat        TYPE REF TO zcl_art_point3d,

      _roll_angle    TYPE decfloat16,
      _yaw_angle     TYPE decfloat16,
      _pitch_angle   TYPE decfloat16,

      "orthonormal basis vectors
      _u             TYPE REF TO zcl_art_vector3d,
      _v             TYPE REF TO zcl_art_vector3d,
      _w             TYPE REF TO zcl_art_vector3d,

      _up            TYPE REF TO zcl_art_vector3d,

      _exposure_time TYPE decfloat16.


    METHODS:
      assignment_by_camera
        IMPORTING
          i_camera        TYPE REF TO zcl_art_camera
        RETURNING
          VALUE(r_camera) TYPE REF TO zcl_art_camera.


  PRIVATE SECTION.
    METHODS:
      rotate_around_axis
        IMPORTING
          i_transform TYPE REF TO zcl_art_matrix,

      apply_roll,

      apply_yaw,

      apply_pitch.

ENDCLASS.



CLASS zcl_art_camera IMPLEMENTATION.


  METHOD assignment_by_camera.
    ASSERT i_camera IS BOUND.
    r_camera = me.
    CHECK me <> i_camera.

    _eye            = zcl_art_point3d=>new_copy( i_camera->_eye ).
    _lookat         = zcl_art_point3d=>new_copy( i_camera->_lookat ).
    _roll_angle     = i_camera->_roll_angle.
    _yaw_angle      = i_camera->_yaw_angle.
    _pitch_angle    = i_camera->_pitch_angle.
    _exposure_time  = i_camera->_exposure_time.
    _up             = zcl_art_vector3d=>new_copy( i_camera->_up ).
    _u              = zcl_art_vector3d=>new_copy( i_camera->_u ).
    _v              = zcl_art_vector3d=>new_copy( i_camera->_v ).
    _w              = zcl_art_vector3d=>new_copy( i_camera->_w ).
  ENDMETHOD.


  METHOD compute_uvw.
    _w = _eye->get_difference_from_point( _lookat ).
    _w->normalize( ).
    _u = _up->get_cross_product( _w ).
    _u->normalize( ).
    _v = _w->get_cross_product( _u ).

    apply_roll( ).
    apply_yaw( ).
    apply_pitch( ).

    "Take care of the singularity by hardwiring in specific camera orientations

    "Camera looking vertically down
    IF _eye->x = _lookat->x AND
       _eye->z = _lookat->z AND
       _eye->y > _lookat->y.
      _u = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 ).
      _v = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 ).
      _w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 ).
    ENDIF.

    "Camera looking vertically up
    IF _eye->x = _lookat->x AND
       _eye->z = _lookat->z AND
       _eye->y < _lookat->y.
      _u = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 ).
      _v = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 ).
      _w = zcl_art_vector3d=>new_individual( i_x = 0  i_y = -1  i_z = 0 ).
    ENDIF.
  ENDMETHOD.


  METHOD apply_roll.
    DATA(transform) = zcl_art_math=>rotate_about_line_in_z(
      i_u = _u
      i_v = _v
      i_w = _w
      i_angle = _roll_angle ).

    rotate_around_axis( transform ).
  ENDMETHOD.


  METHOD apply_yaw.
    DATA(transform) = zcl_art_math=>rotate_about_line_in_y(
      i_u = _u
      i_v = _v
      i_w = _w
      i_angle = _yaw_angle ).

    rotate_around_axis( transform ).
  ENDMETHOD.


  METHOD apply_pitch.
    DATA(transform) = zcl_art_math=>rotate_about_line_in_x(
      i_u = _u
      i_v = _v
      i_w = _w
      i_angle = _pitch_angle ).

    rotate_around_axis( transform ).
  ENDMETHOD.


  METHOD rotate_around_axis.
    _u = zcl_art_vector3d=>get_product_by_matrix( i_matrix = i_transform  i_vector = _u ).
    _v = zcl_art_vector3d=>get_product_by_matrix( i_matrix = i_transform  i_vector = _v ).
    _w = zcl_art_vector3d=>get_product_by_matrix( i_matrix = i_transform  i_vector = _w ).
  ENDMETHOD.


  METHOD constructor.
    "Copy Constructor
    IF i_camera IS BOUND.
      assignment_by_camera( i_camera ).
      RETURN.
    ENDIF.

    "Default Constructor
    _eye            = zcl_art_point3d=>new_individual( i_x = 0  i_y = 0  i_z = 500 ).
    _lookat         = zcl_art_point3d=>new_default( ).
    _roll_angle     = '0'.
    _yaw_angle      = '0'.
    _pitch_angle    = '0'.
    _exposure_time  = '1'.
    _up             = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 ).
    _u              = zcl_art_vector3d=>new_individual( i_x = 1  i_y = 0  i_z = 0 ).
    _v              = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 1  i_z = 0 ).
    _w              = zcl_art_vector3d=>new_individual( i_x = 0  i_y = 0  i_z = 1 ).
  ENDMETHOD.


  METHOD set_exposure_time.
    _exposure_time = i_exposure_time.
  ENDMETHOD.


  METHOD set_eye_by_components.
    _eye->x = i_x.
    _eye->y = i_y.
    _eye->z = i_z.
  ENDMETHOD.


  METHOD set_eye_by_point.
    _eye->assignment( i_point  ).
  ENDMETHOD.


  METHOD set_lookat_by_components.
    _lookat->x = i_x.
    _lookat->y = i_y.
    _lookat->z = i_z.
  ENDMETHOD.


  METHOD set_lookat_by_point.
    _lookat->assignment( i_point ).
  ENDMETHOD.


  METHOD set_roll.
    _roll_angle = i_roll_angle.
  ENDMETHOD.


  METHOD set_up_vector_by_components.
    _up->x = i_x.
    _up->y = i_y.
    _up->z = i_z.
  ENDMETHOD.


  METHOD set_up_vector_by_vector.
    _up->assignment_by_vector( i_up ).
  ENDMETHOD.


  METHOD set_pitch.
    _pitch_angle = i_pitch_angle.
  ENDMETHOD.


  METHOD set_yaw.
    _yaw_angle = i_yaw_angle.
  ENDMETHOD.

ENDCLASS.
