       IDENTIFICATION DIVISION.
       PROGRAM-ID. MACPT.
       AUTHOR. SOUAD.
       DATE-WRITTEN. 11/01/23.
       DATE-COMPILED. 12/01/23.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

            EXEC SQL INCLUDE SQLCA END-EXEC.
            EXEC SQL INCLUDE CPTTBDCL END-EXEC.

       LINKAGE SECTION.
       COPY COPYFUNC  REPLACING ==()== BY ==CPT==.

       PROCEDURE DIVISION USING CPT-ZCMA.

           PERFORM 01-BEGIN.
           PERFORM 02-TREATMENT.
           PERFORM 03-CLOSEPGM.

       01-BEGIN.
           INITIALIZE  CPT-RETOUR.

       02-TREATMENT.
           EVALUATE CPT-FONCTION
              WHEN  'INS'
                 PERFORM 02A-INSERT-LINE
              WHEN  'DEL'
                 PERFORM 02B-DELETE-LINE
              WHEN  'UPD'
                 PERFORM 02C-UPDATE-LINE
              WHEN  'SEL'
                 PERFORM 02D-SELECT-LINE
              WHEN OTHER
                 MOVE '10'  TO  CPT-CODRET
                 MOVE 'FONCTION ERRONEE ' TO CPT-LIBRET
           END-EVALUATE
           .

       03-CLOSEPGM.
           EXIT PROGRAM
           .

      *************PARAGRAPHS TREATMENT*********************

       02A-INSERT-LINE.
           MOVE CPT-DONNEES TO DCLTBCPT
           DISPLAY 'DDMVT  ' DDMVT
           DISPLAY 'DDMAJ  ' DDMAJ
           DISPLAY 'HDMAJ  ' HDMAJ
           EXEC SQL
              INSERT INTO TBCPT VALUES
             (:COMPTE,
              :NOM,
              :SOLDE,
              :DDMVT,
              :DDMAJ,
              :HDMAJ)
           END-EXEC

ERSQL      PERFORM ERRORS-SQL-CPT.
           COPY CERORSQL REPLACING ==()== BY ==CPT==
           .

       02B-DELETE-LINE.
           MOVE CPT-DONNEES TO DCLTBCPT
           EXEC SQL
              DELETE FROM TBCPT
                WHERE COMPTE = :COMPTE
           END-EXEC
           .

       02C-UPDATE-LINE.
           MOVE CPT-DONNEES TO DCLTBCPT
           EXEC SQL
              UPDATE TBCPT
                SET COMPTE = :COMPTE,
                    NOM = :NOM,
                    SOLDE = :SOLDE,
                    DDMVT = :DDMVT,
                    DDMAJ = :DDMAJ,
                    HDMAJ = :HDMAJ
           END-EXEC
           .

       02D-SELECT-LINE.
           MOVE CPT-DONNEES TO DCLTBCPT
           DISPLAY CPT-DONNEES
           EXEC SQL
              SELECT *
                 INTO :COMPTE,:NOM,
                      :SOLDE,:DDMVT,
                      :DDMAJ,:HDMAJ
                  FROM TBCPT
                    WHERE  COMPTE = :COMPTE
           END-EXEC
           .

