*&---------------------------------------------------------------------*
*&  Include           MZSCARR_ERFASSENI01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
case ok_code.
  when 'EXIT'.
    leave program.
  when 'SAVE'.
    insert scarr from scarr.
    if sy-subrc = 0.
      message 'Datensatz wurde eingefügt' type 'S'.
    else.
      "clear scarr.
      message 'Datensatz existierte bereits' type 'E'.
    endif.
  endcase.
ENDMODULE.
