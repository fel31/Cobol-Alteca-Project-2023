       IDENTIFICATION DIVISION.
       PROGRAM-ID. ASSERT-EQUAL.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       LINKAGE SECTION.

       01  TEST-CONTEXT.
         02  TESTS-RUN       PIC 9(2) VALUE ZEROES.
         02  PASSES          PIC 9(2) VALUE ZEROES.
         02  FAILURES        PIC 9(2) VALUE ZEROES.
       
       01  TEST-NAME   PIC X(30).
       01  EXPECTED    PIC 9(4)V9(3).
       01  ACTUAL      PIC 9(4)V9(3).

       PROCEDURE DIVISION USING TEST-CONTEXT, TEST-NAME,
                                           EXPECTED, ACTUAL.
       MAIN-PROCEDURE.
           ADD 1 to TESTS-RUN.

           IF ACTUAL = EXPECTED THEN
               ADD 1 TO PASSES
           ELSE
               DISPLAY 'FAILED: ' TEST-NAME '. Expected '
               EXPECTED ' but was ' ACTUAL
               ADD 1 TO FAILURES.

           GOBACK.
       END PROGRAM ASSERT-EQUAL.


       