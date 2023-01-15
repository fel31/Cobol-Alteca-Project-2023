       copy "mfunit_prototypes.cpy".
       
       identification division.
       program-id. TestDebitZero005.

       environment division.
       configuration section.

       data division.
       working-storage section.
       
       
       
       78 TEST-TestDebitZero005 value "TestDebitZero005".
       copy "mfunit.cpy".
       procedure division.
       
           
       entry MFU-TC-PREFIX & TEST-TestDebitZero005.
         
           goback returning MFU-PASS-RETURN-CODE
           .

      $region Test Configuration

      
           goback.

      $end-region

       end program TestDebitZero005.
