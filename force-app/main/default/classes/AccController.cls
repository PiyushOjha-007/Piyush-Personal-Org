public with Sharing class AccController {

    
    @AuraEnabled
    public static List<Account> getAccounts(){
        
        List<Account> acc = [Select id,Name,Email__c,HeadOfficeCountry__c,Phone,Website from Account ];
        return acc;
    }
}