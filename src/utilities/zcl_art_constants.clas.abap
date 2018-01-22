CLASS zcl_art_constants DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS:
      pi           TYPE decfloat16 VALUE '3.1415926535897932384',
      two_pi       TYPE decfloat16 VALUE '6.2831853071795864769',
      pi_on_180    TYPE decfloat16 VALUE '0.0174532925199432957',
      inv_pi       TYPE decfloat16 VALUE '0.3183098861837906715',
      inv_two_pi   TYPE decfloat16 VALUE '0.1591549430918953358',

      k_epsilon    TYPE decfloat16 VALUE '0.0001',
      k_huge_value TYPE decfloat16 VALUE '1.0E10'.

ENDCLASS.



CLASS zcl_art_constants IMPLEMENTATION.
ENDCLASS.
