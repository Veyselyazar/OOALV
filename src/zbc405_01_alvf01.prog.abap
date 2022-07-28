*&---------------------------------------------------------------------*
*&  Include           ZBC405_01_ALVF01
*&---------------------------------------------------------------------*
FORM settings_layout.
  gs_layout-zebra = check_zebra.
  gs_layout-grid_title = 'Flüge'(tit).
  "  gs_layout-cwidth_opt = 'X'.
  gs_layout-sel_mode = 'D'.  "A = mehrere Zeilen und mehrere Spalten
  "gs_layout-totals_bef = 'X'. "Summe einer Spalte in oberster Zeile anzeigen
  gs_layout-info_fname = 'COLOR'. "Farbspalte C + Color + Intenisv + Invers
  gs_layout-excp_fname = 'LIGHT'. " 1= rot 2=gelb 3=grün 0=grau
  "gs_layout-excp_led = abap_true. "Einzelne LED anzeigen
  "gs_layout-no_hgridln = 'X'. "Ausblenden horizontale Linien
  "gs_layout-no_vgridln = 'X'. "Ausblenden vertikale Linien
  gs_layout-ctab_fname = 'IT_COLFIELDS'.
  gs_layout-stylefname = 'CT'.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  SETTINGS_SORT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM settings_sort .
  "Sortierkriterien festlegen
  gs_sort-fieldname = 'SEATSOCC'. "Spaltenname
  gs_sort-down = 'X'.             "absteigend sortieren
  gs_sort-spos = 2.               "Position in der Sort-Hierarchie
  APPEND gs_sort TO gt_sort.
  CLEAR gs_sort.
  gs_sort-fieldname = 'CONNID'.  "Spaltenname
  gs_sort-up = 'X'.              "absteigend sortieren
  gs_sort-spos = 1.              "Position in der Sort-Hierarchie
  APPEND gs_sort TO gt_sort.

ENDFORM.

FORM feldkatalog_setzen.
  CLEAR gt_fieldcat.
  gs_fieldcat-fieldname = 'FREE_SEATS'.
  APPEND gs_fieldcat TO gt_fieldcat.
  gs_fieldcat-fieldname = 'LIGHT'.
  APPEND gs_fieldcat TO gt_fieldcat.
  gs_fieldcat-fieldname = 'CHANGES_POSSIBLE'.
  APPEND gs_fieldcat TO gt_fieldcat.
  gs_fieldcat-fieldname = 'BTN_TEXT'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = 'SFLIGHT'
    CHANGING
      ct_fieldcat      = gt_fieldcat.

  LOOP AT gt_fieldcat INTO gs_fieldcat.
    CASE gs_fieldcat-fieldname.
      when 'CHANGES_POSSIBLE'.
        gs_fieldcat-coltext = 'Änderungen möglich'(cps).
        gs_fieldcat-tooltip = 'Sind Änderungen noch möglich'(cpo).
        gs_fieldcat-col_pos = 5.
      when 'SEATSOCC'.
        gs_fieldcat-do_sum = 'X'.
      when 'PAYMENTSUM'.
        gs_fieldcat-no_out = 'X'.
      when 'LIGHT'.
        gs_fieldcat-coltext = 'Ampel'(amp).
      WHEN 'FREE_SEATS'.
        "gs_fieldcat-coltext = 'Freie Plätze'.
        gs_fieldcat-col_pos = 10.
        gs_fieldcat-scrtext_s  = 'Frei'.
        gs_fieldcat-scrtext_m  = 'Freie Plätze'.
        gs_fieldcat-scrtext_l  = 'Freie Sitzplätze Economy'.
        gs_fieldcat-tooltip = 'Anzeige der freie Sitzplätze'.
        " gs_fieldcat-emphasize = 'C610'.
      WHEN 'PLANETYPE'.
        gs_fieldcat-col_pos = 3.
        gs_fieldcat-hotspot = 'X'.
        "gs_fieldcat-outputlen = 50.
      WHEN 'SEATSOCC' OR 'SEATSOCC_B' OR 'SEATSOCC_F'.
        gs_fieldcat-no_sum = 'X'.
        "  gs_fieldcat-no_out = 'X'.
      WHEN 'FLDATE'.
        gs_fieldcat-key = ' '.
      when 'IN_FUTURE'.
        gs_fieldcat-icon = 'X'.
        gs_fieldcat-col_pos = 4.
      when 'BTN_TEXT'.
       " gs_fieldcat-no_out = 'X'.
        gs_fieldcat-Coltext = 'Button'.
        gs_fieldcat-col_pos = 8.
    ENDCASE.
    MODIFY gt_fieldcat FROM gs_fieldcat.
  ENDLOOP.
ENDFORM.
