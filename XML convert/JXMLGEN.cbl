//IBMUSERE  JOB (ACCOUNT),GIE,MSGCLASS=X,CLASS=A,NOTIFY=&SYSUID         JOB07237
//*
//EXECUTE  EXEC PGM=GENRXML,DYNAMNBR=20
//STEPLIB  DD  DSN=IBMUSER.COB.LOAD,DISP=SHR
//DFICHIER DD  DSN=IBMUSER.COB.FICTOXML,DISP=SHR
//DFXMLOUT DD DSN=IBMUSER.COB.XMLOUT,DISP=(,CATLG,DELETE),
//         SPACE=(TRK,(5,5),RLSE)
//SYSOUT   DD  SYSOUT=*
/*
