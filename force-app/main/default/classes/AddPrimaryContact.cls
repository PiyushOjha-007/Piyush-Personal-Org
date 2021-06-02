public class AddPrimaryContact implements Queueable {

    private Contact con1;
    private String state1;
    
    public AddPrimaryContact(Contact con, String state) {
        this.con1 = con;
        this.state1 = state;
    }
    public void execute(QueueableContext context) {
        List<Contact> lstOfCon = new List<Contact>();
        for(Account acc : [Select id,name from Account where BillingState =:state1 ])
        {
            Contact cn = con1.clone(false,false,false,false);
            cn.AccountId = acc.Id;
           // cn.LastName = 'Contact'+acc.name;
            lstOfCon.add(cn);
        }
        database.insert(lstOfCon);
        }
}