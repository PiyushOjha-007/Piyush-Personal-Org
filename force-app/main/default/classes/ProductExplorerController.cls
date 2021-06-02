public with sharing class ProductExplorerController {
    
    @AuraEnabled(Cacheable=true)
    public static List<Product2> getAllProduct(){
        
        List<Product2> lstOfAllProdcut = [Select Id,Name,Cost__c,Food_Category__c,Description,Product_Image__c,Family from Product2];
        return lstOfAllProdcut;

    }
}