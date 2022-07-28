*&---------------------------------------------------------------------*
*& Report Z01_MAIN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_MAIN.

*call TRANSACTION 'SE11'
* AND SKIP FIRST SCREEN.

data gv_car type scarr-carrid value 'SQ'.

export carrid from gv_car
       to MEMORY id 'MEINE_DATEN'.

submit Z01_AGGREGAT
   "with pa_car = 'AA'
   "VIA SELECTION-SCREEN. "Programm auf Stack gelegt
   AND RETURN.

message 'Zurück im Hauptprogramm' type 'I'.
