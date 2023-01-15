       copy "mfunit_prototypes.cpy".
       
       identification division.
       program-id. TestCreditPositifnb002.

       environment division.
       configuration section.

       data division.
       working-storage section.
       78 TEST-TestCreditPositifnb002 value "TestCreditPositifnb002".
       copy "mfunit.cpy".
       procedure division.

       entry MFU-TC-PREFIX & TEST-TestCreditPositifnb002.
           *> Test code goes here.
           goback returning MFU-PASS-RETURN-CODE
           .

      $region Test Configuration

       entry MFU-TC-SETUP-PREFIX & TEST-TestCreditPositifnb002.
           goback returning 0.

       entry MFU-TC-TEARDOWN-PREFIX & TEST-TestCreditPositifnb002.
           goback returning 0.

       entry MFU-TC-METADATA-SETUP-PREFIX & TEST-TestCreditPositifnb002.
           move "This is a example of a dynamic description"
               to MFU-MD-TESTCASE-DESCRIPTION
           move 10000 to MFU-MD-TIMEOUT-IN-MS
           move "smoke,dynmeta" to MFU-MD-TRAITS
           set MFU-MD-SKIP-TESTCASE to false
           goback.

      $end-region

       end program TestCreditPositifnb002.
