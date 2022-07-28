*&---------------------------------------------------------------------*
*& Report Z01_GROUP_BY_HAVING
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z01_group_by_having.
TYPES: BEGIN OF gty_flight,
         carrid       TYPE sflight-carrid,
         connid       TYPE sflight-connid,
         seatsmax_avg TYPE sflight-seatsmax,
         seatsocc_avg TYPE sflight-seatsocc,
       END OF gty_flight.
DATA: gt_flights TYPE TABLE OF gty_flight,
      gs_flight  TYPE
       gty_flight.
SELECT-OPTIONS: so_car
FOR gs_flight-carrid.
SELECT-OPTIONS: so_avgmx FOR gs_flight-seatsmax_avg,
so_avgoc FOR gs_flight-seatsocc_avg.
SELECT
  carrid,
  connid,
  AVG( seatsmax ) AS seatsmax_avg,
  AVG( seatsocc ) AS seatsocc_avg

INTO  CORRESPONDING FIELDS OF table @gt_flights
FROM sflight
WHERE carrid IN @so_car
GROUP BY carrid, connid
HAVING avg( seatsmax ) IN @so_avgmx
AND AVG( seatsocc ) IN @so_avgoc.
"order by carrid DESCENDING, connid ASCENDING.


DATA go_alv TYPE REF TO cl_salv_table.
data go_disp type REF TO cl_salv_display_settings.
data go_columns type REF TO cl_salv_columns_table.

cl_salv_table=>factory(
  IMPORTING
    r_salv_table   = go_alv
  CHANGING
    t_table        = gt_flights
       ).

go_disp = go_alv->get_display_settings( ).
go_disp->set_list_header( value = 'Mein List-Header' ).

go_alv->display( ).
