*&---------------------------------------------------------------------*
*& Report  ZBC405_01_LOGDB
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

INCLUDE zbc405_01_ldb_alvtop.

NODES: spfli, sflight.
*data gt_flights type TABLE OF sdyn_conn.
*data gs_flight type sdyn_conn.

DATA: BEGIN OF gs_flight.
        INCLUDE TYPE sdyn_conn.
      DATA:
              free_seats TYPE sflight-seatsocc,
            END OF gs_flight.

DATA gt_flights LIKE TABLE OF gs_flight.

DATA go_alv TYPE REF TO cl_salv_table.
DATA go_func TYPE REF TO cl_salv_functions.
DATA go_columns TYPE REF TO cl_salv_columns_table.
DATA go_col TYPE REF TO cl_salv_column_table.




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

GET spfli .
  CLEAR gs_flight.
  MOVE-CORRESPONDING spfli TO gs_flight.

GET sflight.
  MOVE-CORRESPONDING sflight TO gs_flight.
  gs_flight-free_seats = sflight-seatsmax - sflight-seatsocc.
  APPEND gs_flight TO gt_flights.

*&------------------------------------------------

END-OF-SELECTION.

  cl_salv_table=>factory(
    IMPORTING
      r_salv_table   = go_alv
    CHANGING
      t_table        = gt_flights
         ).

  go_func = go_alv->get_functions( ).
  go_func->set_all( ).
  go_columns = go_alv->get_columns( ).
  go_columns->set_column_position(
    EXPORTING
      columnname =  'FREE_SEATS'
      position   =  22
  ).
  go_col  ?= go_columns->get_column( columnname = 'FREE_SEATS'  ).
  go_col->set_long_text( 'Freie Pöätze Economy' ).
  go_col->set_short_text( 'Frei' ).
  go_col->set_medium_text('Freie Plätze').
*

  go_alv->display( ).
