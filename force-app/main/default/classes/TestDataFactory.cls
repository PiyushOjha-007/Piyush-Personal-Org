public with sharing class TestDataFactory {

    /**
     * @name ConstructCollaborationGroup
     * @description
    **/
    public static List<Product2> pros;
    public static List<PricebookEntry> enteries;
    public static List<Account> acts;
    public static  List<Contact> contacts;
    public static  List<Order> orders;
    public static List<OrderItem> orderItems;
    static CollaborationGroup nameGroup=new CollaborationGroup ();
    public static CollaborationGroup ConstructCollaborationGroup(){
        //String nameGroup=TEST+Constants.INVENTORY_ANNOUNCEMENTS;
         
        //ToDo: Ensure this method returns a single Chatter CollaborationGroup
        //    whose Name starts with 'TEST' followed by the INVENTORY_ANNOUNCEMENTS constant
        //    and configured so anyone can join, see and post updates.
        nameGroup.CollaborationType='Public';
        nameGroup.Name='TEST'+Constants.INVENTORY_ANNOUNCEMENTS;
        return nameGroup;
    }

    /**
     * @name CreateProducts
     * @description Constructs a list of Product2 records for unit tests
    **/
    public static List<Product2> ConstructProducts(Integer cnt){
        List<Product2> pros=new List<Product2>();
               
        Integer picklistSize=Constants.PRODUCT_FAMILY.size();
        System.debug(picklistSize+''+Constants.PRODUCT_FAMILY[0].getValue());
        Integer j=0;
        for(Integer i=0;i<cnt;i++){
            Product2 p=new Product2();
            p.Name='ProductConstruction'+i;
            p.IsActive=true;
            p.Initial_Inventory__c =10;
            p.Family=Constants.PRODUCT_FAMILY[j].getValue();
            if(j==picklistSize-1){
                j=0;
            }else{
            j++;
            }
            pros.add(p);
        }
        System.debug('before insert '+pros);
       // insert pros;
        System.debug('after insert '+pros);
        return pros;
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Product2 records
        //  with all the required fields populated
        //  and IsActive = true
        //  an Initial Inventory set to 10
        //  and iterating through the product family picklist values throughout the list.
    }


    /**
     * @name CreatePricebookEntries
     * @description Constructs a list of PricebookEntry records for unit tests
    **/
    public static List<PricebookEntry> ConstructPricebookEntries(List<Product2> prods){
        List<PriceBookEntry> priceBooks= new List<PriceBookEntry>();
        
        for(product2 p:prods){
            PricebookEntry pbe=new PricebookEntry();
            pbe.UnitPrice=(Decimal)100;
            pbe.IsActive=true;
            pbe.Product2Id=p.Id;
            pbe.Pricebook2Id=Constants.STANDARD_PRICEBOOK_ID;
            
            priceBooks.add(pbe);
        }
            
        if(priceBooks!=null && !priceBooks.isEmpty()) {
              //insert priceBooks;
        }
        return priceBooks;

        //ToDo: Ensure this method returns a corresponding list of PricebookEntries records
        //  related to the provided Products
        //  with all the required fields populated
        //  and IsActive = true
        //  and belonging to the standard Pricebook
    }

    /**
     * @name CreateAccounts
     * @description Constructs a list of Account records for unit tests
    **/
    public static List<Account> ConstructAccounts(Integer cnt){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Account records
        //  with all of the required fields populated.
        List<Account> acts=new List<Account>();
        Integer i=0;
        for(Integer j=0;j<cnt;j++){
            Account a=new Account();
            a.Name='Account'+i;
            a.Rating='Hot';
            i++;
            acts.add(a);
        }
        //insert acts;
        return acts;
    }

    /**
     * @name CreateContacts
     * @description Constructs a list of Contacxt records for unit tests
    **/
    public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Contact records
        //  related to the provided Accounts
        //  with all of the required fields populated.
        List<Contact> contacts=new List<Contact>();
        Integer i=0;
        for(Integer j=0;j<cnt;j++){
            Contact c=new Contact();
            c.AccountId=accts.get(i).Id;
            c.LastName='Contact'+i;
            i++;
            contacts.add(c);
        }
        //insert contacts;
        return contacts;
    }

    /**
     * @name CreateOrders
     * @description Constructs a list of Order records for unit tests
    **/
    public static List<Order> ConstructOrders(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Order records
        //  related to the provided Accounts
        //  with all of the required fields populated.
        List<Order> orders=new List<Order>();
        Integer i=0;
        for(Integer j=0;j<cnt;j++){
          Contract c=new Contract(AccountId=accts.get(i).Id,Status='Draft',StartDate =date.today(),ContractTerm =12);
          Order o=new Order();
          o.AccountId=accts.get(i).Id;
          o.EffectiveDate=date.today();
          o.Pricebook2Id=Constants.STANDARD_PRICEBOOK_ID;
          o.ContractId=c.Id ;
          o.Status='Draft';
          
          i++;
            orders.add(o);
        }
        //insert orders;
        return orders;
    }

    /**
     * @name CreateOrderItems
     * @description Constructs a list of OrderItem records for unit tests
    **/
    public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords){
        //ToDo: Ensure this method returns a list of size cnt of OrderItem records
        //  related to the provided Pricebook Entries
        //  and related to the provided Orders
        //  with all of the required fields populated.
        //  Hint: Use the DEFAULT_ROWS constant for Quantity as it will be used in the next challenge
        List<OrderItem> items=new List<OrderItem>();
        Integer i=0;
        for(Integer j=0;j<cnt;j++){
            OrderItem oi=new OrderItem();
            oi.Quantity=Constants.DEFAULT_ROWS;
            oi.PricebookEntryId=pbes.get(i).Id;
            System.debug('pricebook'+oi.PricebookEntryId+' '+pbes.get(i).Id);
            oi.OrderId=ords.get(i).Id;
            oi.UnitPrice=(Decimal)100;
            i++;
            items.add(oi);
        }
        //insert items;
        return items;
    }

    /**
     * @name SetupTestData
     * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
    **/
    public static void InsertTestData(Integer cnt){
        //ToDo: Ensure this method calls each of the construct methods
        //  and inserts the results for use as test data.
        //CollaborationGroup cg=ConstructCollaborationGroup();
       // List<CollaborationGroup> cgroup=[Select Name from CollaborationGroup where Name=: 'Inventory Announcements'];
        //if(cgroup.size()==0){
        //    insert cg;
       // }
        
        pros=ConstructProducts(cnt);
           insert pros;
        enteries=ConstructPricebookEntries(pros);
        insert enteries;
        acts=ConstructAccounts(cnt);
        insert acts;
       contacts=ConstructContacts(cnt,acts);
        insert contacts;
       orders=ConstructOrders(cnt,acts);
            insert orders;
        System.debug('TestFactory'+orders);
        orderItems=ConstructOrderItems(cnt,enteries,orders);      
       insert orderItems;
        
       
    }
    public static void VerifyQuantityOrdered(Product2 originalProduct, Product2 updatedProduct, Integer qtyOrdered) {
     System.assertEquals(updatedProduct.Quantity_Ordered__c, (originalProduct.Quantity_Ordered__c + qtyOrdered));
}
    
}