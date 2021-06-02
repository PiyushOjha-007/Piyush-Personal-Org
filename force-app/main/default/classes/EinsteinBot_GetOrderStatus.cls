public with sharing class EinsteinBot_GetOrderStatus {

public class OrderOutput {
  @InvocableVariable(required=true)
  public String sOrderStatus;
}

public class OrderInput {
  @InvocableVariable(required=true)
  public String sOrderNumber;
}

@InvocableMethod(label='Get Order Status')
public static List<OrderOutput>  getOrderStatus(List<OrderInput> orderInputs) {
  Set<String> orderNumbers = new Set<String>(); 

  // Get the order numbers from the input
  for (OrderInput orderInput : orderInputs) {
    orderNumbers.add(orderInput.sOrderNumber);
  }

  // Get the order objects from the set of order numbers
  List<My_Orders__c> orders = [SELECT Name, Contact__c,Order_Amount__c,Selected_Pizzas__c FROM My_Orders__c where Name in :orderNumbers];
    
  // Create a map of order numbers and order status values
 /* Map<String, String> mapNameStatus = new Map<String, String>(); 
  if (orders.size() > 0) {
      for (Bot_Order__c order : orders) {
        mapNameStatus.put(order.Name, order.Status__c);
      }
  }
  
  // Build a list of order status values for the output
  List<OrderOutput> orderOutputs = new List<OrderOutput>();
  for (OrderInput orderInput : orderInputs) {
    OrderOutput orderOutput = new OrderOutput();
    
    // Do we have a status for this order number?
    if (mapNameStatus.containsKey(orderInput.sOrderNumber)) {
        // If so, then add the status
        orderOutput.sOrderStatus = mapNameStatus.get(orderInput.sOrderNumber);
    } else {
        // If not, then add an unknown status value
        orderOutput.sOrderStatus = 'Order not found';
    }
    orderOutputs.add(orderOutput);
  }*/
  List<OrderOutput> orderOutputs = new List<OrderOutput>();
  OrderOutput orderOutput = new OrderOutput();
  if(orders.size() > 0)
  {
    orderOutput.sOrderStatus = 'Order is in Process ! Thanks for waiting !!';
    orderOutputs.add(orderOutput);
    return orderOutputs;  
  }
  else
  {
orderOutput.sOrderStatus = 'Sorry We Could not find the Order !!';
    orderOutputs.add(orderOutput);
    return orderOutputs; 
    
  }
  }
}