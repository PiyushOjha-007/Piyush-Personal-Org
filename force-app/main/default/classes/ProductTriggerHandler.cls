public class ProductTriggerHandler {
    
    @future(callout=true)
    public static void insertProductDummyRecords(Set<Id> setOfInsertedProductIds)
    {
        List<Product_Dummy__c> lstOfProdDummyTobeInserted = new List<Product_Dummy__c>();
        if(setOfInsertedProductIds != null && setOfInsertedProductIds.size() > 0)
        {
            for(Product2 prod : [Select Id,IsActive,Cost__c,Current_Inventory__c,CreatedById,DisplayUrl,ExternalDataSourceId	,ExternalId,Food_Category__c,Initial_Inventory__c,LastModifiedById,Lifespan_Months__c,Maintenance_Cycle__c,ProductCode,Description,Family,Product_Image__c,Name,StockKeepingUnit,Quantity_Ordered__c,Quantity_Remaining__c,QuantityUnitOfMeasure,Replacement_Part__c,Warehouse_SKU__c from Product2 where Id In :setOfInsertedProductIds ])
            {
                Product_Dummy__c prodDummy = new Product_Dummy__c();
                prodDummy.Name = prod.name;
                prodDummy.IsActive__c = prod.IsActive;
                prodDummy.Food_Category__c = prod.Food_Category__c;
                prodDummy.Product2_SFDC_ID__c = prod.Id;
                prodDummy.Product_Image__c = prod.Product_Image__c;
                prodDummy.Initial_Inventory__c = prod.Initial_Inventory__c;
                prodDummy.Lifespan_Months__c = prod.Lifespan_Months__c;
                prodDummy.Maintenance_Cycle_Days__c = prod.Maintenance_Cycle__c;
                prodDummy.Product_Code__c = prod.ProductCode;
                prodDummy.Product_Description__c = prod.Description;
                prodDummy.Product_Family__c = prod.Family;
                prodDummy.Product_SKU__c = prod.StockKeepingUnit;
                lstOfProdDummyTobeInserted.add(prodDummy);
                
            }
            if(lstOfProdDummyTobeInserted != null && lstOfProdDummyTobeInserted.size() > 0)
            {
                System.debug('lstOfProdDummyTobeInserted'+lstOfProdDummyTobeInserted);
                Database.insert(lstOfProdDummyTobeInserted);
            }
        }
    }
    
    @future(callout=true)
    public static void updateProductDummyRecords(set<Id> setOfUpdatedProductIds)
    {
        List<Product_Dummy__c> lstOfProdDummyTobeUpdated = new List<Product_Dummy__c>();
        Map<Id,Product2> mapOfIdAndProduct = new Map<Id,Product2>();
        system.debug('setOfUpdatedProductIds'+setOfUpdatedProductIds);
        for(Product2 prod : [Select Id,IsActive,Cost__c,Current_Inventory__c,CreatedById,DisplayUrl,ExternalDataSourceId	,ExternalId,Food_Category__c,Initial_Inventory__c,LastModifiedById,Lifespan_Months__c,Maintenance_Cycle__c,ProductCode,Description,Family,Product_Image__c,Name,StockKeepingUnit,Quantity_Ordered__c,Quantity_Remaining__c,QuantityUnitOfMeasure,Replacement_Part__c,Warehouse_SKU__c from Product2 where Id In :setOfUpdatedProductIds ])
        {
            mapOfIdAndProduct.put(prod.Id, prod);     
        }
        
        if(mapOfIdAndProduct != null && mapOfIdAndProduct.size() > 0)
        {
            for(Product_Dummy__c objProd : [Select id,Product2_SFDC_ID__c from Product_Dummy__c where Product2_SFDC_ID__c IN : mapOfIdAndProduct.keySet() ])
            {
                
                Product_Dummy__c prodDummy = new Product_Dummy__c(Id = objProd.Id);
                prodDummy.Name = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).name;
                prodDummy.IsActive__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).IsActive;
                prodDummy.Food_Category__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).Food_Category__c;
                prodDummy.Product_Image__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).Product_Image__c;
                prodDummy.Initial_Inventory__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).Initial_Inventory__c;
                prodDummy.Lifespan_Months__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).Lifespan_Months__c;
                prodDummy.Maintenance_Cycle_Days__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).Maintenance_Cycle__c;
                prodDummy.Product_Code__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).ProductCode;
                prodDummy.Product_Description__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).Description;
                prodDummy.Product_Family__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).Family;
                prodDummy.Product_SKU__c = mapOfIdAndProduct.get(objProd.Product2_SFDC_ID__c).StockKeepingUnit;
                lstOfProdDummyTobeUpdated.add(prodDummy);
            }
        }
        if(lstOfProdDummyTobeUpdated != null && lstOfProdDummyTobeUpdated.size() > 0)
        {
            System.debug('lstOfProdDummyTobeUpdated'+lstOfProdDummyTobeUpdated);
            Database.update(lstOfProdDummyTobeUpdated);
        }
    }
    @future(callout=true)
    public static void deleteProductDummyRecords(set<Id> setOfDeletedProductIds)
    {
        List<Product_Dummy__c> lstOfProdDummyTobeDeleted = new List<Product_Dummy__c>();
        for(Product_Dummy__c objProd : [Select id,Product2_SFDC_ID__c from Product_Dummy__c where Product2_SFDC_ID__c IN :setOfDeletedProductIds ])
        {
            System.debug('objProd'+objProd);
            Product_Dummy__c prodDum = new Product_Dummy__c(Id = objProd.Id);
            lstOfProdDummyTobeDeleted.add(prodDum);
        }
        if(lstOfProdDummyTobeDeleted != null && lstOfProdDummyTobeDeleted.size() > 0)
        {
            System.debug('lstOfProdDummyTobeDeleted'+lstOfProdDummyTobeDeleted);
            Database.delete(lstOfProdDummyTobeDeleted);
        }
    }
    
}