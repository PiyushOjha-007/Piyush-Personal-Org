@RestResource(urlMapping='/ProductDataService/*')
global with sharing class ProductDMLRestService {
    
    
    @HttpPost
    global static String insertProductRecords()
    {
        String strRequestbody;
        try
        {
            strRequestBody = RestContext.request.requestBody.toString();
            if(String.isNotEmpty(strRequestBody))
            {
                System.debug('strRequestBody');
                ProductDataWrapper objProduct  = (ProductDataWrapper)System.JSON.deserialize(strRequestBody, ProductDataWrapper.class);
                System.debug('objProduct'+objProduct.Cost);
                System.debug('objProduct name '+objProduct.Name);
                return 'Piyush Ojha';
            }
            else
            {
                return 'Sorry!!!';
            }
        }
        catch(Exception e)
        {
            System.debug('Exception '+e+' Line Number '+e.getLineNumber());
        }
        return null;
    }
    global class ProductDataWrapper
    {
        String name;
        Double Cost;
        String FoodCategory;
    }
}