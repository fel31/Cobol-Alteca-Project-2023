//CHAINE JOB (ACCOUNT),GIE,MSGCLASS=X,CLASS=A,NOTIFY=&SYSUID
//* EXECUTION DU LOAD
//***********************************************************
//* PHASE CTRL DU FICHIER FLUX
//***********************************************************
//CTRL EXEC PGM=GKCTRL01
//STEPLIB DD DSN=IBMUSER.COB.LOAD,
//            DISP=SHR
//SYSOUT DD SYSOUT=*,OUTLIM=1000
//CEEOPTS DD *

//*ENTREE => FICHIER FLUX
//DDJCL DD DSN=IBMUSER.COB.FLUX,DISP=SHR
//*
//***********************************************************
//* PHASE MISE A JOUR DU SOLDE DU COMPTE
//***********************************************************
//TEST1 IF RC=0 THEN
//GKMAJ EXEC PGM=IKJEFT01
//STEPLIB  DD DSN=DSN910.DB9G.RUNLIB.LOAD,DISP=SHR
//         DD DSN=IBMUSER.COB.LOAD,DISP=SHR
//*
//SYSTSPRT DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//SYSOUT   DD SYSOUT=*
//SYSTSIN DD *
    DSN SYSTEM(DB9G)
      RUN PROGRAM(GKMAJ001) PLAN(PLANCOB)
     END
//INJCL  DD DSN=IBMUSER.COB.FLUX,DISP=SHR
//OUTJCL DD DSN=IBMUSER.COB.REJETS,DISP=(NEW,CATLG,DELETE),
// SPACE=(TRK,(10,10),RLSE)
//*
// ENDIF