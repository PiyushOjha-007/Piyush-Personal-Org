public without sharing class OrderHelper {

    /**
     * @name AfterUpdate
     * @description 
     * @param List<Order> newList
     * @param List<Order> oldList
     * @return void
    **/
    public static List<Double> check =new List<Double>();
    public Static List<Product2> pr;
    public static void AfterUpdate(List<Order> newList, List<Order> oldList){
        
        Set<Id> orderIds = new Set<Id>();
        for ( Integer i=0; i<newList.size(); i++ ){
            if ( newList[i].Status == Constants.ACTIVATED_ORDER_STATUS && oldList[i].Status == Constants.DRAFT_ORDER_STATUS ){
                orderIds.add(newList[i].Id);
            }
        }
        
        RollUpOrderItems(orderIds);
    }

    /**
     * @name RollUpOrderItems
     * @description Given a set of Activated Order ids, query the child Order Items and related Products to calculate Inventory levels
     * @param Set<Id> activatedOrderIds
     * @return void
    **/
    public static void RollUpOrderItems(Set<Id> activatedOrderIds){
        
        //ToDo: Declare a Map named "productMap" of Ids to Product2 records
        Map<ID,Product2> productMap =new Map<ID,Product2>();
        List<OrderItem> orderId =[Select OrderID,Product2Id from OrderItem where OrderId IN: activatedOrderIds];
        
        //ToDo: Loop through a query of OrderItems related to the activatedOrderIds
        for(OrderItem o: orderId){
            //ToDo: Populate the map with the Id of the related Product2 as the key and Product2 record as the value
            Product2 p= [select name,Quantity_Ordered__c from Product2 where Id=: o.Product2Id];
            productmap.put(o.Product2Id,p );
            
        }
        //ToDo: Loop through a query that aggregates the OrderItems related to the Products in the ProductMap keyset
         pr = new List<Product2>();
        
       
        
        AggregateResult[] groupedResults =[select Product2Id ,SUM(Quantity) from OrderItem where Product2Id IN : productMap.keySet() group by Product2Id];
    
            for(AggregateResult ag: groupedResults){
                
               Product2 p= productmap.get((Id)ag.get('Product2Id'));
               p.Quantity_Ordered__c =(Double)ag.get('expr0');
               pr.add(p);
               check.add((Double)ag.get('expr0'));
               
               
            }
        
            update pr;
        
                 

        //ToDo: Perform an update on the records in the productMap
    }

}