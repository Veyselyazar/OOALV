*&---------------------------------------------------------------------*
*& Report Z01_LDB_VERWENDEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_ldb_verwenden.
NODES: spfli, sflight.
DATA gv_sum_occ TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK occ WITH FRAME TITLE TEXT-occ.
SELECT-OPTIONS so_occ FOR sflight-seatsocc.
SELECTION-SCREEN END OF BLOCK occ.

START-OF-SELECTION.

GET spfli FIELDS cityfrom cityto.  "In der Sequenz der LDB Reaktion auf PUT SPFLI.
  CLEAR gv_sum_occ.
  WRITE: / spfli-carrid, spfli-connid, spfli-cityfrom, spfli-cityto.


GET spfli LATE.
  ULINE.
  WRITE: / 'Summe der belegten Plätze',gv_sum_occ, spfli-carrid, spfli-connid.
  ULINE.

GET sflight.
  CHECK so_occ.
  ADD sflight-seatsocc TO gv_sum_occ.
  WRITE: /20 sflight-carrid, spfli-connid, sflight-fldate,
  sflight-planetype, sflight-seatsocc, sflight-seatsmax.


END-OF-SELECTION.
  ULINE.
  WRITE 'Programmende'.
