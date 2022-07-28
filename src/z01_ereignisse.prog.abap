*&---------------------------------------------------------------------*
*& Report Z01_EREIGNISSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_ereignisse.
DATA gv_car TYPE s_carr_id.
DATA gs_spfli TYPE spfli.
DATA gs_sflight TYPE sflight.
SELECTION-SCREEN BEGIN OF SCREEN 1100.
PARAMETERS pa_name TYPE spfli-connid.
SELECTION-SCREEN END OF SCREEN 1100.
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE gv_t1.
PARAMETERS pa_zahl TYPE i.
SELECTION-SCREEN SKIP 1.
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME.

SELECT-OPTIONS so_car FOR gv_car.
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(20) TEXT-s03.
SELECTION-SCREEN COMMENT pos_low(8) TEXT-s04 FOR FIELD pa_col.
PARAMETERS pa_col AS CHECKBOX.
SELECTION-SCREEN COMMENT pos_high(8) TEXT-s05 FOR FIELD pa_ico.
PARAMETERS pa_ico AS CHECKBOX.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b3.

SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.
SELECT-OPTIONS so_con FOR gs_spfli-connid.
SELECTION-SCREEN END OF SCREEN 1200.

SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN.
SELECT-OPTIONS so_fld FOR gs_sflight-fldate.
SELECTION-SCREEN END OF SCREEN 1300.

SELECTION-SCREEN BEGIN OF SCREEN 1400 AS SUBSCREEN.
 PARAMETERS pa_plane type saplane-planetype.
SELECTION-SCREEN END OF SCREEN 1400.

SELECTION-SCREEN begin of TABBED BLOCK tabstrip for 10 lines.
 SELECTION-SCREEN tab (20) tab1 USER-COMMAND fc1 DEFAULT SCREEN 1200.
 SELECTION-SCREEN tab (20) tab2 USER-COMMAND fc2 DEFAULT SCREEN 1300.
 SELECTION-SCREEN tab (20) tab3 USER-COMMAND fc3 DEFAULT SCREEN 1400.
SELECTION-SCREEN end of BLOCK tabstrip.




AT SELECTION-SCREEN OUTPUT.
  BREAK-POINT.

INITIALIZATION.
  tab1 = 'Verbindungen'.
  tab2 = 'Flugdatum'.
  tab3 = 'Flugzeugtyp'.

tabstrip-activetab = 'FC3'.
tabstrip-dynnr = 1400.

  gv_t1 = 'Individueller Titel des Blocks'.
  so_car-sign = 'I'.
  so_car-option = 'BT'.
  so_car-low = 'AA'.
  so_car-high = 'LH'.
  APPEND so_car TO so_car.
  CLEAR so_car.
  so_car-sign = 'E'.
  so_car-option = 'EQ'.
  so_car-low = 'AZ'.
  APPEND so_car.


*  ADD 1 TO pa_zahl.
*  BREAK-POINT.

************************************************
* Anzeige des Bildschirms
*****************************

AT SELECTION-SCREEN.
  CASE sy-dynnr.
    WHEN 1000.
      IF pa_zahl > 1000.
        CALL SELECTION-SCREEN 1100
          STARTING AT  20  10
          ENDING   AT 150  15.
      ENDIF.
    WHEN 1100.
      IF sy-subrc <> 0.
        LEAVE SCREEN.
      ENDIF.
  ENDCASE.

START-OF-SELECTION.
  WRITE pa_zahl.
