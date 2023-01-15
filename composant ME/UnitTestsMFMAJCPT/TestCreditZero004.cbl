       copy "mfunit_prototypes.cpy".
       
       identification division.
       program-id. TestCreditZero004.

       environment division.
       configuration section.

       data division.
       working-storage section.
       78 TEST-TestCreditZero004 value "TestCreditZero004".
       copy "mfunit.cpy".
       procedure division.

       entry MFU-TC-PREFIX & TEST-TestCreditZero004.
           *> Test code goes here.
           goback returning MFU-PASS-RETURN-CODE
           .

      $region Test Configuration

       entry MFU-TC-SETUP-PREFIX & TEST-TestCreditZero004.
           goback returning 0.

       entry MFU-TC-TEARDOWN-PREFIX & TEST-TestCreditZero004.
           goback returning 0.

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-TestCreditZero004.
           move "This is a example of a dynamic description"
               to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,dynmeta" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback.

      $end-region

       end program TestCreditZero004.
