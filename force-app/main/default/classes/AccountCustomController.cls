public class AccountCustomController {

    private Account acc{get; private set;}
    public AccountCustomController()
    {
        Id id = ApexPages.currentPage().getParameters().get('id');
        acc	= (id==null)? new Account() : [select Name,AccountNumber,Email__c,Website,Phone,HeadOfficeCountry__c,AnnualRevenue,
                                   NumberOfEmployees   from Account where Id = : id];
    }
    public Account getAccount()
    {
        return acc;
    }
    public PageReference saveAccount()
    {
       Database.SaveResult saveResult = Database.insert(acc);
        if(saveResult.isSuccess())
        {
            System.debug('Account Inserted'+acc+' with '+saveResult);
        }
        else
        {
            acc.addError('Account not inserted ! !');
        }
        //PageReference pgRefer = new ApexPages.StandardController(Account).view;
        return null;
    }
}