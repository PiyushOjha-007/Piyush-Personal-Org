public class AccountDisplayController {

    @AuraEnabled
    public static List<Account> getAccList()
    {
        List<Account> lstOfAcc = [Select id,name,email__c,accountnumber,phone from Account limit 50];
        system.debug('lstOfAcc'+lstOfAcc);
        return lstOfAcc;
    }
    @AuraEnabled
    public static List<Contact> getContactList(String accID)
    {
        system.debug('accID'+accID);
        List<Contact> lstOfContacts = [Select id,name,Email,Phone from Contact where accountId =:accID];
        system.debug('lstOfContacts'+lstOfContacts);
        return lstOfContacts;
    }
}