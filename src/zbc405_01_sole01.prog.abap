*&---------------------------------------------------------------------*
*&  Include           ZBC405_01_SOLE01
*&---------------------------------------------------------------------*
INITIALIZATION.
*  tabstrip-activetab = 'FC2'.
*  tabstrip-dynnr = '1200'.
  tab1 = 'Verbindungen'.
  tab2 = 'Flugdatum'.
  tab3 = 'Flugart'.
  tab4 = 'Listausgabe'.
  gv_push = 'Städte ausblenden'.


  "Vorbelegung der Select-Options
*  so_car-sign = 'I'.
*  so_car-option = 'BT'.
*  so_car-low = 'AA'.
*  so_car-high = 'QF'.
*  APPEND so_car.
*  CLEAR so_car.
*  so_car-sign = 'E'.
*  so_car-option = 'EQ'.
*  so_car-low = 'AZ'.
*  APPEND so_car.


*AT SELECTION-SCREEN on so_car.
*  if so_car-low <> 'LH'.
*    message 'Es wird nur Lufthansa verarbeitet' type 'E'.
*  endif.

*  at SELECTION-SCREEN on HELP-REQUEST FOR so_car.
*    call SCREEN 110
*     STARTING AT 30  15
*     ENDING AT   150 18.

AT SELECTION-SCREEN OUTPUT.
  CASE sy-dynnr.
    WHEN 1300.
      IF pa_inl = abap_false .
        LOOP AT SCREEN.
          IF screen-name CS 'PA_LAND'.
            screen-active = 0.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      ENDIF.
  ENDCASE.

  CASE sy-dynnr.
    WHEN 1100.
      IF gv_push = 'Städte einblenden'.
        LOOP AT SCREEN.
          IF screen-group1 = 'AUS'.
            screen-active = 0.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      ENDIF.
  ENDCASE.

AT SELECTION-SCREEN.
  CASE sy-dynnr.
    WHEN 1100.
      CASE sy-ucomm.
        WHEN 'FC_PUSH'.
          IF gv_push = 'Städte einblenden'.
            gv_push = 'Städte ausblenden'.
          ELSE.
            gv_push = 'Städte einblenden'.
          ENDIF.
      ENDCASE.

  ENDCASE.


AT SELECTION-SCREEN ON BLOCK radio.

  IF pa_inl = abap_true
    AND pa_land IS INITIAL
    AND sy-ucomm <> 'FC_RB_GRP1'.
    MESSAGE e003(bc405).
  ENDIF.



START-OF-SELECTION.
  gv_where = 'carrid IN so_car AND connid IN so_con AND fldate IN so_fld'.
  gv_where = gv_where && ' and cityfrom in so_citfr'.
  gv_where = gv_where && ' and cityto in so_citto'.
  CASE abap_true.
    WHEN pa_all.
    WHEN pa_inl.
      gv_where = gv_where && ' AND countryto = dv_flights~countryfr'.
      gv_where = gv_where && ' and countryfr = pa_land'.
    WHEN pa_int.
      gv_where = gv_where && ' AND countryto <> dv_flights~countryfr'.
  ENDCASE.
  CASE abap_true.
    WHEN pa_list.
      SELECT * FROM dv_flights INTO gs_flights
        WHERE (gv_where).
        PERFORM ausgabe USING gs_flights.
      ENDSELECT.
    WHEN pa_alv.
      DATA go_alv_om TYPE REF TO cl_salv_table.
      DATA go_func TYPE REF TO cl_salv_functions.
      DATA gt_flights TYPE TABLE OF dv_flights.
      SELECT * FROM dv_flights INTO TABLE gt_flights
        WHERE (gv_where).
      cl_salv_table=>factory(
         EXPORTING
           list_display   = pa_a_lst
        IMPORTING
          r_salv_table   = go_alv_om
        CHANGING
          t_table        = gt_flights
             ).
      go_func = go_alv_om->get_functions( ).
      go_func->set_all( ).
      go_alv_om->display( ).
  ENDCASE.

TOP-OF-PAGE.
  DATA go_type TYPE REF TO cl_abap_typedescr.
  DATA go_struct TYPE REF TO cl_abap_structdescr.

  go_type = cl_abap_typedescr=>describe_by_data( gs_flights ).
  CASE go_type->kind.
    WHEN 'S'.
      go_struct ?= go_type.
      DATA(gt_fields) = go_struct->get_ddic_field_list( ).
      LOOP AT gt_fields INTO DATA(gs_field) FROM 2.
        WRITE: gs_field-reptext(gs_field-outputlen) .
      ENDLOOP.
  ENDCASE.
  ULINE.
