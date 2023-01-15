       IDENTIFICATION DIVISION.
       PROGRAM-ID. MFMAJCPT.

       DATA DIVISION.

       WORKING-STORAGE SECTION.

       01  CPT-ZCMA.
         05 CPT-FONCTION        PIC X(03).
         05 CPT-DONNEES.
          10 CPT-COMPTE       PIC X(11).
          10 CPT-NOM          PIC X(20).
          10 CPT-SOLDE        PIC S9(13)V9(2) USAGE COMP-3.
          10 CPT-DDMVT        PIC X(10).
          10 CPT-DDMAJ        PIC X(10).     
          10 CPT-HDMAJ        PIC X(8).
         05 CPT-RETOUR.
          10 CPT-CODRET       PIC X(02).
          10 CPT-SQLCODE      PIC S9(3).
          10 CPT-LIBRET       PIC X(30).

        
       01  DEV-ZCMA.
         05 DEV-FONCTION        PIC X(03).
         05 CPT-DONNEES.
          10 DEV-COMPTE       PIC X(11).
          10 DEV-NOM          PIC X(20).
          10 DEV-SOLDE        PIC S9(13)V9(2) USAGE COMP-3.
          10 DEV-DDMVT        PIC X(10).
          10 DEV-DDMAJ        PIC X(10).     
          10 DEV-HDMAJ        PIC X(8).
         05 DEV-RETOUR.
          10 DEV-CODRET       PIC X(02).
          10 DEV-SQLCODE      PIC S9(3).
          10 DEV-LIBRET       PIC X(30).
      

        01  OPE-ZCMA.
         05 OPE-FONCTION        PIC X(03).
         05 OPE-DONNEES.
          10 OPE-COMPTE       PIC X(11).
          10 OPE-NOM          PIC X(20).
          10 OPE-SOLDE        PIC S9(13)V9(2) USAGE COMP-3.
          10 OPE-DDMVT        PIC X(10).
          10 OPE-DDMAJ        PIC X(10).     
          10 OPE-HDMAJ        PIC X(8).
         05 OPE-RETOUR.
          10 OPE-CODRET       PIC X(02).
          10 OPE-SQLCODE      PIC S9(3).
          10 OPE-LIBRET       PIC X(30).

        01  HIS-ZCMA.
         05 HIS-FONCTION        PIC X(03).
         05 HIS-DONNEES.
          10 HIS-COMPTE       PIC X(11).
          10 HIS-NOM          PIC X(20).
          10 HIS-SOLDE        PIC S9(13)V9(2) USAGE COMP-3.
          10 HIS-DDMVT        PIC X(10).
          10 HIS-DDMAJ        PIC X(10).     
          10 HIS-HDMAJ        PIC X(8).
         05 HIS-RETOUR.
          10 HIS-CODRET       PIC X(02).
          10 HIS-SQLCODE      PIC S9(3).
          10 HIS-LIBRET       PIC X(30).

       01 DEV-CDEV  PIC X(03).
       01 DEV-MTACHAT PIC S9(13)V9(2) USAGE COMP-3.
       01 DEV-MTVENTE PIC S9(13)V9(2) USAGE COMP-3.


       01 CODEOPERATION PIC XXX.
         88 CODEDEBIT   VALUES 'PRL','RMB','VIR','RET','AGI','RDT'.
         88 CODECREDIT  VALUES 'VER','VRD','INT','VVF'.

       LINKAGE SECTION.

        01 ZF-MAJCPT.
         05 ZF-COMPTE PIC  X(11).
         05 ZF-REFOPE PIC  X(03).
         05 ZF-CODOPE PIC X(03).
         05 ZF-DATOPE PIC X(10).
         05 ZF-MNTOPE PIC S9(11)V99 COMP-3.
         05 ZF-CODDEV.
         
       01 ZF-RETOUR.
         05 ZF-CODRET  PIC X(02).
         05 ZF-SQLCODE PIC S9(3).
         05 ZF-LIBRET  PIC X(30).
            

       PROCEDURE DIVISION USING ZF-MAJCPT, ZF-RETOUR.

                  PERFORM 01-BEGIN.
                  PERFORM 02-TREATMENT.
                  PERFORM 03-ENDPGM.

       01-BEGIN.
             INITIALIZE ZF-RETOUR
             .

       02-TREATMENT.
                      PERFORM 02A-TREATMENT
             .

       03-ENDPGM.
           DISPLAY 'CODE RETOUR' CPT-RETOUR
           STOP RUN
           .

      ********** ASSIGNMENT **************************

       


      ********** PARAGRAPHS TREATMENT *****************
       02A-TREATMENT.
           IF CODEDEBIT
             COMPUTE CPT-SOLDE =
                     CPT-SOLDE  - (DEV-MTACHAT * ZF-MNTOPE)
           END-IF

           IF CODECREDIT
             COMPUTE CPT-SOLDE =
                     CPT-SOLDE + DEV-MTACHAT  * ZF-MNTOPE
           END-IF
           PERFORM 02A-MAJ-SOLDE.

           IF ZF-CODRET = '00'
             PERFORM 02B-MAJ-HISTORIQUE
           END-IF
           .
      
       02A-MAJ-SOLDE.
           MOVE 'UPD' TO CPT-FONCTION
           CALL 'MACPT'  USING CPT-ZCMA
           MOVE CPT-RETOUR TO ZF-RETOUR 
           .

        02B-MAJ-HISTORIQUE.
           MOVE 'INS' TO CPT-FONCTION 
           CALL 'MAHIS' USING HIS-ZCMA
           MOVE HIS-RETOUR TO ZF-RETOUR
           
           .
     
