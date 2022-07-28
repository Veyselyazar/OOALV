*&---------------------------------------------------------------------*
*& Report  ZBC405_01_LOGDB
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_01_ldbtop                        .    " global Data

NODES: spfli, sflight, sbook.

DATA gv_free_seats TYPE i.
SELECTION-SCREEN BEGIN OF BLOCK cust WITH FRAME.
SELECT-OPTIONS so_cust FOR sbook-customid.
SELECTION-SCREEN END OF BLOCK cust.


INITIALIZATION.
  carrid-sign
  = 'I'.
  carrid-option = 'BT'.
  carrid-low
  = 'AA'.
  carrid-high
  = 'LH'.
  APPEND carrid.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-name CS 'AIRP_TO'.
      screen-active = 0.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

START-OF-SELECTION.

GET spfli.
* Data output SPFLI
  WRITE:
  spfli-carrid,
  spfli-connid,
  spfli-cityfrom,
  spfli-airpfrom,
  spfli-cityto,
  spfli-airpto.

GET sflight.
* Calculate free seats
  gv_free_seats = sflight-seatsmax - sflight-seatsocc.
* Data output SFLIGHT
  WRITE:
  sflight-fldate,
  sflight-price CURRENCY sflight-currency,
  sflight-currency,
  sflight-planetype,
  sflight-seatsmax,
  sflight-seatsocc,
  gv_free_seats.

*&------------------------------------------------
GET sbook.
  CHECK so_cust.
  WRITE:
  sbook-bookid,
  sbook-customid,
  sbook-smoker,
  sbook-luggweight UNIT sbook-wunit,
  sbook-wunit.

GET sflight LATE.
  ULINE.

GET spfli LATE.
  NEW-PAGE.
