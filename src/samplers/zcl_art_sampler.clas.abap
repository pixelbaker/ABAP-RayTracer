CLASS zcl_art_sampler DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
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

      set_num_sets
        IMPORTING
          i_num_sets TYPE int4,

      "Generate sample patterns in a unit square
      generate_samples ABSTRACT,

      get_num_samples
        RETURNING
          VALUE(r_num_samples) TYPE int4,

      shuffle_x_coordinates,

      shuffle_y_coordinates,

      setup_shuffled_indices,

      map_samples_to_unit_disk,

      map_samples_to_hemisphere
        IMPORTING
          i_p TYPE decfloat16,

      map_samples_to_sphere,

      "Get next sample on unit square
      sample_unit_square
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point2d,

      "Get next sample on unit disk
      sample_unit_disk
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point2d,

      "Get next sample on unit hemisphere
      sample_hemisphere
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point3d,

      "Get next sample on unit sphere
      sample_sphere
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point3d,

      "Only used to set up a vector noise table.
      "This is not discussed in the book, but see the file LatticeNoise.cpp in Chapter 31.
      sample_one_set
        RETURNING
          VALUE(r_point) TYPE REF TO zcl_art_point2d.



  PROTECTED SECTION.
    DATA:
      "The number of sample points in a set
      _num_samples        TYPE int4,

      "The number of sample sets
      _num_sets           TYPE int4,

      "Sample points on a unit square
      _samples            TYPE STANDARD TABLE OF REF TO zcl_art_point2d,

      "Shuffled samples array indices
      _shuffeled_indices  TYPE STANDARD TABLE OF int2,

      "Sample points on a unit disk
      _disk_samples       TYPE STANDARD TABLE OF REF TO zcl_art_point2d,

      "Sample points on a unit hemisphere
      _hemisphere_samples TYPE STANDARD TABLE OF REF TO zcl_art_point3d,

      "Sample points on a unit sphere
      _sphere_samples     TYPE STANDARD TABLE OF REF TO zcl_art_point3d,

      "The current number of sample points used
      _count              TYPE int8,

      "Random index jump
      _jump               TYPE int4.


  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_art_sampler IMPLEMENTATION.

  METHOD constructor.
    "Copy Constructor
    IF i_sampler IS SUPPLIED.
      ASSERT i_sampler IS BOUND.

      assignment_by_sampler(  i_sampler ).
      RETURN.
    ENDIF.


    IF i_num_samples IS SUPPLIED AND
       i_num_sets IS SUPPLIED.
      _num_samples = i_num_samples.
      _num_sets = i_num_sets.
      _count = 0.
      _jump = 0.
      setup_shuffled_indices( ).
      RETURN.
    ENDIF.


    IF i_num_samples IS SUPPLIED.
      _num_samples = i_num_samples.
      _num_sets = 83.
      _count = 0.
      _jump = 0.
      setup_shuffled_indices( ).
      RETURN.
    ENDIF.


    "Default Constructor
    _num_samples = 1.
    _num_sets = 83.
    _count = 0.
    _jump = 0.
    setup_shuffled_indices( ).
  ENDMETHOD.


  METHOD get_num_samples.
    r_num_samples = _num_samples.
  ENDMETHOD.


  METHOD map_samples_to_hemisphere.

  ENDMETHOD.


  METHOD map_samples_to_sphere.

  ENDMETHOD.


  METHOD map_samples_to_unit_disk.

  ENDMETHOD.


  METHOD sample_hemisphere.

  ENDMETHOD.


  METHOD sample_one_set.

  ENDMETHOD.


  METHOD sample_sphere.

  ENDMETHOD.


  METHOD sample_unit_disk.

  ENDMETHOD.


  METHOD sample_unit_square.

  ENDMETHOD.


  METHOD setup_shuffled_indices.
    DATA indices LIKE _shuffeled_indices.
    DO _num_samples TIMES.
      APPEND sy-index TO indices.
    ENDDO.

    DO _num_sets TIMES.

      LOOP AT indices INTO DATA(index).
        APPEND index TO _shuffeled_indices.
      ENDLOOP.
    ENDDO.
  ENDMETHOD.


  METHOD set_num_sets.
    _num_sets = i_num_sets.
  ENDMETHOD.


  METHOD shuffle_x_coordinates.

  ENDMETHOD.


  METHOD shuffle_y_coordinates.

  ENDMETHOD.


  METHOD assignment_by_sampler.
    IF me = i_rhs.
      r_sampler = me.
      RETURN.
    ENDIF.

    _num_samples = i_rhs->_num_samples.
    _num_sets = i_rhs->_num_sets.

    _shuffeled_indices = i_rhs->_shuffeled_indices.

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

    _count = i_rhs->_count.
    _jump = i_rhs->_jump.

    r_sampler = me.
  ENDMETHOD.
ENDCLASS.
