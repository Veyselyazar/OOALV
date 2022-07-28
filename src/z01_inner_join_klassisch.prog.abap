*&---------------------------------------------------------------------*
*& Report Z01_INNER_JOIN_KLASSISCH
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_inner_join_klassisch.

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

SELECT b~carrid, b~connid,
        carrname, cityfrom, cityto
  INTO  @data(gs_daten)
  FROM scarr as a right OUTER JOIN spfli as b
  "FROM spfli as b right OUTER JOIN scarr as a
    ON a~carrid =  b~carrid

  .

  write: / gs_daten-carrid,
           gs_daten-carrname,
           gs_daten-connid,
           gs_daten-cityfrom,
           gs_daten-cityto.

ENDSELECT.
