*----------------------------------------------------------------------*
***INCLUDE Z01_TRAEGER_DYNPRO_O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0100  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'DYN'.
  SET TITLEBAR 'TITEL100'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  CREATE_AND_DISPLAY_ALV  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_and_transfer OUTPUT.
  DATA go_container TYPE REF TO cl_gui_custom_container.
  DATA go_alv_grid TYPE REF TO cl_gui_alv_grid.
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'MY_CONTROL_AREA'
      EXCEPTIONS
        OTHERS         = 4.
    IF sy-subrc = 4.
      MESSAGE a010(bc405_408).
    ENDIF.

    " go_alv_grid = NEW #( i_parent = NEW cl_gui_custom_container( container_name = 'MY_CONTROL_AREA')  ).
    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent = go_container.

    create OBJECT go_handler.
    set HANDLER go_handler->on_double_click for go_alv_grid.
    set HANDLER go_handler->on_hotspot_click for go_alv_grid.
    set HANDLER go_handler->on_toolbar for go_alv_grid.
    set HANDLER go_handler->on_user_command for go_alv_grid.
    set HANDLER go_handler->on_button_click for go_alv_grid.
    set HANDLER go_handler->on_before_user_command for go_alv_grid.
    set HANDLER go_handler->on_context_menu_request for go_alv_grid.

    gs_variant-variant = pa_lv.
    " Füllen des Layouts für Display

    perform settings_layout.
    perform settings_sort.



    " Auszublendende Fuunktionscodes
   " APPEND cl_gui_alv_grid=>mc_fc_sort_asc TO gt_excluding. "Ausblenden aufsteigende Sortierung
   " APPEND cl_gui_alv_grid=>mc_fc_sort_dsc TO gt_excluding. "Ausblenden absteigende Sortierung

" Feldkatalog füllen
*gs_fieldcat-fieldname = 'FREE_SEATS'.
*gs_fieldcat-coltext = 'Freie Plätze'.
*gs_fieldcat-col_pos = 10.
*append gs_fieldcat to gt_fieldcat.
*clear gs_fieldcat.
*gs_fieldcat-fieldname = 'LIGHT'.
*gs_fieldcat-coltext = 'Ampel'.
*append gs_fieldcat to gt_fieldcat.
*clear gs_fieldcat.
*gs_fieldcat-fieldname = 'PLANETYPE'.
*gs_fieldcat-coltext = 'Typ'.
*gs_fieldcat-col_pos = 3.
*gs_fieldcat-no_out = 'X'.
*append gs_fieldcat to gt_fieldcat.
*clear gs_fieldcat.
*gs_fieldcat-fieldname = 'SEATSMAX'.
*gs_fieldcat-ref_table = 'SAPLANE'.
*gs_fieldcat-ref_field = 'SEATSMAX_F'.

"append gs_fieldcat to gt_fieldcat.

perform feldkatalog_setzen.

    go_alv_grid->set_table_for_first_display(
      EXPORTING
      "  i_structure_name             = 'SFLIGHT'
*      is_variant                     = gs_variant
*      i_save                         = 'A'
*      i_default                      = 'X'
       is_layout                     = gs_layout
*    is_print                      =
*    it_special_groups             =
       it_toolbar_excluding          = gt_excluding
*    it_hyperlink                  =
*    it_alv_graphics               =
*    it_except_qinfo               =
*    ir_salv_adapter               =
      CHANGING
        it_outtab                    = gt_flights
       it_fieldcatalog               = gt_fieldcat
       it_sort                       = gt_sort
*    it_filter                     =
      EXCEPTIONS
     OTHERS = 4
           ).
    IF sy-subrc <> 0.
      MESSAGE a012(bc405_408).
    ENDIF.

  ELSE.
"perform feldkatalog_setzen.
*    SELECT * FROM sflight INTO TABLE gt_flights
*      WHERE connid = 400.
    go_alv_grid->refresh_table_display(
*      EXPORTING
*        is_stable      =
*        i_soft_refresh =
*      EXCEPTIONS
*        finished       = 1
           ).
  ENDIF.
ENDMODULE.
MODULE clear_ok_code OUTPUT.
  CLEAR ok_code.
ENDMODULE.
