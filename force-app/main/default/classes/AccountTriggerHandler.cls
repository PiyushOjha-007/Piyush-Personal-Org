public class AccountTriggerHandler {

    public static void updateEmployees(List<Account> accNew)
    {
        for(Account acc : accNew)
        {
            if(acc.NumberOfEmployees != null )
            {
                acc.NumberOfEmployees = acc.NumberOfEmployees + 1;
            }
        }
    }
   
}