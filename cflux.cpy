       01 ()-ENREG-00.
         05 ()-TYPE-00       PIC  X(02).
         05 ()-ORIGINE       PIC  X(03).
         05 ()-DATE          PIC  X(10).
         05 FILLER           PIC  X(65).
       01 ()-ENREG-10 REDEFINES  ()-ENREG-00.
         05 ()-TYPE-10       PIC  X(02).
         05 ()-COMPTE        PIC  X(11).
         05 ()-CODE-OPER     PIC  X(03).
         05 ()-REF-OPER      PIC  X(10).
         05 ()-CODE-DEV      PIC  X(03).
         05 ()-MONTANT-OPER  PIC  9(11)V99.
         05 FILLER           PIC  X(38).
       01 ()-ENREG-99 REDEFINES ()-ENREG-00.
         05 ()-TYPE-99       PIC  X(02).
         05 ()-NB-OPERATIONS PIC 9(06).
         05 ()-MT-GLOBAL     PIC 9(11)V99.
         05 FILLER           PIC X(59).
