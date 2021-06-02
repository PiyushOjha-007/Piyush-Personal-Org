public class CaseTriggerHandler {
    
    public static void testErrorAndDML(List<case> newCaseList)
    {
       for(Case obj : newCaseList)
       {
           if(obj.Type == null || String.isBlank(obj.Type))
           {
               obj.addError('Type is Mandatory !');
           }
       }
    }

}