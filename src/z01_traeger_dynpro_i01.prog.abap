*----------------------------------------------------------------------*
***INCLUDE Z01_TRAEGER_DYNPRO_I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
 case ok_code.
   when 'CANCEL' or 'EXIT'.
     leave program.
   when 'BACK'.
     leave to SCREEN 0.
 endcase.
ENDMODULE.