*&---------------------------------------------------------------------*
*& Report Z01_TRAEGER_DYNPRO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_TRAEGER_DYNPRO.

data ok_code type sy-ucomm.
call screen 100.




INCLUDE z01_traeger_dynpro_o01.

INCLUDE z01_traeger_dynpro_i01.
