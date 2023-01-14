       IDENTIFICATION DIVISION.
       PROGRAM-ID MFMAJCPT.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       COPY ZAOPE  REPLACING ==()== BY ==OPE==.
       COPY ZADEV  REPLACING ==()== BY ==DEV==.
       COPY ZACPT  REPLACING ==()== BY ==CPT==.
       COPY ZAHIS  REPLACING ==()== BY ==HIS==.

       01 CODEOPERATION PIC XXX.
         88 CODEDEBIT   VALUES 'PRL','RMB','VIR','RET','AGI','RDT'.
         88 CODECREDIT  VALUES 'VER','VRD','INT','VVF'.

       LINKAGE SECTION.

       COPY ZFMAJCPT.

       PROCEDURE DIVISION USING ZF-MAJCPT, ZF-RETOUR.

                  PERFORM 01-BEGIN.
                  PERFORM 02-TREATMENT.
                  PERFORM 03-ENDPGM.

       01-BEGIN.
             INITIALIZE ZF-RETOUR
             .

       02-TREATMENT.
             PERFORM VERIF-CODOPE
             IF ZF-CODRET = '00'
                PERFORM VERIF-CODDEV
                IF ZF-CODRET = '00'

                   PERFORM VERIF-COMPTE
                   IF ZF-CODRET = '00'
                      PERFORM 02A-TREATMENT
                   END-IF

                END-IF
             END-IF
             .

       03-END-PGM.
           DISPLAY 'CODE RETOUR' CPT-RETOUR
           STOP RUN
           .

      ********** PARAGRAPHS TREATMENT *****************
       02A-TREATMENT.
           IF CODEDEBIT
             COMPUTE CPT-SOLDE =
                     CPT-SOLDE  - (DEV-MTACHAT * ZF-MNTOPE)
           END-IF

           IF CODECREDIT
             COMPUTE CPT-SOLDE =
                     CPT-SOLDE + ZA-DEV-ACHAT * ZF-MNTOPE
           END-IF
           PERFORM 02A-MAJ-SOLDE.

           IF ZF-CODRET = '00'
             PERFORM MAJ-HISTORIQUE
           END-IF
           .
      
       02A-MAJ-SOLDE.
           MOVE 'UPD' TO ZC-CPT-FONCTION
           CALL 'MACPT'  USING CPT-ZCMA
           .
      *****MANQUE DES CHOSES ICII ********************
      *******MANQUE DES PARAPH
      ********** PARAGRAPHS VERIFICATION **************
