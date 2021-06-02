trigger AccountTrigger on Account (after update) {
    
    List<Account> lstAcc = [Select id,name,industry from Account where Industry = 'Energy' AND ID IN : Trigger.new];
    
    for(Account acc : lstAcc)
    {
        acc.Industry = 'Apparel';
    }
  update lstAcc;
}