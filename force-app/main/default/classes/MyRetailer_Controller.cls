public class MyRetailer_Controller {
    
    @AuraEnabled 
    public static List<pizza__c> getAllPizza()
    {
        return [Select id,Drink__c,Pizza_Image__c,Name,Pizza_Size__c,Pizza_Toppings__c,Pizza_Type__c,Price__c from pizza__c];
    }
    
    @AuraEnabled 
    public static ContactWrapperClass getAllAssociatedDrinks(ID currentPizza)
    {
        List<String> lstOfDrinkName =new List<String>();
        system.debug('currentPizza'+currentPizza);
         for(Pizza__c objPizza : [Select id,Drink__r.Name,Drink__r.Drink_Image__c,Drink__r.Price__c from pizza__c where id=: currentPizza])
         {
             lstOfDrinkName.add(objPizza.Drink__c);
         }
        system.debug('lstOfDrinkName'+lstOfDrinkName);
        
            ContactWrapperClass objWrapper = new ContactWrapperClass();
            objWrapper.lstOfPizzaDrinks = [Select id,Name,Drink_Image__c,Price__c from Drink__c where Id IN :lstOfDrinkName];      
        system.debug('ContactWrapperClass getAllAssociatedDrinks objWrapper:'+objWrapper);
            return objWrapper;
            
        
        
         
    }
    
    @AuraEnabled 
    public static List<Drink__c> getAllDrink()
    {
        return [Select id,Name,Drink_Image__c,Price__c from Drink__c];
    }
    
    @AuraEnabled 
    public static ContactWrapperClass fetchSubsDetail(String phoneNumber)
    {
        List<Contact> lstOfContact = new List<Contact>();
        List<My_Orders__c> lstOfMyOrders = new List<My_Orders__c>();
        
        lstOfMyOrders = [Select Name,Selected_Pizzas__c,createdDate,Contact__c,Order_Amount__c,Contact__r.name,Contact__r.phone from My_Orders__c where Contact__r.phone =:phoneNumber ];
        lstOfContact = [Select Name,AccountId,Email,Total_Orders_and_Transactions__c,Total_Amount_Spent__c,Subscription_End_Date__c,Subscription_Term__c from Contact where Phone =:phoneNumber and AccountId='0017F000026PR81QAG' ];
        system.debug('lstOfContact:'+lstOfContact);
        system.debug('lstOfContact Size : '+lstOfContact.size());
        
        ContactWrapperClass objWrapper = new ContactWrapperClass();
        objWrapper.lstContact = lstOfContact;
        objWrapper.lstOfMyOrders = lstOfMyOrders;
        return objWrapper;
        
    }
    
    
    @AuraEnabled
    public static Mainten__mdt getDownTimeRecords()
    {
        List<Maintenance__c> lstOfMaintenance =  new List<Maintenance__c>();
        Mainten__mdt objMaintain = [Select id,Active__c,Downtime__c,End_Time__c,Start_Time__c from Mainten__mdt where Active__c = true];
        return objMaintain;
    }
    
    @AuraEnabled
    public static boolean assignAccount(Id contactId) 
    {
        Contact objCon = new Contact(Id=contactId,AccountId='0017F000026PR81QAG');
        if(objCon != null)
        {
            update objCon;
            return true;
        }
        return false;
    }
    @AuraEnabled
    public static List<My_Orders__c> addOrderInContact(List<Pizza__c> selectedPizza,ID contactId) 
    {
        List<Pizza__c> PizzaList = new List<Pizza__c>();
        List<My_Orders__c> lstOfOrder = new List<My_Orders__c>();
        system.debug('selectedPizza'+selectedPizza+'contactId'+contactId);
        for(Pizza__c objPizza : selectedPizza)
        {
            Pizza__c newPizza = new Pizza__c(id=objPizza.id);
            newPizza.Contact__c = contactId;
            PizzaList.add(newPizza);
        }
        system.debug('PizzaList'+PizzaList);
        if(PizzaList != null && PizzaList.size() > 0)
        {
            Database.update(PizzaList);
        }
        
        if(selectedPizza != null && selectedPizza.size() > 0 && contactId != null)
        {
            String selectedPizzahere='';
            Decimal totalAmount = 0;
            for(Pizza__c objPizza : selectedPizza)
            {
                totalAmount = totalAmount + objPizza.Price__c;
                selectedPizzahere = selectedPizzahere +' , '+ objPizza.Name;
            }
            My_Orders__c newOrder = new My_Orders__c();
            newOrder.Contact__c = contactId;
            newOrder.Selected_Pizzas__c = selectedPizzahere;
            newOrder.Order_Amount__c = totalAmount;
            lstOfOrder.add(newOrder);
            
        }
        system.debug('lstOfOrder'+lstOfOrder);
        if(lstOfOrder != null && lstOfOrder.size() > 0)
        {
            Database.insert(lstOfOrder);
            return lstOfOrder;
        }
        
        return null;
    }
    
    
    @AuraEnabled 
    public static List<My_Orders__c> fetchAllOrder()
    {
        return [Select id,name,createddate,Contact__r.Name, Selected_Pizzas__c ,Order_Amount__c from My_Orders__c];
    }
    
    public class ContactWrapperClass{
        @AuraEnabled public List<contact> lstContact{get;set;}
        @AuraEnabled public List<My_Orders__c> lstOfMyOrders{get;set;}
        @AuraEnabled public Integer contactCount{get;set;}
        @AuraEnabled public List<Drink__c> lstOfPizzaDrinks{get;set;}
        
    }
    
}