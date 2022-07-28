*&---------------------------------------------------------------------*
*& Report Z01_BP_SSCRFIELDS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_bp_sscrfields.
DATA: pernr TYPE persno.
DATA gv_carrid TYPE scarr-carrid.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE title.

PARAMETERS: pa_bukrs TYPE pa0001-bukrs.
SELECT-OPTIONS: so_pernr FOR pernr.
SELECT-OPTIONS so_car FOR gv_carrid.

TYPES: ty_it_screen TYPE STANDARD TABLE OF screen WITH DEFAULT KEY.
DATA: it_screen TYPE ty_it_screen.

SELECTION-SCREEN END OF BLOCK b1.

INITIALIZATION.

  title = 'Testblock'.

* SCREEN-Felder auslesen
  LOOP AT SCREEN INTO DATA(lv_screen).
    APPEND lv_screen TO it_screen.
  ENDLOOP.

  %_pa_bukrs_%_app_%-text = 'Par'.
  %_so_pernr_%_app_%-text = 'SelOpt'.

START-OF-SELECTION.
*SSCRFIELDS-UCOMM
*TITLE
*%_PA_BUKRS_%_APP_%-TEXT
*PA_BUKRS
*%_SO_PERNR_%_APP_%-TEXT
*%_SO_PERNR_%_APP_%-OPTI_PUSH
*SO_PERNR-LOW
*%_SO_PERNR_%_APP_%-TO_TEXT
*SO_PERNR-HIGH
*%_SO_PERNR_%_APP_%-VALU_PUSH
*%_17SNS0000194656_%_%_%_%_%_%_

* SCREEN-Felder ausgeben
  cl_demo_output=>display_data( it_screen ).
