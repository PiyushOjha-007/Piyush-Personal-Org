@isTest (SeeAllData=false)
private class OrderTests {
    
    @testSetup
    static void SetupTestData() {
        TestDataFactory.InsertTestData(5);
    }
 
    @isTest 
    private static void OrderExtension_UnitTest() {
        Test.startTest();
        PageReference pageRef = Page.OrderEdit;
        Test.setCurrentPage(pageRef);
        SetupTestData();
        ApexPages.StandardController stdcontroller = new ApexPages.StandardController(TestDataFactory.orders[0]);        
        OrderExtension ext = new OrderExtension(stdcontroller);        
           System.assertEquals(Constants.DEFAULT_ROWS, ext.orderItemList.size());
        ext.OnFieldChange();
        ext.SelectFamily();
        ext.Save();
        ext.First();
        ext.Next();
        ext.Previous();
        ext.Last();
        ext.GetHasPrevious();
        ext.GetHasNext();
        ext.GetTotalPages();
        ext.GetPageNumber();
        List<SelectOption> options = ext.GetFamilyOptions();
        
        Test.stopTest();
    }
    
@isTest
private static void OrderUpdate_UnitTest(){
     
   
    Test.startTest();
    SetupTestData();
    List<Order> orders = TestDataFactory.orders;
    for (Order o : orders){
        o.Status = Constants.ACTIVATED_ORDER_STATUS;
    }
    List<Product2> oldProducts = TestDataFactory.pros;
    Set<Id> productIds = new Set<Id>();
    for (Product2 oldProd : oldProducts){
        productIds.add(oldProd.Id);
    }
    oldProducts = [SELECT Id, Quantity_Ordered__c FROM Product2 WHERE ID IN :productIds];
    Map<Id, Integer> quantities = new Map<Id, Integer>();
    for (OrderItem oi : TestDataFactory.orderItems){
        Integer quantity = 0;
        List<PricebookEntry> pricebookentries = TestDataFactory.enteries;
        for (PricebookEntry pbe : pricebookentries){
            if (oi.PricebookEntryId == pbe.Id){                
                if (quantities.containsKey(pbe.Product2Id)){
                    quantity = quantities.get(pbe.Product2Id);
                }
                quantity += (Integer)oi.Quantity;
                quantities.put(pbe.Product2Id, quantity);
                break;
            }
        }
    }
   
    CollaborationGroup c=new CollaborationGroup();
        c.Name='Test Inventory Announcements';
        c.Description='test';
        //c.OwnerId=[Select Id from Account Limit 1].Id;
        c.CollaborationType='public';
        insert c;
    
    update orders;
    Map<Id, Product2> currentProducts = new Map<Id, Product2>([Select Id, Quantity_Ordered__c FROM Product2 WHERE Id IN :productIds]);
  
    for (Product2 prod : oldProducts){
      
        TestDataFactory.VerifyQuantityOrdered(prod, currentProducts.get(prod.Id), quantities.get(prod.Id));
  }
  Test.stopTest();
}
}