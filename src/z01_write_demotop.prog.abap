*&---------------------------------------------------------------------*
*&  Include           Z01_WRITE_DEMOTOP
*&---------------------------------------------------------------------*
DATA: vorname  TYPE string VALUE 'Stefanie',
      nachname TYPE string VALUE 'Langner',
      zahl     TYPE n LENGTH 8 VALUE '345',
      datum    TYPE sy-datum VALUE '20220118'.
DATA gs_sflight TYPE sflight.
DATA iban TYPE c LENGTH 30 VALUE 'DE67395501101200357414'.
DATA gs_sbook TYPE sbook.
