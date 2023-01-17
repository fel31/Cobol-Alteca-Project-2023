       copy "mfunit_prototypes.cpy".
       
       identification division.
       program-id. TestDebitZero005.

       environment division.
       configuration section.

       data division.
       working-storage section.
       
       01 CPT-SOLDE-TEST pic 9(16).

       01 CPT-SOLDE        PIC S9(13)V9(2) USAGE COMP-3.
       01 ZF-MNTOPE PIC S9(11)V99 COMP-3.
       01 DEV-MTACHAT PIC 99.
       
       01 CodeOperation pic XXX.
        88 CodeDebit values 'PRL','RMB','VIR','RET','AGI','RDT'.
        88 CodeCredit values 'VER','VRD','INT','VVF'.
       
       
       78 TEST-TestDebitZero005 value "TestDebitZero005".
       copy "mfunit.cpy".
       procedure division.
       
           perform 01-Begin.
           perform 02-Treatment.
           perform 03-EndPgm.
           
       01-Begin.
           Move -1500 to  cpt-solde
           Move -1474.5 to cpt-solde-test
           Move 0.85 to dev-mtachat
           Move 30 TO zf-mntope
        
        
           Set codeCredit to true
           display 'codeOperation ' codeOperation
           .
           
       02-Treatment.
           if codeDebit
             compute cpt-solde = cpt-solde - (dev-mtachat * zf-mntope)
              display 'cpt-compte = ' cpt-solde
           end-if
           
           if codeCredit
               compute cpt-solde =
                       cpt-solde + (dev-mtachat * zf-mntope)
           end-if
           
           IF cpt-solde  = cpt-solde-test 
             
               display 'cpt-solde =  ' cpt-solde
               display 'cpt-solde-test = ' cpt-solde-test
               goback returning MFU-FAIL-RETURN-CODE
           ELSE
               goback returning MFU-PASS-RETURN-CODE  
           END-IF
           .


       
       03-EndPgm.
           goback.

       end program TestDebitZero005.
