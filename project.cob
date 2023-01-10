       ID DIVISION.
       PROGRAM-ID. PROJECT.
       AUTHOR. SOUAD.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT FLUXRECORDS ASSIGN TO DINPUT
            ORGANIZATION IS SEQUENTIAL
            FILE STATUS IS WS-FS-FLUX.

       DATA DIVISION.
       FILE SECTION.
       FD FLUXRECORDS.
       01 FLUX-ENREG PIC X(80).

       WORKING-STORAGE SECTION.
       COPY CFLUX REPLACING ==()== BY ==F1==.

       01 COUNTERS.
         05 WS-LUS-00  PIC 9(06).
         05 WS-LUS-10  PIC 9(06).
         05 WS-LUS-99  PIC 9(06).
         05 WS-FS-LUS  PIC 9(06).
       01 WS-MT-GLOBAL PIC 9(11)V99.

       01 WS-FS-FLUX   PIC X(02).
         88 FS-OPENINPT       VALUE '00'.
         88 FS-ENDINPTFILE    VALUE '10'.
         88 FS-DDNAMEMISSING  VALUE '35'.
         88 FS-ERRORRECORDS   VALUE '39'.

       PROCEDURE DIVISION.

      ******************************************************************
      ***************************MAIN***********************************
           PERFORM 00-BEGIN.
           PERFORM 01-TREATMENT.
           PERFORM 02-ENDPROG.

      *************************END MAIN*********************************
      ******************************************************************


       00-BEGIN.
           INITIALIZE COUNTERS.
           INITIALIZE WS-MT-GLOBAL.
           OPEN INPUT  FLUXRECORDS.
           PERFORM ERRORS-OPEN.
           .
     
       01-TREATMENT.
           PERFORM 01-READFILES

           PERFORM UNTIL FS-ENDINPTFILE
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
                  PERFORM  01-SUPPLYVAR
               END-IF

               PERFORM 01-READFILES
           END-PERFORM

           PERFORM 01-RESULTS
           .

       02-ENDPROG.
           CLOSE FLUXRECORDS
           STOP RUN
           .

      ******************************************************************

       01-READFILES.
           READ FLUXRECORDS
              AT END SET FS-ENDINPTFILE TO TRUE
           END-READ
           PERFORM ERRORS-READ
           .    

       01-SUPPLYVAR.
           IF F1-NB-OPERATIONS NOT = WS-LUS-10
              MOVE 5 TO RETURN-CODE.
           IF F1-MT-GLOBAL NOT = WS-MT-GLOBAL
              MOVE 6 TO RETURN-CODE.
           .

       01-RESULTS.
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
              DISPLAY '**********************************'
           END-IF

           IF RETURN-CODE NOT = 0
              DISPLAY 'ERREUR DETECTEE'
              DISPLAY 'ERREUR , CODE RETOUR --->' RETURN-CODE
           END-IF
           .
      ******************************************************************

      ********************GESTION ERREURS FICHIERS**********************
       ERRORS-OPEN.
           EVALUATE TRUE
               WHEN FS-OPENINPT 
                 DISPLAY "SUCCES OUVERTURE FICHIER "
                 CONTINUE
               WHEN FS-DDNAMEMISSING
                 MOVE 1 TO RETURN-CODE
               WHEN FS-ERRORRECORDS
                 MOVE 2 TO RETURN-CODE
               WHEN OTHER
                 MOVE 3 TO RETURN-CODE
           END-EVALUATE
           .

       ERRORS-READ.
           EVALUATE TRUE
              WHEN FS-OPENINPT 
                ADD 1 TO WS-FS-LUS
              WHEN FS-ENDINPTFILE AND WS-FS-LUS =  0
                MOVE 4 TO RETURN-CODE
              WHEN OTHER
                CONTINUE
           END-EVALUATE
           .
      ********************FIN GESTION ERREURS FICHIERS******************
