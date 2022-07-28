*&---------------------------------------------------------------------*
*& Report Z01_FERNSTEUERUNG_ERFASSUNG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_FERNSTEUERUNG_ERFASSUNG.

data gs_bdc type bdcdata.
data gt_bdc type TABLE OF bdcdata.

gs_bdc-program = 'SAPMZSCARR_ERFASSEN'.
gs_bdc-dynpro  = '0100'.
gs_bdc-dynbegin = 'X'.
append gs_bdc to gt_bdc.

clear gs_bdc.
gs_bdc-fnam = 'SCARR-CARRID'.
gs_bdc-fval = 'A4'.
append gs_bdc to gt_bdc.

clear gs_bdc.
gs_bdc-fnam = 'SCARR-CARRNAME'.
gs_bdc-fval = 'A4-Airline'.
append gs_bdc to gt_bdc.

clear gs_bdc.
gs_bdc-fnam = 'SCARR-CURRCODE'.
gs_bdc-fval = 'USD'.
append gs_bdc to gt_bdc.

clear gs_bdc.
gs_bdc-fnam = 'SCARR-URL'.
gs_bdc-fval = 'http://a4.com'.
append gs_bdc to gt_bdc.

clear gs_bdc.
gs_bdc-fnam = 'BDC_OKCODE'.
gs_bdc-fval = 'SAVE'.
append gs_bdc to gt_bdc.
clear gs_bdc.

gs_bdc-program = 'SAPMZSCARR_ERFASSEN'.
gs_bdc-dynpro  = '0100'.
gs_bdc-dynbegin = 'X'.
append gs_bdc to gt_bdc.

clear gs_bdc.
gs_bdc-fnam = 'BDC_OKCODE'.
gs_bdc-fval = 'EXIT'.
append gs_bdc to gt_bdc.

call TRANSACTION 'Z01SCARR' using gt_bdc MODE 'E'.
if sy-subrc = 0.
  message 'Transaktion gelaufen' type 'S'.
else.
  message 'Fehlerhafter Aufruf der transaktion' type 'I'.
ENDIF.
