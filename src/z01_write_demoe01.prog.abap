*&---------------------------------------------------------------------*
*&  Include           Z01_WRITE_DEMOE01
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  gs_sflight-price  = 223.
  gs_sflight-currency = 'EUR'.






  WRITE: vorname UNDER 'Vorname', nachname UNDER 'Nachname'.


  ULINE.
  WRITE: / zahl,
         / zahl NO-ZERO.

  WRITE: / datum,
         / datum MM/DD/YYYY,
         / datum DD/MM/YY.
  ULINE.
  WRITE: gs_sflight-price CURRENCY gs_sflight-currency.
  gs_sflight-currency = 'JPY'.
  WRITE: / gs_sflight-price CURRENCY gs_sflight-currency.
  gs_sflight-currency = 'COP'.
  WRITE: / gs_sflight-price CURRENCY gs_sflight-currency.
  ULINE.
  gs_sbook-luggweight = 45.
  gs_sbook-wunit = 'KG'.
  WRITE: / gs_sbook-luggweight UNIT gs_sbook-wunit, gs_sbook-wunit.
  gs_sbook-wunit = 'C36'. "M/M
    WRITE: / gs_sbook-luggweight UNIT  gs_sbook-wunit , gs_sbook-wunit.
  gs_sbook-wunit = 'DEG'.
  WRITE: / gs_sbook-luggweight UNIT gs_sbook-wunit, gs_sbook-wunit.
  ULINE.
  WRITE iban.
  WRITE: / iban USING EDIT MASK '__ __-____-____-____-____'.
  ULINE.
  WRITE iban CENTERED.
  WRITE / iban RIGHT-JUSTIFIED.
  WRITE / iban.


TOP-OF-PAGE.
  WRITE: AT 10 'Vorname',
         AT 140 'Nachname'.


END-OF-SELECTION.
  ULINE.
  WRITE: 'Programmende um', sy-uzeit.
