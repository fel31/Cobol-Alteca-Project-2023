       IDENTIFICATION DIVISION.
       PROGRAM-ID TESTSMF.

        DATA DIVISION.
       FILE SECTION.
       WORKING-STORAGE SECTION.
       01  TEST-CONTEXT.
           02  TESTS-RUN       PIC 9(2) VALUE ZEROES.
           02  PASSES          PIC 9(2) VALUE ZEROES.
           02  FAILURES        PIC 9(2) VALUE ZEROES.
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           DISPLAY "Running MFMAJCPT tests...".

           
           CALL 'MFMAJCPTests' USING TEST-CONTEXT.

           DISPLAY 'Tests run: ' TESTS-RUN.
           DISPLAY 'Passed: ' PASSES.
           DISPLAY 'Failed: ' FAILURES.

       END PROGRAM TESTSMF.


