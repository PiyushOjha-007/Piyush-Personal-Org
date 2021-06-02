@IsTest
public class AccountManagerTest {

    @isTest static void testGetAccount()
    {
         RestRequest request = new RestRequest();
        Account acc = new Account();
        acc.Name = 'Piyush';
        insert acc;
        
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Accounts/'+acc.Id+'/contacts';   
        request.httpMethod = 'GET';
        RestContext.request = request;
        
         Account accObj  = AccountManager.getAccount();
        // Verify results
        System.assert(accObj != null);
        System.assertEquals('Piyush', accObj.Name);
    }
}