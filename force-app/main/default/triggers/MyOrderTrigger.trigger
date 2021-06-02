trigger MyOrderTrigger on My_Orders__c (after insert) {

   List<My_Orders__c> lstOfOrders = trigger.new;
    List<Id> lstofContactId = new List<Id>();
    for(My_Orders__c objOrder : lstOfOrders)
    {
        lstofContactId.add(objOrder.Contact__c);
    }
    
     List<Contact> lstOfContact = new List<Contact>(); 
     Map<ID, Contact> mapOfContact = new Map<ID, Contact>([Select id,Total_Amount_Spent__c,Total_Orders_and_Transactions__c from Contact where Id In : lstofContactId]);
     AggregateResult[] groupedResults = [SELECT Contact__c, Count(Id) cnt,SUM(Order_Amount__c) amt FROM My_Orders__c where Contact__c in:lstofContactId group by Contact__c];

    for(AggregateResult Results: groupedResults)
    {
         Id ContactId =(id) Results.get('Contact__c');         
         Contact objCon = mapOfContact.get(ContactId);
         objCon.Total_Amount_Spent__c=(Double)Results.get('amt');
        objCon.Total_Orders_and_Transactions__c=(Integer)Results.get('cnt');
         lstOfContact.add(objCon);
    }
        if(lstOfContact != null && lstOfContact.size() > 0)
        {
            Database.update(lstOfContact);
        }
}