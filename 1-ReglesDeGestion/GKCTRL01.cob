      *********************************************************
      * PROGRAM NAME:  GKCTRL01                               *
      * PROGRAM OBJET :COUCHE CONTROLE,                       *
      *                CONTROLE STRUCTURE DU FICHIER SEQ FLUX *
      * ORIGINAL AUTHOR: SOUAD                                *
      *                                                       *
      * MAINTENENCE LOG                                       *
      * DATE      AUTHOR        MAINTENANCE REQUIREMENT       *
      * --------- ------------  ----------------------------- *
      * 10/01/23 SOUAD   CREATED FOR COBOL CLASS              *
      *                                                       *
      *********************************************************
       ID DIVISION.
       PROGRAM-ID. PROJECT.
       AUTHOR. SOUAD.
       DATE-WRITTEN. 10/01/23.
       DATE-COMPILED. 11/01/23.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT FLUXRECORDS ASSIGN TO DINPUT
            ORGANIZATION IS SEQUENTIAL
            FILE STATUS IS WS-FS-FLUX.

       DATA DIVISION.
       FILE SECTION.
       FD FLUXRECORDS.
       01 FLUX-ENREG  PIC X(80).

       WORKING-STORAGE SECTION.
       COPY CFLUX REPLACING ==()== BY ==F1==.

       01 COUNTERS.
         05 WS-LUS-00  PIC 9(06).
         05 WS-LUS-10  PIC 9(06).
         05 WS-LUS-99  PIC 9(06).
         05 WS-FS-LUS  PIC 9(06).
       01 WS-MT-GLOBAL PIC 9(11)V99.

       01 WS-FS-FLUX   PIC X(02).
         88 OPENINPTSUCCES VALUE '00'.
         88 ENDOFINPTFILE  VALUE '10'.
         88 DDNAMEMISSING  VALUE '35'.
         88 ERRORRECORDSF  VALUE '39'.

       PROCEDURE DIVISION.
           PERFORM 00-BEGIN.
           PERFORM 01-TREATMENT.
           PERFORM 02-ENDPROG.

       00-BEGIN.
           INITIALIZE COUNTERS.
           INITIALIZE WS-MT-GLOBAL.
           OPEN INPUT  FLUXRECORDS.
           PERFORM ERROPENFILES.
           .

       READFILES.
           READ FLUXRECORDS
              AT END SET ENDOFINPTFILE TO TRUE
           END-READ
           PERFORM ERROREADFILES
           .

       ERROPENFILES.
           EVALUATE TRUE
               WHEN OPENINPTSUCCES
                 DISPLAY "SUCCES OUVERTURE FICHIER "
                 CONTINUE
               WHEN DDNAMEMISSING
                 MOVE 1 TO RETURN-CODE
               WHEN ERRORRECORDSF
                 MOVE 2 TO RETURN-CODE
               WHEN OTHER
                 MOVE 3 TO RETURN-CODE
           END-EVALUATE
           .

        ERROREADFILES.
            EVALUATE TRUE
               WHEN OPENINPTSUCCES
                 ADD 1 TO WS-FS-LUS
               WHEN ENDOFINPTFILE AND WS-FS-LUS =  0
                 MOVE 4 TO RETURN-CODE
               WHEN OTHER
                 CONTINUE
            END-EVALUATE
            .

       01-TREATMENT.
           PERFORM READFILES

           PERFORM UNTIL ENDOFINPTFILE
           MOVE FLUX-ENREG TO F1-ENREG-00
      *    DISPLAY F1-ENREG-00
               IF F1-TYPE-00  = '00'
                  ADD 1 TO WS-LUS-00
               END-IF

               IF F1-TYPE-00 = '10'
                  ADD 1 TO WS-LUS-10
                  ADD F1-MONTANT-OPER TO WS-MT-GLOBAL
               END-IF

               IF F1-TYPE-00 = '99'
                  ADD 1 TO WS-LUS-99
                  PERFORM  SUPPLYVAR
               END-IF

               PERFORM READFILES
           END-PERFORM

           PERFORM RESULTS
           .

       SUPPLYVAR.
           IF F1-NB-OPERATIONS NOT = WS-LUS-10
              MOVE 5 TO RETURN-CODE.
           IF F1-MT-GLOBAL NOT = WS-MT-GLOBAL
              MOVE 6 TO RETURN-CODE.
           .

       RESULTS.
           IF WS-LUS-00 = 0
              MOVE 7 TO RETURN-CODE
           END-IF

           IF WS-LUS-99 = 0
              MOVE 8 TO RETURN-CODE
           END-IF

           IF RETURN-CODE = 0
              DISPLAY 'AUCUNE ERREUR'
              DISPLAY '**********************************'
              DISPLAY '*************GESTION**************'
              DISPLAY '**********************************'
              DISPLAY '* WS-FS-LUS : ' WS-FS-LUS
              DISPLAY '* WS-LUS-00 : ' WS-LUS-00
              DISPLAY '* WS-LUS-99 : ' WS-LUS-99
              DISPLAY '* WS-LUS-10 : ' WS-LUS-10
              DISPLAY '* MT GLOBAL : ' WS-MT-GLOBAL
           END-IF

           IF RETURN-CODE NOT = 0
              DISPLAY 'ERREUR DETECTEE'
              DISPLAY 'ERREUR , CODE RETOUR --->' RETURN-CODE
           END-IF
           .

       02-ENDPROG.
           CLOSE FLUXRECORDS
           STOP RUN
           .
