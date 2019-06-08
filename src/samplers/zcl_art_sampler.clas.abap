"! Sampler Base Class. All samples must inherit from this beauty
CLASS zcl_art_sampler DEFINITION
  PUBLIC
  ABSTRACT.

  PUBLIC SECTION.
    METHODS:
      "! Supports the following constructors:
      "! <ul>
      "! <li>Copy Constructor</li>
      "! <li>Default Constructor</li>
      "! <li>Constructor with num_samples/num_sets</li>
      "! <li>Constructor with num_samples</li>
      "! </ul>
      constructor
        IMPORTING
          i_num_samples TYPE int4 OPTIONAL
          i_num_sets    TYPE int4 OPTIONAL
          i_sampler     TYPE REF TO zcl_art_sampler OPTIONAL, "Copy Constructor

      assignment_by_sampler
        IMPORTING
          i_rhs            TYPE REF TO zcl_art_sampler
        RETURNING
          VALUE(r_sampler) TYPE REF TO zcl_art_sampler,

      get_num_samples
        RETURNING
          VALUE(r_num_samples) TYPE int4,

      shuffle_x_coordinates,

      shuffle_y_coordinates,

      setup_shuffled_indices,

      "! Maps the 2D sample points in the square [-1,1] X [-1,1] to a unit disk,
      "! using Peter Shirley's concentric map function.
      map_samples_to_unit_disk,


      "! Maps the 2D sample points to 3D points on a unit hemisphere
      "! with a cosine power density distribution in the polar angle
      map_samples_to_hemisphere
        IMPORTING
          i_exponent TYPE decfloat16,


      "! Maps the 2D sample points to 3D points on a unit sphere
      "! with a uniform density distribution over the surface this is used for modeling a spherical light
      map_samples_to_sphere,


      "! Get next sample on unit square
      sample_unit_square
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point2d,


      "! Get next sample on unit disk
      sample_unit_disk
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point2d,


      "! Get next sample on unit hemisphere
      sample_hemisphere
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point3d,


      "! Get next sample on unit sphere
      sample_sphere
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point3d,


      "! Only used to set up a vector noise table.
      "! This is not discussed in the book, but see the file LatticeNoise.cpp in Chapter 31.<br/>
      "! This is a specialized function called in LatticeNoise::init_vector_table
      "! It doesn't shuffle the indices
      sample_one_set
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point2d.


  PROTECTED SECTION.
    DATA:
      "The number of sample points in a set
      _num_samples        TYPE int4,

      "The number of sample sets
      _num_sets           TYPE int4,

      "Shuffled samples array indices for faster access
      _shuffeled_indices  TYPE STANDARD TABLE OF int2,

      "Sample points on a unit square
      _samples            TYPE STANDARD TABLE OF REF TO zcl_art_point2d,

      "Sample points on a unit disk
      _disk_samples       TYPE STANDARD TABLE OF REF TO zcl_art_point2d,

      "Sample points on a unit sphere
      _sphere_samples     TYPE STANDARD TABLE OF REF TO zcl_art_point3d,

      "Sample points on a unit hemisphere
      _hemisphere_samples TYPE STANDARD TABLE OF REF TO zcl_art_point3d,

      "The current number of sample points used
      _count              TYPE int8,

      "Random index jump
      _jump               TYPE int4.


    METHODS:
      "! Generate sample patterns in a unit square [0..1]x[0..1](x[0..1])
      generate_samples ABSTRACT.

ENDCLASS.



CLASS zcl_art_sampler IMPLEMENTATION.


  METHOD assignment_by_sampler.
    ASSERT i_rhs IS BOUND.
    r_sampler = me.
    CHECK me <> i_rhs.

    _num_samples = i_rhs->_num_samples.
    _num_sets = i_rhs->_num_sets.
    _count = i_rhs->_count.
    _jump = i_rhs->_jump.

    LOOP AT i_rhs->_shuffeled_indices INTO DATA(shuffled_index).
      APPEND shuffled_index TO _shuffeled_indices.
    ENDLOOP.

    LOOP AT i_rhs->_samples INTO DATA(sample).
      SYSTEM-CALL OBJMGR CLONE sample TO sample.
      APPEND sample TO _samples.
    ENDLOOP.

    LOOP AT i_rhs->_disk_samples INTO DATA(disk_sample).
      SYSTEM-CALL OBJMGR CLONE disk_sample TO disk_sample.
      APPEND disk_sample TO _disk_samples.
    ENDLOOP.

    LOOP AT i_rhs->_hemisphere_samples INTO DATA(hemisphere_sample).
      SYSTEM-CALL OBJMGR CLONE hemisphere_sample TO hemisphere_sample.
      APPEND hemisphere_sample TO _hemisphere_samples.
    ENDLOOP.

    LOOP AT i_rhs->_sphere_samples INTO DATA(sphere_sample).
      SYSTEM-CALL OBJMGR CLONE sphere_sample TO sphere_sample.
      APPEND sphere_sample TO _sphere_samples.
    ENDLOOP.
  ENDMETHOD.


  METHOD constructor.
    "Copy Constructor
    IF i_sampler IS BOUND.
      assignment_by_sampler( i_sampler ).
      RETURN.
    ENDIF.


    "num_samples/num_set Constructor
    IF i_num_samples > 0 AND
       i_num_sets > 0.
      _num_samples = i_num_samples.
      _num_sets = i_num_sets.
      _count = 0.
      _jump = 1.
      setup_shuffled_indices( ).
      RETURN.
    ENDIF.


    "num_samples Constructor
    IF i_num_samples > 0.
      _num_samples = i_num_samples.
      _num_sets = 83.
      _count = 0.
      _jump = 1.
      setup_shuffled_indices( ).
      RETURN.
    ENDIF.


    "Default Constructor
    _num_samples = 1.
    _num_sets = 83.
    _count = 0.
    _jump = 1.
    setup_shuffled_indices( ).
  ENDMETHOD.


  METHOD get_num_samples.
    r_num_samples = _num_samples.
  ENDMETHOD.


  METHOD map_samples_to_hemisphere.
    CLEAR _hemisphere_samples.

    DATA(exponent) = 1 / ( i_exponent + 1 ).

    DO lines( _samples ) TIMES.
      DATA(cos_phi) = cos( CONV float( zcl_art_constants=>two_pi * _samples[ sy-index ]->x ) ).
      DATA(sin_phi) = sin( CONV float( zcl_art_constants=>two_pi * _samples[ sy-index ]->x ) ).
      DATA(cos_theta) = ( 1 - _samples[ sy-index ]->y ) ** exponent.
      DATA(sin_theta) = sqrt( 1 - cos_theta * cos_theta ).
      DATA(pu) = sin_theta * cos_phi.
      DATA(pv) = sin_theta * sin_phi.
      DATA(pw) = cos_theta.
      APPEND zcl_art_point3d=>new_individual( i_x = pu
                                              i_y = pv
                                              i_z = pw ) TO _hemisphere_samples.
    ENDDO.
  ENDMETHOD.


  METHOD map_samples_to_sphere.
    DATA phi TYPE float.
    DATA r TYPE float.

    DO _num_samples * _num_sets TIMES.
      DATA(r1) = _samples[ sy-index ]->x.
      DATA(r2) = _samples[ sy-index ]->y.
      DATA(z) = '1.0' - '2.0' * r1.
      r = sqrt( '1.0' - z * z ).
      phi = zcl_art_constants=>two_pi * r2.
      DATA(x) = r * cos( phi ).
      DATA(y) = r * sin( phi ).
      APPEND zcl_art_point3d=>new_individual( i_x = CONV #( x )
                                              i_y = CONV #( y )
                                              i_z = z ) TO _sphere_samples.
    ENDDO.
  ENDMETHOD.


  METHOD map_samples_to_unit_disk.
    "polar coordinates
    DATA r TYPE float.
    DATA phi TYPE float.

    "Sample point on unit disk
    DATA(sp) = NEW zcl_art_point2d( ).

    DO lines( _samples ) TIMES.
      "map sample point to [-1, 1] X [-1,1]
      sp->x = '2.0' * _samples[ sy-index ]->x - '1.0'.
      sp->y = '2.0' * _samples[ sy-index ]->y - '1.0'.

      IF sp->x > ( -1 * sp->y ). "Sectors 1 and 2
        IF sp->x > sp->y. "Sector 1
          r = sp->x.
          phi = sp->y / sp->x.
        ELSE. "Sector 2
          r = sp->y.
          phi = '2.0' - sp->x / sp->y.
        ENDIF.
      ELSE. "Sectors 3 and 4
        IF sp->x < sp->y. "Sector 3
          r = -1 * sp->x.
          phi = '4.0' + sp->y / sp->x.
        ELSE. "Sector 4
          r = -1 * sp->y.
          IF sp->y <> '0.0'. "Avoid division by zero at origin
            phi = '6.0' - sp->x / sp->y.
          ELSE.
            phi = '0.0'.
          ENDIF.
        ENDIF.
      ENDIF.

      phi = phi * ( zcl_art_constants=>pi / '4.0' ).

      DATA(x) = r * cos( phi ).
      DATA(y) = r * sin( phi ).

      APPEND NEW zcl_art_point2d( i_x = CONV #( x )
                                  i_y = CONV #( y ) ) TO _disk_samples.
    ENDDO.

    CLEAR _samples.
  ENDMETHOD.


  METHOD sample_hemisphere.
    IF _count MOD _num_samples = 0. "Start of a new pixel
      _jump = ( cl_abap_random_int=>create( seed = cl_abap_random=>seed( ) min = 0 )->get_next( ) MOD _num_sets ) * _num_samples.
    ENDIF.

    r_point = _hemisphere_samples[ _jump + _shuffeled_indices[ _jump + _count MOD _num_samples + 1 ] ].
    ADD 1 TO _count.
  ENDMETHOD.


  METHOD sample_one_set.
    r_point = _samples[ _count MOD _num_samples + 1 ].
    ADD 1 TO _count.
  ENDMETHOD.


  METHOD sample_sphere.
    IF _count MOD _num_samples = 0. "Start of a new pixel
      _jump = ( cl_abap_random_int=>create( seed = cl_abap_random=>seed( )  min = 0 )->get_next( ) MOD _num_sets ) * _num_samples.
    ENDIF.

    r_point = _sphere_samples[ _jump + _shuffeled_indices[ _jump + _count MOD _num_samples + 1 ] ].
    ADD 1 TO _count.
  ENDMETHOD.


  METHOD sample_unit_disk.
    IF _count MOD _num_samples = 0. "Start of a new pixel
      _jump = ( cl_abap_random_int=>create( seed = cl_abap_random=>seed( )  min = 0 )->get_next( ) MOD _num_sets ) * _num_samples.
    ENDIF.

    r_point = _disk_samples[ _jump + _shuffeled_indices[ _jump + _count MOD _num_samples + 1 ] ].
    ADD 1 TO _count.
  ENDMETHOD.


  METHOD sample_unit_square.
    IF _count MOD _num_samples = 0. "Start of a new pixel
      _jump = ( cl_abap_random_int=>create( seed = cl_abap_random=>seed( )  min = 0 )->get_next( ) MOD _num_sets ) * _num_samples.
    ENDIF.

    r_point = _samples[ _jump + _shuffeled_indices[ _jump + _count MOD _num_samples + 1 ] ].
    ADD 1 TO _count.
  ENDMETHOD.


  METHOD setup_shuffled_indices.
    DATA indices LIKE _shuffeled_indices.
    DO _num_samples TIMES.
      APPEND sy-index TO indices.
    ENDDO.

    DATA(shuffler) = NEW zcl_art_random_shuffle( ).

    DO _num_sets TIMES.
      shuffler->random_shuffle( CHANGING c_itab = indices ).
      APPEND LINES OF indices TO _shuffeled_indices.
    ENDDO.
  ENDMETHOD.


  METHOD shuffle_x_coordinates.
    DATA:
      p      TYPE int4,
      q      TYPE int4,
      target TYPE int4,
      temp   TYPE decfloat16.

    DATA(rand) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )  min = 0 ).

    WHILE p < _num_sets.
      q = 0.
      WHILE q < _num_samples.
        target = rand->get_next( ) MOD _num_samples + 1 + p * _num_samples.
        temp = _samples[ q + p * _num_samples + 1 ]->x.
        _samples[ q + p * _num_samples + 1 ]->x = _samples[ target ]->x.
        _samples[ target ]->x = temp.
        ADD 1 TO q.
      ENDWHILE.
      ADD 1 TO p.
    ENDWHILE.
  ENDMETHOD.


  METHOD shuffle_y_coordinates.
    DATA:
      p      TYPE int4,
      q      TYPE int4,
      target TYPE int4,
      temp   TYPE decfloat16.

    DATA(rand) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( ) min = 0 ).

    WHILE p < _num_sets.
      q = 0.
      WHILE q < _num_samples.
        target = rand->get_next( ) MOD _num_samples + 1 + p * _num_samples.
        temp = _samples[ q + p * _num_samples + 1 ]->y.
        _samples[ q + p * _num_samples + 1 ]->y = _samples[ target ]->y.
        _samples[ target ]->y = temp.
        ADD 1 TO q.
      ENDWHILE.
      ADD 1 TO p.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
