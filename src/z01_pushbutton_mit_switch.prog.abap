*&---------------------------------------------------------------------*
*& Report Z01_PUSHBUTTON_MIT_SWITCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_pushbutton_mit_switch.
DATA gs_sflight TYPE sflight.

SELECT-OPTIONS so_car FOR gs_sflight-carrid MODIF ID aus.
SELECT-OPTIONS so_con FOR gs_sflight-connid MODIF ID aus.
PARAMETERS pa_chk AS CHECKBOX USER-COMMAND fc_check MODIF ID aus.
SELECTION-SCREEN PUSHBUTTON /50(20) gv_txt USER-COMMAND fc_push.

INITIALIZATION.
  gv_txt =  'Details einblenden'.

AT SELECTION-SCREEN OUTPUT.
  "Kopie der statischen Attribute des Bildschirms in die systemtabelle SCREEN
  IF gv_txt = 'Details einblenden'.
  "IF so_car-low = 'AZ'.
    LOOP AT SCREEN INTO screen.
*      IF   screen-name CS 'SO_CAR'
*        or screen-name cs 'SO_CON'
*        or screen-name cs 'PA_CHK'.
      if screen-group1 = 'AUS'.
        screen-active = 0.
        "screen-value_help = 0.
*        screen-output = 0.
*        screen-invisible = 1.
        MODIFY screen FROM screen.
      ENDIF.
    ENDLOOP.

  ENDIF.


AT SELECTION-SCREEN.
  CASE sy-ucomm.
    WHEN 'FC_PUSH'.
      IF gv_txt = 'Details einblenden'.
        gv_txt = 'Details ausblenden'.
      ELSE.
        gv_txt = 'Details einblenden'.
      ENDIF.
    when 'FC_CHECK'.
      message 'Ceckbox wurde geändert' type 'I'.
  ENDCASE.
