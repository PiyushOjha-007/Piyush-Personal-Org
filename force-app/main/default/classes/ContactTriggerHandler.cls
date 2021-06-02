public class ContactTriggerHandler
{
    /* public static void countTotalNoOfContact(List<Contact> lstOfNewContact,List<Contact> lstOfOldContact)
{
try
{
Set<ID> setOfAccountId = new Set<Id>();
List<Account> lstOfUpdatedAccount = new List<Account>();
List<Contact> lstOfContact = Trigger.isDelete ? lstOfOldContact : lstOfNewContact;
system.debug('lstOfContact'+lstOfContact);
for(Contact objContact : lstOfContact)
{
setOfAccountId.add(objContact.AccountId);
}
if(!setOfAccountId.isEmpty())
{
for(Account acc : [Select id , (Select id from Contacts) from Account where ID IN : setOfAccountId])
{
List<Contact> lstOfSize = acc.Contacts;
system.debug('acc'+acc+'Size');
Account objAcc = new Account(id=acc.Id);
objAcc.Total_Contact_Associated__c = lstOfSize.size();
lstOfUpdatedAccount.add(objAcc);
}
}
System.debug('lstOfUpdatedAccount'+lstOfUpdatedAccount);
Database.update(lstOfUpdatedAccount);
}
catch(Exception e)
{
system.debug('Exception'+e+'Line : '+e.getLineNumber());
}
}
public static void calculateContactAmount(List<Contact> lstOfNewContact)
{
try
{
Set<ID> setOfAccountId = new Set<Id>();
List<Account> lstOfUpdatedAccount = new List<Account>();

system.debug('lstOfNewContact'+lstOfNewContact);
for(Contact objContact : lstOfNewContact)
{
setOfAccountId.add(objContact.AccountId);
}
if(!setOfAccountId.isEmpty())
{
for(Account accObj : [Select id,Rollup_Amount_X__c,Rollup_Amount_Y__c,Rollup_Amount__c,(Select Amount_X__c,Amount_Y__c,Amount_Type__c from Contacts) from Account where ID IN : setOfAccountId])              
{
Account acc = new Account(id=accObj.id);
acc.Rollup_Amount_X__c = 0;
acc.Rollup_Amount_Y__c = 0;
for(Contact objCon : accObj.contacts)
{

if(objCon.Amount_Type__c == 'Positive')
{
acc.Rollup_Amount_X__c = acc.Rollup_Amount_X__c + objCon.Amount_X__c;
}
else
{
acc.Rollup_Amount_Y__c = acc.Rollup_Amount_Y__c + objCon.Amount_Y__c;
}
acc.Rollup_Amount__c = acc.Rollup_Amount_X__c+ acc.Rollup_Amount_Y__c;
}
lstOfUpdatedAccount.add(acc);
}
}
system.debug('lstOfUpdatedAccount'+lstOfUpdatedAccount);
if(lstOfUpdatedAccount != null)
{
Database.upsert(lstOfUpdatedAccount);
}
}
catch(Exception e)
{
system.debug('Exception'+e+'Line : '+e.getLineNumber());
}
} */
    
    public static void updateContactOnAccount(List<Contact> conListNew , Map<Id,Contact> mapOfOldContact)
    {
        set<id> setOfAccId = new Set<ID>();
        Map<Id,Contact> mapOfAccContact = new map<Id,contact>();
        List<Account> accList = new List<Account>();   
        if(conListNew != null)
        {
            for(Contact objContact : conListNew)
            {
                setOfAccId.add(objContact.AccountId);
                mapOfAccContact.put(objContact.AccountId,objContact);
            }
        }
        else
        {
            for(Contact objContact : mapOfOldContact.values())
            {
                setOfAccId.add(objContact.AccountId);
                mapOfAccContact.put(objContact.AccountId,objContact);
            }
        }
        
        if(setOfAccId != null && setOfAccId.size() > 0)
        {
            for(AggregateResult ar : [Select count(id) totalCount,accountId,Sum(Amount_X__c) amountX, Sum(Amount_Y__c) amountY  from Contact where AccountId IN : setOfAccId group by AccountId ])
            {
                System.debug(' Account Id'+ar.get('accountId'));
                
                    Account acc = new Account(Id = (Id)ar.get('accountId'));
                    acc.Total_Contact_Associated__c = (Integer)ar.get('totalCount');
                    acc.Rollup_Amount_X__c = (Double)ar.get('amountX');
                    Double amtX = (Double)ar.get('amountX');
                    acc.Rollup_Amount_Y__c = (Double)ar.get('amountY');
                    Double amtY = (Double)ar.get('amountY');
                    acc.Rollup_Amount__c =    amtX + amtY;
                    accList.add(acc);
                
                
            }
        }
        System.debug('accList'+accList);
        if(accList != null)
        {
            Database.update(accList);
        }
    }
}