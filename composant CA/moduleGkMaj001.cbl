      *********************************************************
      * PROGRAM NAME:  GKMAJ001                               *
      * PROGRAM OBJET :COUCHE APPLICATIVE, CHAINE MISE A JOUR *
      *                CONTROLE CONTENU DU FICHIER SEQ FLUX   *
      *                DEBUT MISE A JOUR DES TABLES           *
      *                APPEL DU MODULE MFMAJCPT               *
      * ORIGINAL AUTHOR: SOUAD                                *
      *                                                       *
      * MAINTENENCE LOG                                       *
      * DATE      AUTHOR        MAINTENANCE REQUIREMENT       *
      * --------- ------------  ----------------------------- *
      * 13/01/12 SOUAD   CREATED FOR COBOL CLASS              *
      *                                                       *
      *********************************************************

       ID DIVISION.
       PROGRAM-ID. GKMAJ001.
       AUTHOR. SOUAD.
       DATE-WRITTEN. 13/01/23.
       DATE-COMPILED. 13/01/23.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

            SELECT FLUXRECORDS ASSIGN TO DDINT
            ORGANIZATION IS SEQUENTIAL
            FILE STATUS IS WS-FS-FLUX.

            SELECT REJETSRECORDS ASSIGN DDOUT
            ORGANIZATION IS SEQUENTIAL
            FILE STATUS IS WS-FS-REJETS.

       DATA DIVISION.
       FILE SECTION.

       FD FLUXRECORDS.
       01 FLUX-ENREG  PIC X(80).

       FD REJETRECORDS.
       01 REJETS-ENREG.
        05 R-10-F1    PIC X(80).
        05 R-MOTIF    PIC X(30).
        05 R-SQLCODE  PIC -999.

       WORKING-STORAGE SECTION.

       COPY CFLUX REPLACING ==()== BY ==F1==.

       01 WS-MT-GLOBAL PIC 9(11)V99.

       01 WS-FS-FLUX   PIC X(02).
         88 OPENINPTSUCCES-F  VALUE '00'.
         88 ENDOFINPTFILE-F   VALUE '10'.

       01 WS-FS-REJETS PIC X(02).
         88 OPENINPTSUCCES-R  VALUE '00'.
         88 ENDOFINPTFILE-R   VALUE '10'.

       PROCEDURE DIVISION.

           PERFORM 01-BEGIN.
           PERFORM 02-TREATMENT.
           PERFORM 03-ENGPGM.

       01-BEGIN.
           OPEN INPUT FLUXRECORDS.
           OPEN OUTPUT REJETRECORDS.

       02-TREATMENT.
           PERFORM 02A-READ-FILES.
           PERFORM 02B-ALGO UNTIL ENDOFINPTFILE-F.

       03-ENDPGM.
           CLOSE FLUXRECORDS, REJETRECORDS
           STOP RUN
           .

PARAT ******** PARAGRAPHS TREATMENT   ******************************

       02A-READ-FILES.
            READ FLUXRECORDS
            .

       02B-ALGO.
           IF F1-ENREG-00 = '10'
              PERFORM ALIM-ZFMAJCPT
              CALL 'MFMAJCPT' USING FLUX-ENREG

              IF ZF-CODRET NOT = '00'
                 PERFORM ECRITURE-REJETS
              END-IF

           END-IF

           PERFORM 02A-READ-FILES
           .

       ALIM-ZFMAJCPT.
           MOVE FLUX-ENREG  TO ZF-MAJCPT
           .

       ECRITURE-REJETS.
           WRITE R-10-F1 FROM F1-ENREG-10
           WRITE R-MOTIF FROM ZF-LIBRET
           WRITE R-SQLCODE FROM ZF-SQLCODE
           .

