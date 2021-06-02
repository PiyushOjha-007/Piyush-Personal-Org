public class ProductTriggerSequenceController {

    public static void ProductAfterInsertController(set<Id> setOfInsertedProductIds)
    {
        try
        {
            System.debug('Inside Insert Trigger');
            ProductTriggerHandler.insertProductDummyRecords(setOfInsertedProductIds);
        }
        catch(Exception e)
        {
            System.debug('Exception'+e+' at Line '+e.getLineNumber());
        }
    }
    public static void ProductAfterUpdateController(set<Id> setOfUpdatedProductIds)
    {
        try
        {
            System.debug('Inside Update Trigger');
            ProductTriggerHandler.updateProductDummyRecords(setOfUpdatedProductIds);
        }
        catch(Exception e)
        {
            System.debug('Exception'+e+' at Line '+e.getLineNumber());
        }
    }
    public static void ProductAfterDeleteController(set<Id> setOfDeletedProductIds)
    {
        try
        {
            System.debug('Inside Delete Trigger'+setOfDeletedProductIds);
            ProductTriggerHandler.deleteProductDummyRecords(setOfDeletedProductIds);
        }
        catch(Exception e)
        {
            System.debug('Exception'+e+' at Line '+e.getLineNumber());
        }
    }
    
}