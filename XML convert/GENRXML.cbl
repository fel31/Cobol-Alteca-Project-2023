       IDENTIFICATION DIVISION.
       PROGRAM-ID. GENRXML.
      *
      * Programme de génération xml
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *
      *  FICHIER EN ENTREE
      *
             SELECT FICHIER ASSIGN DFICHIER
             FILE STATUS IS WS-FS-FICHIER.
      *
      *  FICHIER EN SORTIE
      *
             SELECT FXMLOUT ASSIGN DFXMLOUT
             FILE STATUS IS WS-FS-FXMLOUT.
      *
       DATA DIVISION.
       FILE SECTION.
      *
       FD FICHIER.
       01 FICHIER-ENREG.
          05 COMPTE            PIC X(11).
          05 CODE-OPER         PIC X(03).
          05 REF-OPER          PIC X(10).
          05 CODE-DEV          PIC X(03).
          05 MONTANT-OPER      PIC 9(11)V99.
          05 FILLER            PIC X(40).
      *
       FD FXMLOUT RECORD VARYING FROM 1 TO 300 DEPENDING WS-LONG.
      *
       01 FXMLOUT-ENREG  PIC X(300).
      *
       WORKING-STORAGE SECTION.
      *
      * FILE STATUS FICHIER FICHEIR
      *
       01 WS-FS-FICHIER       PIC X(02).
       01 WS-FS-FXMLOUT       PIC X(02).
      *
      * COMPTEURS
      *
       01 WS-LUS              PIC 9(05).
       01 WS-ECRITS           PIC 9(05).
      *
      * LONGUEUR DU FICHIER XML GENERE
      *
       01 WS-LONG             PIC 9(4) COMP.
       PROCEDURE DIVISION.
       000-PGM.
           PERFORM 100-DEB
           PERFORM 200-TRT UNTIL WS-FS-FICHIER = '10'
           PERFORM 300-FIN
           .
       100-DEB.
           MOVE 0 TO WS-LUS WS-ECRITS
           PERFORM 110-OUV
           PERFORM 115-LEC
           .
       110-OUV.
           OPEN INPUT FICHIER OUTPUT FXMLOUT
           IF WS-FS-FICHIER NOT = '00' OR
              WS-FS-FXMLOUT NOT = '00'
              DISPLAY ' PROB OUVERTURE FICHIERS '
              DISPLAY ' FILE STATUS FICHIER ' WS-FS-FICHIER
              DISPLAY ' FILE STATUS FXMLOUT ' WS-FS-FXMLOUT
              PERFORM 310-FIN-ANORMALE
           END-IF
           .
       200-TRT.
            XML GENERATE FXMLOUT-ENREG
                FROM     FICHIER-ENREG
                COUNT IN WS-LONG
                WITH     XML-DECLARATION
             ON EXCEPTION
                DISPLAY 'ERREUR GENERATION XML-CODE = ' XML-CODE
            END-XML
            write fxmlout-enreg
            PERFORM 115-LEC
            .
       115-LEC.
           READ FICHIER
           EVALUATE WS-FS-FICHIER
             WHEN '00'
               ADD 1 TO WS-LUS
             WHEN '10'
               IF WS-LUS = ZERO
                  DISPLAY ' FICHIER FICHIER VIDE '
               END-IF
             WHEN OTHER
               DISPLAY ' PROB OUVERTURE FICENT '
               DISPLAY ' FILE STATUS FICHIER ' WS-FS-FICHIER
           END-EVALUATE
           .
       300-FIN.
           DISPLAY ' FIN NORMALE    '
           DISPLAY ' LUS ' WS-LUS
           DISPLAY ' ECR ' WS-ECRITS
           CLOSE FICHIER FXMLOUT
           STOP RUN
           .
       310-FIN-ANORMALE.
           DISPLAY ' FIN ANORMALE '
           CLOSE FICHIER FXMLOUT
           STOP RUN
           .
