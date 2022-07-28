*&---------------------------------------------------------------------*
*& Report Z01_LOGISCHE_DATENBANK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_logische_datenbank.

NODES: spfli, sflight.


GET spfli.
  WRITE: / spfli-carrid, spfli-connid, spfli-cityfrom, spfli-cityto.


GET sflight.
  WRITE: /10 sflight-fldate, sflight-planetype, sflight-seatsmax, sflight-seatsocc.
