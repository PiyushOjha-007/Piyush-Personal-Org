@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager 
{
   @HttpGet
   global static Account getAccount()
   {
       RestRequest request = RestContext.request;
       String[] acc = request.requestURI.split('/');
       String accId = acc[acc.size()-2];
       System.debug('AccountId'+accId);
        Account accObj =  [Select id,name,(select id from Contacts) from account where Id=: accId ];
        return accObj;
   }
}