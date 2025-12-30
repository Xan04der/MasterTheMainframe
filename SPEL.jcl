//SPELJOB     JOB ,'Your Name',CLASS=A,MSGCLASS=A,MSGLEVEL=(1,1)
//*-------------------------------------
//*  Step 1 - Compile the COBOL Program
//*-------------------------------------
//COBOL    EXEC IGYWCL
//COBOL.SYSIN  DD  DSN=Z00000.COBOL.SOURCE(SPEL),DISP=SHR
//*--------------------------
//* Step 2 - Run the Program
//*--------------------------
//RUNP     EXEC PGM=COBOL,REGION=4M
//STEPLIB  DD DISP=SHR,DSN=Z00000.LOAD
//SYSOUT   DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
//GAMELOG  DD DSN=Z00000.LUCKYZ.LOG.&SYSJOBID,
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
//* In SYSIN at step 2 the first number in your bet amount. This cannot be higher than 100.
//* The second number is your choice of even(1) or odd(2)
//* Then the last thing is wheter you want to continue or not (Y or N)
//* Remember to put in your ZId
