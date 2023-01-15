       
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