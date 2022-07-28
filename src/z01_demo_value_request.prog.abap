*&---------------------------------------------------------------------*
*& Report Z01_DEMO_VALUE_REQUEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_DEMO_VALUE_REQUEST.
PARAMETERS: p_table LIKE dd02l-tabname DEFAULT 'T100'.
PARAMETERS: p_field TYPE slis_fieldname.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_field.

  DATA: it_fieldvalues TYPE STANDARD TABLE OF rsselread WITH DEFAULT KEY.
  APPEND VALUE #( name = 'P_TABLE' " Dynprofeld P_TABLE
                  kind = 'P'       " P - PARAMETER, S - SELECT-OPTION
                ) TO it_fieldvalues.

* Element des Selektionsbildes lesen
  CALL FUNCTION 'RS_SELECTIONSCREEN_READ'
    EXPORTING
      program     = sy-repid
      dynnr       = sy-dynnr
    TABLES
      fieldvalues = it_fieldvalues.

  DATA(lv_tabname) = it_fieldvalues[ 1 ]-fieldvalue.

  IF NOT lv_tabname IS INITIAL.
    TRANSLATE lv_tabname TO UPPER CASE.

    SELECT fieldname
      FROM dd03l
      INTO TABLE @DATA(it_cols)
      WHERE tabname = @lv_tabname.

    IF sy-subrc = 0.
      DATA: it_return TYPE STANDARD TABLE OF ddshretval WITH DEFAULT KEY.

* F4-Hilfe mit Übergabe der anzuzeigenden Werte in interner Tabelle
      CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
        EXPORTING
          retfield        = 'FIELDNAME' " Rückgabewert aus dem Feld FIELDNAME
          dynpprog        = sy-repid
          dynpnr          = sy-dynnr
          dynprofield     = 'P_FIELD'   " Name des Dynpro-Feldes für die automatische Werterückgabe
          value_org       = 'S'         " Werteübergabe: C: zellenweise, S: strukturiert
          window_title    = 'Auswahl'
        TABLES
          value_tab       = it_cols     " Übergabe-Tabelle mit Werten für die Anzeige und Auswahl
          return_tab      = it_return   " Rückgabe-Tabelle mit den ausgewählten (geklickten) Elementen
        EXCEPTIONS
          parameter_error = 1
          no_values_found = 2
          OTHERS          = 3.

      IF sy-subrc = 0.
        IF lines( it_return ) > 0.
          MESSAGE it_return[ 1 ]-fieldval TYPE 'S'.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDIF.
