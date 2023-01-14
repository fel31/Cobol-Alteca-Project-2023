      *********************************************************
      * PROGRAM NAME:  TESTSACC                               *
      * PROGRAM OBJET :TESTS ACCESSEURS                       *
      *                TESTS DU  CRUD DE CHAQUE TABLE         *
      *                APPEL DES ACCESSEURS METIERS           *
      * ORIGINAL AUTHOR: SOUAD                                *
      *                                                       *
      * MAINTENENCE LOG                                       *
      * DATE      AUTHOR        MAINTENANCE REQUIREMENT       *
      * --------- ------------  ----------------------------- *
      * 11/01/23 SOUAD   CREATED FOR COBOL CLASS              *
      *                                                       *
      *********************************************************

       ID DIVISION.
       PROGRAM-ID. TESTSACC.
       AUTHOR. SOUAD.
       DATE-WRITTEN. 11/01/23.
       DATE-COMPILED. 11/01/23.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       COPY COPYFUNC REPLACING ==()== BY ==CPT==.
       COPY COPYFUNC REPLACING ==()== BY ==HIS==.
       COPY COPYFUNC REPLACING ==()== BY ==DEV==.
       COPY COPYFUNC REPLACING ==()== BY ==HOP==.

       PROCEDURE DIVISION.
                  PERFORM 01-TEST.
                  PERFORM 02-END-PGM.

       01-TESTS.
                  PERFORM 01A-TBCPT.
                  PERFORM 01B-TBHIS.
                  PERFORM 01C-TBDEV.
                  PERFORM 01D-TBHOP.

       02-END-PGM.
           DISPLAY 'CODE RETOUR  ---->   ' CPT-RETOUR

           STOP RUN
           .


       01A-TBCPT.

CPTIN * TEST INSERTION CHAMPS DANS LA TABLE TBCPT
             MOVE 'INS' TO CPT-FONCTION.
             MOVE '11200500010' TO  CPT-COMPTE.
             MOVE    'SOUAD'    TO CPT-NOM.
             MOVE 1500 TO CPT-SOLDE.
             MOVE '2023-01-11' TO CPT-DDMVT.
             MOVE '2023-01-11' TO CPT-DDMAJ.
             MOVE '15.00.00'   TO CPT-HDMAJ.
           CALL 'MOD1'     USING CPT-ZCMA.

CPTSL * TEST SELECTION CHAMPS ID N° 1120060001
             MOVE 'SEL' TO CPT-FONCTION.
             MOVE '11200600010' TO CPT-COMPTE.
           CALL 'MOD1'     USING CPT-ZCMA.
             DISPLAY 'SELECT COMPTE ' CPT-DONNEES.

CPTUP * TEST MISE A JOUR CHAMPS ID N° 11200000020
             DISPLAY 'PAS ENCORE FAIT MISE A JOUR '
             MOVE 'UPD'TO CPT-FONCTION.
             MOVE '11200000020' TO CPT-COMPTE.
             MOVE 'JULIEN' TO CPT-NOM.
             MOVE 1999 TO CPT-SOLDE.
             MOVE '2023-01-09' TO CPT-DDMVT.
             MOVE '17.00.00'   TO CPT-DDMAJ.
             MOVE '15.00.00'   TO CPT-HDMAJ.
             .

CPTDE * TEST SUPRESSION CHAMPS ID N° 11200000020
             DISPLAY 'PAS ENCORE FAIT MISE A JOUR '
             .

       01B-TBHIS.
HISIN *INSERTION CHAMPS
HISUP *MODIFICATION CHAMPS ID N°
HISDE *SUPPRESSION  CHAMPS ID N°
HISSL *AFFICHAGE    CHAMPS ID N°
             DISPLAY 'COUCOU DE TBHIP'
             .

       01C-TBDEV.
DEVIN *INSERTION CHAMPS
DEVUP *MODIFICATION CHAMPS ID N°
DEVDE *SUPPRESSION  CHAMPS ID N°
DEVSL *AFFICHAGE    CHAMPS ID N°
             DISPLAY 'COUCOU DE TBDEV'
             .

       01D-TBHOP.
HOPIN *INSERTION CHAMPS
HOPUP *MODIFICATION CHAMPS ID N°
HOPDE *SUPPRESSION  CHAMPS ID N°
HOPSL *AFFICHAGE    CHAMPS ID N°
             DISPLAY 'COUCOU DE TBHOP'
             .

