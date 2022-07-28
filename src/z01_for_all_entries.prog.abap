*&---------------------------------------------------------------------*
*& Report Z01_FOR_ALL_ENTRIES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z01_FOR_ALL_ENTRIES.

data gt_spfli type table of spfli.
data gt_sflight type TABLE OF sflight.
*select * from spfli into TABLE gt_spfli
*  where cityfrom = 'FRANKFURT'.
*
*select * from spfli appending table gt_spfli
*  where cityto = 'NEW YORK'.

  sort gt_spfli by carrid ASCENDING connid ASCENDING.

  delete ADJACENT DUPLICATES FROM gt_spfli.

select * from sflight into TABLE gt_sflight
  for ALL ENTRIES IN gt_spfli
    where carrid = gt_spfli-carrid
      and connid = gt_spfli-connid.

data go_alv type REF TO cl_salv_table.
*TRY.
cl_salv_table=>factory(
  IMPORTING
   r_salv_table   = go_alv
  CHANGING
    t_table        = gt_sflight
       ).

go_alv->display( ).
