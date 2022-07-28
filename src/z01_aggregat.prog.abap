*&---------------------------------------------------------------------*
*& Report Z01_AGGREGAT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_aggregat.
DATA gv_carrid TYPE scarr-carrid VALUE 'AA'.
DATA gv_avg TYPE p DECIMALS 2.
"PARAMETERS pa_car type scarr-carrid DEFAULT 'LH' NO-DISPLAY.

IMPORT carrid TO gv_carrid
  FROM MEMORY ID 'MEINE_DATEN'.

FREE MEMORY ."ID ."'MEINE_DATEN'.

SELECT COUNT( DISTINCT seatsocc ), AVG(  seatsocc )
  FROM sflight
  INTO ( @DATA(gv_target),
       @gv_avg )
  WHERE carrid = @gv_carrid.


WRITE: 'Ergebnis', gv_target LEFT-JUSTIFIED,
       / 'Summe', gv_avg.
