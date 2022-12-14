*&---------------------------------------------------------------------*
*&  Include           ZBC405_01_SOLTOP
*&---------------------------------------------------------------------*
DATA gs_flights TYPE dv_flights.
DATA gv_where TYPE string.


SELECTION-SCREEN BEGIN OF SCREEN 1100 AS SUBSCREEN.
SELECTION-SCREEN begin of block B1.
SELECT-OPTIONS so_car FOR gs_flights-carrid MEMORY ID car.
SELECT-OPTIONS so_con FOR gs_flights-connid.
SELECTION-SCREEN PUSHBUTTON /40(20) gv_push USER-COMMAND fc_push.
select-OPTIONS so_citfr for gs_flights-cityfrom MODIF ID aus.
select-OPTIONS so_citto for gs_flights-cityto MODIF ID aus.
SELECTION-SCREEN end of block b1.
SELECTION-SCREEN END OF SCREEN 1100.


SELECTION-SCREEN BEGIN OF SCREEN 1200 AS SUBSCREEN.
SELECT-OPTIONS so_fld FOR gs_flights-fldate NO-EXTENSION.
SELECTION-SCREEN END OF SCREEN 1200.

SELECTION-SCREEN BEGIN OF SCREEN 1300 AS SUBSCREEN.
SELECTION-SCREEN BEGIN OF BLOCK radio WITH FRAME.
PARAMETERS pa_all RADIOBUTTON GROUP grp1
 USER-COMMAND FC_RB_GRP1.
PARAMETERS pa_inl RADIOBUTTON GROUP grp1.
PARAMETERS pa_int RADIOBUTTON GROUP grp1 DEFAULT 'X'.
SELECTION-SCREEN skip 1.
PARAMETERS pa_land type dv_flights-countryfr.
SELECTION-SCREEN END OF BLOCK radio.
SELECTION-SCREEN END OF SCREEN 1300.

SELECTION-SCREEN BEGIN OF SCREEN 1400 as SUBSCREEN.
  PARAMETERS pa_list RADIOBUTTON GROUP grp2.
  PARAMETERS pa_alv  RADIOBUTTON GROUP grp2.
  PARAMETERS pa_a_lst AS CHECKBOX.
SELECTION-SCREEN end of screen 1400.

SELECTION-SCREEN begin of TABBED BLOCK tabstrip for 10 lines.
  selection-SCREEN tab (20) tab1 USER-COMMAND FC1 DEFAULT screen 1100.
  selection-SCREEN tab (20) tab2 USER-COMMAND FC2 DEFAULT SCREEN 1200.
  selection-SCREEN tab (20) tab3 USER-COMMAND FC3 DEFAULT SCREEN 1300.
  selection-SCREEN tab (20) tab4 USER-COMMAND FC4 DEFAULT SCREEN 1400.
SELECTION-SCREEN end of block tabstrip.
