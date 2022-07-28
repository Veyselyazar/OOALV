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
   when 'CANCEL' or 'EXIT' or 'BACK'.
     leave to SCREEN 0.
   when 'EGAL'.
     go_alv_grid->free( ).
     go_container->free( ).
     clear: go_alv_grid, go_container.
 endcase.
ENDMODULE.
