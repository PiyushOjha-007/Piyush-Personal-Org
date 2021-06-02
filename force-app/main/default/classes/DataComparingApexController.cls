public class DataComparingApexController {

    @AuraEnabled
    public static List<SObject> processingDataToInsert()
    {
       Set<String> setOfGlobaIds = new Set<String>();
       List<SObject> lstOfDataToInsert = new List<SObject>();
       for(Ojha_Object__c obj : [ Select id,City__c,Fname__c,Enrollment__c,Global_Identifier__c from Ojha_Object__c])
        {
            setOfGlobaIds.add(obj.Global_Identifier__c);
        }
       for(Ojha_Staging_Object__c objStg : [Select id,Name,Lname__c,City__c,Fname__c,Enrollment__c,Global_Identifier__c from Ojha_Staging_Object__c where Global_Identifier__c NOT IN :setOfGlobaIds  ])
        {
            lstOfDataToInsert.add(objStg);
        } 
        System.debug('TO Be INSERTed lstOfDataToInsert'+lstOfDataToInsert);
        if(lstOfDataToInsert != null && lstOfDataToInsert.size() > 0)
        {
            return lstOfDataToInsert;
        }
        return null;
    }
    @AuraEnabled
    public static List<Object> processingDataToDelete()
    {
       Set<String> setOfGlobaIds = new Set<String>();
       List<SObject> lstOfDataToDelete = new List<SObject>();
        for(Ojha_Staging_Object__c objStg : [Select id,Name,City__c,Fname__c,Lname__c,Enrollment__c,Global_Identifier__c from Ojha_Staging_Object__c ])
        {
            setOfGlobaIds.add(objStg.Global_Identifier__c);
            
        } 
        for(Ojha_Object__c obj : [ Select id,Lname__c,Name,City__c,Fname__c,Enrollment__c,Global_Identifier__c from Ojha_Object__c where Global_Identifier__c NOT IN :setOfGlobaIds])
        {
            lstOfDataToDelete.add(obj);
        }
       
        System.debug('TO Be Deleted lstOfDataToDelete'+lstOfDataToDelete);
        if(lstOfDataToDelete != null && lstOfDataToDelete.size() > 0)
        {
            return lstOfDataToDelete;
        }
       return null;
    }
    
    @AuraEnabled
    public static List<ComparisonResultWrapper> processAllObjectsData()
    {
        try
        {
            Map<String,Ojha_Object__c> mapOfOjhaObject = new Map<String,Ojha_Object__c>();
        Set<String> setOfAllGIds = new Set<String>();
        Map<String,List<ComparisonResultWrapper>> mapOfEverything = new Map<String,List<ComparisonResultWrapper>>(); // Key will be fields
        List<ComparisonResultWrapper> lstOfWrapper = new List<ComparisonResultWrapper>();
        Map<String,Ojha_Staging_Object__c> mapOfOjhaStagingObject = new Map<String,Ojha_Staging_Object__c>();
        for(Ojha_Object__c obj : [ Select id,Name,City__c,Fname__c,Lname__c,Enrollment__c,Global_Identifier__c,Owner.Name from Ojha_Object__c])
        {
            mapOfOjhaObject.put(obj.Global_Identifier__c,obj);
            setOfAllGIds.add(obj.Global_Identifier__c);
        }
        for(Ojha_Staging_Object__c objStg : [Select id,Name,City__c,Lname__c,Fname__c,Enrollment__c,Global_Identifier__c,Owner.Name from Ojha_Staging_Object__c])
        {
            mapOfOjhaStagingObject.put(objStg.Global_Identifier__c,(Ojha_Staging_Object__c)objStg);
            setOfAllGIds.add(objStg.Global_Identifier__c);
        }
        System.debug('setOfAllGIds'+setOfAllGIds);
        for(String gId : setOfAllGIds)
        {
            ComparisonResultWrapper objWrap = new ComparisonResultWrapper();
            if(mapOfOjhaStagingObject != null && mapOfOjhaStagingObject.containsKey(gId))
            {
                        objWrap.StagingCity = mapOfOjhaStagingObject.get(gId).City__c;
            objWrap.StagingFname = mapOfOjhaStagingObject.get(gId).Fname__c;
            objWrap.StagingLname = mapOfOjhaStagingObject.get(gId).Lname__c;
            objWrap.StagingName = mapOfOjhaStagingObject.get(gId).Name;
            objWrap.StagingOwnerName = mapOfOjhaStagingObject.get(gId).Owner.Name;
            objWrap.StagingGlobalIdentifier = mapOfOjhaStagingObject.get(gId).Global_Identifier__c;
            }
    
            if(mapOfOjhaObject != null && mapOfOjhaObject.containsKey(gId))
            {
            objWrap.PrimaryFname = mapOfOjhaObject.get(gId).Fname__c;
            objWrap.PrimaryCity = mapOfOjhaObject.get(gId).City__c;
            objWrap.PrimaryLname = mapOfOjhaObject.get(gId).Lname__c;
            objWrap.PrimaryName = mapOfOjhaObject.get(gId).Name;
            objWrap.PrimaryOwnerName = mapOfOjhaObject.get(gId).Owner.Name;
            objWrap.PrimaryGlobalIdentifier = mapOfOjhaObject.get(gId).Global_Identifier__c;
            }
            lstOfWrapper.add(objWrap);
        }
        System.debug('lstOfWrapper'+lstOfWrapper);
        if(lstOfWrapper != null && lstOfWrapper.size() > 0)
        {
            return lstOfWrapper;
        }
        }
        Catch(Exception e)
        {
            System.debug('Exception'+e+'Line'+e.getLineNumber());
        }
        
        return null;
    }
    
    @AuraEnabled
    public static List<ComparisonResultWrapper> processUpdatingData()
    {
        try
        {
         Map<String,Ojha_Object__c> mapOfOjhaObject = new Map<String,Ojha_Object__c>();
        Set<String> setOfAllGIds = new Set<String>();
        Map<String,List<ComparisonResultWrapper>> mapOfEverything = new Map<String,List<ComparisonResultWrapper>>(); // Key will be fields
        List<ComparisonResultWrapper> lstOfWrapper = new List<ComparisonResultWrapper>();
        Map<String,Ojha_Staging_Object__c> mapOfOjhaStagingObject = new Map<String,Ojha_Staging_Object__c>();
        for(Ojha_Object__c obj : [ Select id,Name,City__c,Fname__c,Lname__c,Enrollment__c,Global_Identifier__c,Owner.Name from Ojha_Object__c])
        {
            mapOfOjhaObject.put(obj.Global_Identifier__c,obj);
            setOfAllGIds.add(obj.Global_Identifier__c);
        }
        for(Ojha_Staging_Object__c objStg : [Select id,Name,City__c,Lname__c,Fname__c,Enrollment__c,Global_Identifier__c,Owner.Name from Ojha_Staging_Object__c where Global_Identifier__c IN :setOfAllGIds ])
        {
            mapOfOjhaStagingObject.put(objStg.Global_Identifier__c,objStg);
          //  setOfAllGIds.add(objStg.Global_Identifier__c);
        }
        System.debug('mapOfOjhaStagingObject'+mapOfOjhaStagingObject);
        for(String gId : mapOfOjhaStagingObject.keyset())
        {
            
        }
        System.debug('lstOfWrapper'+lstOfWrapper);
        if(lstOfWrapper != null && lstOfWrapper.size() > 0)
        {
            return lstOfWrapper;
        }
        }
        Catch(Exception e)
        {
            System.debug('Exception'+e+'Line'+e.getLineNumber());
        }
        
        return null;
    }
    
    public class ComparisonResultWrapper
    {
        @AuraEnabled
        public String StagingCity {get;set;}
        @AuraEnabled
        public string PrimaryCity {get;set;}
        @AuraEnabled
        public String StagingFname {get;set;}
        @AuraEnabled
        public String PrimaryFname {get;set;}
        @AuraEnabled
        public String PrimaryLname {get;set;}
        @AuraEnabled
        public String StagingLname {get;set;}
        @AuraEnabled
        public String StagingName {get;set;}
        @AuraEnabled
        public String PrimaryName {get;set;}
        @AuraEnabled
        public String StagingOwnerName {get;set;}
        @AuraEnabled
        public String PrimaryOwnerName {get;set;}
        @AuraEnabled
        public String StagingGlobalIdentifier {get;set;}
        @AuraEnabled
        public String PrimaryGlobalIdentifier {get;set;}
        
        
    }
}