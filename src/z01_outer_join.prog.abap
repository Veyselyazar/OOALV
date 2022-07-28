*&---------------------------------------------------------------------*
*& Report Z01_INNER_JOIN_KLASSISCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_outer_join.

*types: BEGIN OF gty_daten,
*        carrid    TYPE scarr-carrid,
*        connid    TYPE spfli-connid,
*        fldate    TYPE sflight-fldate,
*        carrname  TYPE scarr-carrname,
*        cityfrom  TYPE spfli-cityfrom,
*        cityto    TYPE spfli-cityto,
*        planetype TYPE sflight-planetype,
*        seatsmax  TYPE sflight-seatsmax,
*        seatsocc  TYPE sflight-seatsocc,
*      END OF gty_daten.
*
*data gs_daten type gty_daten.

SELECT a~carrid, b~connid,
       fldate, carrname, cityfrom, cityto, planetype,
       seatsmax, seatsocc, seatsmax_b, seatsocc_b
  INTO  @data(gs_daten)
  FROM scarr as a INNER JOIN spfli as b
    ON a~carrid = b~carrid
  INNER JOIN sflight as c
    ON  b~carrid = c~carrid
    AND b~connid = c~connid
  WHERE a~carrid = 'LH'
  .

  write: / gs_daten-carrid,
           gs_daten-connid,
           gs_daten-fldate,
           gs_daten-cityfrom,
           gs_daten-cityto,
           gs_daten-planetype,
           gs_daten-seatsmax,
           gs_daten-seatsocc.
ENDSELECT.
