*&---------------------------------------------------------------------*
*&  Include           ZBC405_01_SOLF01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  AUSGABE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GS_FLIGHTS  text
*----------------------------------------------------------------------*
FORM ausgabe  USING    p_gs_flights TYPE dv_flights.
  DO.
    ASSIGN COMPONENT sy-index OF STRUCTURE p_gs_flights TO FIELD-SYMBOL(<fs_field>).
    IF sy-subrc = 4.
      NEW-LINE.
      EXIT.
    ENDIF.
    IF sy-index > 1.
      WRITE <fs_field>.
    ENDIF.
  ENDDO.
*WRITE: / P_gs_flights-carrid,
*         p_gs_flights-connid,
*         p_gs_flights-fldate,
*         p_gs_flights-countryfr,
*         p_gs_flights-cityfrom,
*         p_gs_flights-airpfrom,
*         p_gs_flights-countryto,
*         p_gs_flights-cityto,
*         p_gs_flights-airpto,
*         p_gs_flights-price,
*         p_gs_flights-currency,
*         p_gs_flights-seatsmax,
*         p_gs_flights-seatsocc.
ENDFORM.
