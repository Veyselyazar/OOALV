*&---------------------------------------------------------------------*
*& Report Z01_EINGABE_BILDSCHIRM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_EINGABE_BILDSCHIRM.

data gv_carrname type scarr-carrname.
data gs_scarr type scarr.
PARAMETERS pa_car type spfli-carrid VALUE CHECK
MEMORY ID car OBLIGATORY DEFAULT 'aa' LOWER CASE.
PARAMETERS pa_name like gs_scarr-carrname.
PARAMETERS pa_prog type string MEMORY ID rid.
PARAMETERS pa_chk AS CHECKBOX DEFAULT abap_true.


PARAMETERS pa_rb1 RADIOBUTTON GROUP grp1.
PARAMETERS pa_rb2 RADIOBUTTON GROUP grp1 .
PARAMETERS pa_rb3 RADIOBUTTON GROUP grp1 DEFAULT 'X'.
select-OPTIONS so_car for gs_scarr-carrname no-EXTENSION no INTERVALS.


select * from scarr into gs_scarr
  where carrid in so_car. "Inhalt der Selctionstabelle so_car

ENDSELECT.

case pa_chk.
  when abap_true.
  when abap_false.
endcase.

case abap_true.
  when pa_rb1.

  when pa_rb2.

  when pa_rb3.
endcase.
