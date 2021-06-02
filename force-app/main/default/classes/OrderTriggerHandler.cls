public class OrderTriggerHandler {
    
    public static void updateOrderWithInventory(List<Order> lstOfNewOrder)
    {
        List<Id> ListOfOrderId = new List<Id>();
        List<Product2> lstOfProduct = new List<Product2>();
        try
        {
            if(lstOfNewOrder != null)
        {
            for (Order o : lstOfNewOrder )
            {
                ListOfOrderId.add(o.id);	
                
            }
        }    
        for(OrderItem oi : [SELECT Id, Product2Id, Product2.Quantity_Ordered__c, Quantity FROM OrderItem WHERE Order.Status='Activated' AND Order.ActivatedDate != null AND OrderId In : ListOfOrderId])
        {
            Product2 p = oi.Product2;
            p.Quantity_Ordered__c -= oi.Quantity;
            lstOfProduct.add(p); 
             
        }
         if(lstOfProduct != null)
         {
             System.debug('Piyush lstOfProduct'+lstOfProduct);
             Database.update(lstOfProduct);
         }
        }
         catch(Exception e)
         {
             System.debug('Exception in OrderTriggerHandler '+e+ ' Line '+e.getLineNumber());
         }
    }	
}