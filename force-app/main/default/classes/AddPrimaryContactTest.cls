@isTest
public class AddPrimaryContactTest {

     static testmethod void testQueueable() {
         List<Account> lstOfacc = new List<Account>();
         for(integer i=0;i<=50;i++)
         {
             Account acc = new Account();
             acc.Name = 'acc'+i;
             acc.BillingState = 'CA';
             lstOfacc.add(acc);
         }
         insert lstOfacc;
         
         Contact co = new Contact();
         co.FirstName='demo';
         co.LastName ='demo';
         insert co;
         String state = 'CA';

         AddPrimaryContact obj = new AddPrimaryContact(co,state);
        Test.startTest();        
        System.enqueueJob(obj);
        Test.stopTest(); 
     }
}