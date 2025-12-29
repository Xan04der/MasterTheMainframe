//SPELJOB     JOB ,'Xander',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//*-------------------------------------
//*  Step 1 - Compile the COBOL Program
//*-------------------------------------
//COBOL    EXEC IGYWCL
//COBOL.SYSIN  DD  DSN=Z83573.COBOL.SOURCE(SPEL),DISP=SHR
//*--------------------------
//* Step 2 - Run the Program
//*--------------------------
//RUNP     EXEC PGM=COBOL,REGION=4M
//STEPLIB  DD DISP=SHR,DSN=Z83573.LOAD
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//GAMELOG  DD DSN=Z83573.LUCKYZ.LOG.&SYSJOBID,
//            DISP=(NEW,CATLG,DELETE),
//            SPACE=(TRK,(1,1)),
//            DCB=(RECFM=FB,LRECL=80)
//SYSIN    DD *
0010
1
Y
0010
2
Y
1000
1
N
/*
