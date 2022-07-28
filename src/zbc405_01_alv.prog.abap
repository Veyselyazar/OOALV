*&---------------------------------------------------------------------*
*& Report Z01_TRAEGER_DYNPRO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc405_01_alv.

DATA ok_code TYPE sy-ucomm.
DATA mv_i TYPE i.

TYPES: BEGIN OF gty_flights,
         color            TYPE c LENGTH 4.
         INCLUDE TYPE sflight.
       TYPES:
                light            TYPE c LENGTH 1,
                it_colfields     TYPE lvc_t_scol,
                free_seats       TYPE i,
                changes_possible TYPE icon-id,
                btn_text         TYPE c LENGTH 20,
                ct               TYPE lvc_t_styl,
              END OF gty_flights.

DATA gs_flights TYPE gty_flights.
DATA gt_flights LIKE TABLE OF gs_flights.

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    METHODS on_double_click FOR EVENT double_click OF cl_gui_alv_grid
      IMPORTING es_row_no e_column.
    METHODS on_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
      IMPORTING es_row_no e_column_id sender.
    METHODS on_toolbar FOR EVENT toolbar OF cl_gui_alv_grid IMPORTING e_object.
    METHODS on_user_command
    FOR EVENT user_command
    OF cl_gui_alv_grid IMPORTING e_ucomm sender.
    METHODS on_button_click FOR EVENT button_click OF cl_gui_alv_grid IMPORTING es_row_no.
    METHODS on_before_user_command
    FOR EVENT before_user_command OF cl_gui_alv_grid IMPORTING e_ucomm sender.
    METHODS on_context_menu_request
     FOR EVENT context_menu_request
     OF cl_gui_alv_grid IMPORTING
       e_object sender.
ENDCLASS.
CLASS lcl_handler IMPLEMENTATION.
  METHOD on_double_click.
    READ TABLE gt_flights INTO DATA(ls_flights) INDEX es_row_no-row_id.
    IF sy-subrc = 0.
      DATA(lv_summe_buchungen) = ls_flights-seatsocc
                            + ls_flights-seatsocc_b
                            + ls_flights-seatsocc_f.
      MESSAGE `Summe aller Buchungen ` && lv_summe_buchungen TYPE 'I'.
    ELSE.
      MESSAGE i075(bc405_408).
    ENDIF.
  ENDMETHOD.
  METHOD on_hotspot_click.
        sender->set_user_command( i_ucomm = 'MARKED'  ).
  ENDMETHOD.
  METHOD on_toolbar.
    DATA ls_button TYPE stb_button.
    ls_button-butn_type = '3'.
    APPEND ls_button TO  e_object->mt_toolbar.
    CLEAR ls_button.
    ls_button-function = 'PERCENTAGE'.
    ls_button-text = '% gesamt'.
    ls_button-quickinfo = 'Gesamtauslastung Economy'.
    APPEND ls_button TO  e_object->mt_toolbar.
    CLEAR ls_button.
    ls_button-function = 'MARKED'.
    ls_button-text = '% markiert'.
    ls_button-quickinfo = 'Auslast. Economy (markierte Flüge)'.
    APPEND ls_button TO  e_object->mt_toolbar.

  ENDMETHOD.
  METHOD on_user_command.
    DATA: lv_prozent   TYPE p DECIMALS 2,
          lv_summe_occ TYPE i,
          lv_summe_max TYPE i.
    DATA: lt_rows TYPE lvc_t_row,
          ls_rows TYPE lvc_s_row.

    CASE e_ucomm.
      WHEN 'PERCENTAGE'.
 "       sender->set_user_command( i_ucomm = 'NEU'  ).
        LOOP AT gt_flights INTO gs_flights.
          lv_summe_occ = lv_summe_occ + gs_flights-seatsocc.
          lv_summe_max = lv_summe_max + gs_flights-seatsmax.
        ENDLOOP.
        lv_prozent = lv_summe_occ / lv_summe_max * 100.
        MESSAGE `Prozentuale Auslastung: ` && lv_prozent TYPE 'I'.

      WHEN 'MARKED'.
        sender->get_selected_rows(
          IMPORTING
            et_index_rows = lt_rows    " Indizes der selektierten Zeilen
*            et_row_no     =     " Numerische IDs der selektierten Zeilen
        ).
        IF lines( lt_rows ) > 0.
          LOOP AT lt_rows INTO ls_rows.
            READ TABLE gt_flights INTO gs_flights INDEX ls_rows-index.
            IF sy-subrc = 0.
              lv_summe_occ = lv_summe_occ + gs_flights-seatsocc.
              lv_summe_max = lv_summe_max + gs_flights-seatsmax.
            ENDIF.
          ENDLOOP.
          lv_prozent = lv_summe_occ / lv_summe_max * 100.
          MESSAGE `Prozentuale Auslastung der selektierten Zeilen: ` && lv_prozent TYPE 'I'.
        ELSE.
          MESSAGE 'Es ist keine Zeile markiert' TYPE 'S'.
        ENDIF.
      WHEN 'CARRIER_INFO'.
        READ TABLE gt_flights INTO gs_flights INDEX mv_i.
        IF sy-subrc = 0.
          SELECT SINGLE * FROM scarr INTO @data(ls_scarr)
            WHERE carrid = @gs_flights-carrid.
          IF sy-subrc = 0.
            MESSAGE `Name der Fluggesellschaft ` && ls_scarr-carrname TYPE 'I'.
          ENDIF.
        ENDIF.

    ENDCASE.

*    DATA: lv_row   TYPE i,
*          lv_col   TYPE i,
*          lv_value TYPE c LENGTH 10.
*    CASE e_ucomm.
*      WHEN 'ABC'.
*        MESSAGE 'ABC wurde ausgelöst' TYPE 'I'.
*      WHEN 'FC_B1'.
*        " MESSAGE 'Flugzeug wurde geklickt' TYPE 'I'.
*        sender->get_current_cell(
*          IMPORTING
*            e_row     =  lv_row   " Zeile auf Grid
*            e_value   =  lv_value   " Wert
*            e_col     =  lv_col   " Spalte auf Grid
**            es_row_id =     " Zeilen-Id
**            es_col_id =     " Spalten-Id
**            es_row_no =     " Numerische Zeilen ID
*        ).
*        DATA lt_cells TYPE lvc_t_cell.
*        sender->get_selected_cells(
*          IMPORTING
*            et_cell =  lt_cells   " selektierte Zellen
*        ).
*        LOOP AT lt_cells INTO DATA(ls_cell).
*          WRITE: / ls_cell-row_id-index,
*                   ls_cell-col_id-fieldname,
*                   ls_cell-value.
*        ENDLOOP.
*
*        DATA lt_col TYPE lvc_t_col.
*        sender->get_selected_columns(
*          IMPORTING
*            et_index_columns =  lt_col   " Indizes der selektierten Zeilen
*        ).
*
*        DATA lt_rows TYPE lvc_t_roid.
*        sender->get_selected_rows(
*          IMPORTING
**         et_index_rows =     " Indizes der selektierten Zeilen
*            et_row_no     =   lt_rows   " Numerische IDs der selektierten Zeilen
*        ).
*        sender->set_user_command( 'ABC').
*    ENDCASE.
  ENDMETHOD.
  METHOD on_button_click.
      message `Klick auf Buttton Buchungen ` && es_row_no-row_id type 'I'.
  ENDMETHOD.
  METHOD on_before_user_command.
   "  sender->set_user_command( i_ucomm = 'MARKED'  ).
  ENDMETHOD.
  METHOD on_context_menu_request.
    DATA gs_col_id TYPE lvc_s_col.
    sender->get_current_cell(
      IMPORTING
        e_row     =   mv_i  " Zeile auf Grid
        es_col_id =  gs_col_id   " Spalten-Id
    ).
    IF gs_col_id-fieldname = 'CARRID'.
      e_object->add_function(
        EXPORTING
          fcode             = 'CARRIER_INFO'    " Funktionscode
          text              =  'Name der Fluggesellschaft'   " Funktionstext
  ).
    ENDIF.
*    cl_ctmenu=>load_gui_status(
*      EXPORTING
*        program    =   sy-cprog  " Programmname
*        status     =   'CONTEXT'  " Status
**        disable    =     " Inaktive Funktionen
*        menu       =   e_object  " Menüreferenz
*    ).
*  e_object->add_function(
*    EXPORTING
*      fcode             = 'ZUSATZ'    " Funktionscode
*      text              = 'Weitere Funktion'    " Funktionstext
**      icon              =     " Ikonen
**      ftype             =     " Funktionstyp
*      "disabled          =  'X'   " Inaktiv
**      hidden            =     " Unsichtbar
**      checked           =     " Ausgewählt
**      accelerator       =     " Direktanwahl
**      insert_at_the_top = SPACE    " An erster Stelle einfügen (Default: an letzter Stelle einfg)
*  ).
*  data lt_funcions type ui_functions.
*  append 'PERCENTAGE' to lt_funcions.
*  append 'MARKED' to lt_funcions.
*  e_object->hide_functions( fcodes = lt_funcions ).


  ENDMETHOD.
ENDCLASS.
DATA go_handler TYPE REF TO lcl_handler.

SELECT-OPTIONS so_car FOR gs_flights-carrid DEFAULT 'AA'.
SELECT-OPTIONS so_con FOR gs_flights-connid DEFAULT '17'.
PARAMETERS pa_plane TYPE saplane-planetype.
PARAMETERS pa_lv TYPE disvariant-variant.
"Variante für Anzeige ALV
DATA gs_variant TYPE disvariant.
"Layout für Anzeige ALV
DATA gs_layout TYPE lvc_s_layo.
DATA check_zebra TYPE c LENGTH 1 VALUE 'X'.
" Sortierung vor Anzeige des ALV
DATA: gs_sort TYPE lvc_s_sort.
DATA  gt_sort TYPE lvc_t_sort.
" Funktionscodes, die ausgeblendet werden sollen
DATA gt_excluding TYPE ui_functions.

"Zellenfarbe

DATA gs_colfields LIKE LINE OF gs_flights-it_colfields.
"Feldkatalog für ALV definieren
DATA gt_fieldcat TYPE lvc_t_fcat.
DATA gs_fieldcat TYPE lvc_s_fcat.
" Struktur für Button
DATA gs_ct TYPE lvc_s_styl.

INITIALIZATION.
  gs_variant-report = sy-cprog.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR pa_lv.
  CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
    EXPORTING
      is_variant = gs_variant
      i_save     = 'A'      "A = alle X = benutzerübergreifende Layouts
    IMPORTING
      es_variant = gs_variant
    EXCEPTIONS
      OTHERS     = 2.

  IF sy-subrc = 0.
    pa_lv = gs_variant-variant.
  ENDIF.



START-OF-SELECTION.
  gs_ct-style = cl_gui_alv_grid=>mc_style_button.
  gs_ct-fieldname = 'BTN_TEXT'.

  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_flights
    WHERE carrid IN so_car
      AND connid IN so_con.


  IF gt_flights IS NOT INITIAL.
    LOOP AT gt_flights INTO gs_flights.

      IF gs_flights-seatsocc = 0.
        gs_flights-light = '1'.  "rot
      ELSEIF gs_flights-seatsocc < 50.
        gs_flights-light = '2'.  "gelb
      ELSE.
        gs_flights-light = 3.  "grün
      ENDIF.

      IF gs_flights-fldate(6) = sy-datum(6). "JJJJMM
        gs_flights-color = 'C601'.
      ENDIF.

      IF gs_flights-fldate < sy-datum.
        gs_flights-changes_possible = icon_space.

      ELSE.
        gs_flights-changes_possible = icon_okay.
        APPEND gs_ct TO gs_flights-ct.
        gs_flights-btn_text = 'Buchung'.
      ENDIF.




      IF gs_flights-planetype = pa_plane.
        CLEAR gs_colfields.
        gs_colfields-fname = 'PLANETYPE'.
        gs_colfields-color-col = col_positive.
        APPEND gs_colfields TO gs_flights-it_colfields.
      ENDIF.


      gs_flights-free_seats = gs_flights-seatsmax - gs_flights-seatsocc.
      MODIFY gt_flights FROM gs_flights.
      "TRANSPORTING light color it_colfields.

    ENDLOOP.

    CALL SCREEN 100. "PBO des Dynpro 100 aufrufen
  ELSE.
    MESSAGE 'Keine Daten zu dieser Selektion vorhanden ' TYPE 'S'.
  ENDIF.



  INCLUDE zbc405_01_alvo01.
  INCLUDE zbc405_01_alvi01.
  INCLUDE zbc405_01_alvf01.
