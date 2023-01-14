       IDENTIFICATION DIVISION.                                         00010000
       PROGRAM-ID. PARSEXML.                                            00020000
      *                                                                 00030000
      * Programme de génération xml                                     00040000
      *                                                                 00050000
       ENVIRONMENT DIVISION.                                            00060000
       INPUT-OUTPUT SECTION.                                            00070000
       FILE-CONTROL.                                                    00080000
      *                                                                 00090000
      *  FICHIER EN ENTREE                                              00100000
      *                                                                 00110000
             SELECT FXMLIN ASSIGN DFXMLIN                               00120000
             FILE STATUS IS WS-FS-FXMLIN.                               00130000
      *                                                                 00140000
      *  FICHIER EN SORTIE                                              00150000
      *                                                                 00160000
             SELECT FICHIER ASSIGN DFICHIER                             00170000
             FILE STATUS IS WS-FS-FICHIER.                              00180000
      *                                                                 00190000
       DATA DIVISION.                                                   00200000
       FILE SECTION.                                                    00210000
      *                                                                 00220000
       FD FXMLIN  RECORD VARYING FROM 1 TO 300 DEPENDING WS-LONG.       00230000
      *                                                                 00240000
       01 FXMLIN-ENREG  PIC X(300).                                     00250000
      *                                                                 00260000
       FD FICHIER.                                                      00270000
       01 FICHIER-ENREG.                                                00280000
          05 COMPTE            PIC X(11).                               00290000
          05 CODE-OPER         PIC X(03).                               00300000
          05 REF-OPER          PIC X(10).                               00310000
          05 CODE-DEV          PIC X(03).                               00320000
          05 MONTANT-OPER      PIC 9(11)V99.                            00330000
          05 FILLER            PIC X(40).                               00340000
      *                                                                 00350000
       WORKING-STORAGE SECTION.                                         00360000
      *                                                                 00370000
      * FILE STATUS FICHIER FICHEIR                                     00380000
      *                                                                 00390000
       01 WS-FS-FXMLIN        PIC X(02).                                00400000
       01 WS-FS-FICHIER       PIC X(02).                                00410000
      *                                                                 00420000
      * COMPTEURS                                                       00430000
      *                                                                 00440000
       01 WS-LUS              PIC 9(05).                                00450000
       01 WS-ECRITS           PIC 9(05).                                00460000
      *                                                                 00470000
      * LONGUEUR DU FICHIER XML GENERE                                  00480000
      *                                                                 00490000
       01 WS-LONG             PIC 9(4) COMP.                            00500000
                                                                        00510000
      *                                                                 00511001
      * ZONE qui RECUPERE LE NOM DE LA VARIABLE DANS XML                00512001
      *                                                                 00513001
       01 WS-VARIABLE         PIC X(30).                                00514001
      *                                                                 00515001
       PROCEDURE DIVISION.                                              00520000
       000-PGM.                                                         00530000
           PERFORM 100-DEB                                              00540000
           PERFORM 200-TRT UNTIL WS-FS-FXMLIN = '10'                    00550000
                            OR   RETURN-CODE NOT = 0                    00560000
           PERFORM 300-FIN                                              00570000
           .                                                            00580000
       100-DEB.                                                         00590000
           MOVE 0 TO WS-LUS WS-ECRITS                                   00600000
           PERFORM 110-OUV                                              00610000
           PERFORM 115-LEC                                              00620000
           .                                                            00630000
       110-OUV.                                                         00640000
           OPEN INPUT FXMLIN OUTPUT FICHIER                             00650000
           IF WS-FS-FXMLIN NOT = '00' OR                                00660000
              WS-FS-FICHIER NOT = '00'                                  00670000
              DISPLAY ' PROB OUVERTURE FICHIER '                        00680000
              DISPLAY ' FILE STATUS FXMLIN ' WS-FS-FXMLIN               00690000
              DISPLAY ' FILE STATUS FICHIER ' WS-FS-FICHIER             00700000
              PERFORM 310-FIN-ANORMALE                                  00710000
           END-IF                                                       00720000
           .                                                            00730000
       200-TRT.                                                         00740000
           XML PARSE FXMLIN-ENREG                                       00750000
               PROCESSING PROCEDURE PARSING-XML                         00760000
           END-XML                                                      00800000
           WRITE FICHIER-ENREG                                          00801002
           PERFORM 115-LEC                                              00810000
            .                                                           00820000
       PARSING-XML.                                                     00830000
            EVALUATE XML-EVENT                                          00840000
            WHEN 'ATTRIBUTE-NAME'                                       00850000
               MOVE XML-TEXT   TO  WS-VARIABLE                          00870000
            WHEN 'ATTRIBUTE-CHARACTERS'                                 00880000
               EVALUATE WS-VARIABLE                                     00910000
                  WHEN 'COMPTE'       MOVE XML-TEXT TO COMPTE           00920001
                  WHEN 'CODE-OPER'    MOVE XML-TEXT TO CODE-OPER        00930001
                  WHEN 'REF-OPER'     MOVE XML-TEXT TO REF-OPER         00940001
                  WHEN 'CODE-DEV'     MOVE XML-TEXT TO CODE-DEV         00950001
                  WHEN 'MONTANT-OPER' MOVE XML-TEXT TO MONTANT-OPER     00960000
               END-EVALUATE                                             00970000
           END-EVALUATE.                                                00980000
       115-LEC.                                                         00990000
           READ FXMLIN                                                  01000000
           EVALUATE WS-FS-FXMLIN                                        01010000
             WHEN '00'                                                  01020000
               ADD 1 TO WS-LUS                                          01030000
             WHEN '10'                                                  01040000
               IF WS-LUS = ZERO                                         01050000
                  DISPLAY ' FICHIER FXMLIN VIDE '                       01060000
               END-IF                                                   01070000
             WHEN OTHER                                                 01080000
               DISPLAY ' PROB OUVERTURE FICENT '                        01090000
               DISPLAY ' FILE STATUS FXMLIN ' WS-FS-FXMLIN              01100000
           END-EVALUATE                                                 01110000
           .                                                            01120000
       300-FIN.                                                         01130000
           DISPLAY ' FIN NORMALE    '                                   01140000
           DISPLAY ' LUS ' WS-LUS                                       01150000
           DISPLAY ' ECR ' WS-ECRITS                                    01160000
           CLOSE FXMLIN FICHIER                                         01170000
           STOP RUN                                                     01180000
           .                                                            01190000
       310-FIN-ANORMALE.                                                01200000
           DISPLAY ' FIN ANORMALE '                                     01210000
           CLOSE FXMLIN FICHIER                                         01220000
           STOP RUN                                                     01230000
           .                                                            01240000
