public with sharing class ToDoManagerController {
    
    @AuraEnabled
    public static string addToDotask(String payload)
    {
        try{
            List<ToDoManager__c> lstOfToDo = new List<ToDoManager__c>();
            System.debug('Pay Load'+payload);
            ToDoWrapper payObject = (ToDoWrapper)JSON.deserialize(payload,ToDoWrapper.class);
            System.debug('Pay Object'+payObject);
            ToDoManager__c obj = new ToDoManager__c();
            obj.Done__c = payObject.done;
            obj.Task_Name__c = payObject.toDoTaskName;
            
            lstOfToDo.add(obj);
            insert lstOfToDo;
            return String.valueOf(lstOfToDo[0].Id);
        }
        catch(Exception e)
        {
            System.debug('Exception'+e+'Line Number '+e.getLineNumber());
        }
        
        return 'Error';
    }
        
    @AuraEnabled
    public static Boolean updateToDos(string todoId)
    {
        List<ToDoManager__c> lstOfUpdate = new List<ToDoManager__c>();
        for(ToDoManager__c obj : [Select id,CreatedDate,Done__c,Start_Date__c,Task_Name__c,Completed_On__c,Total_Days_Taken__c from ToDoManager__c where Id=: todoId])
        {
            DateTime dT = System.now();
            date myDate = date.newinstance(dT.year(), dT.month(), dT.day());
            lstOfUpdate.add(new ToDoManager__c(Id=obj.Id,Done__c=true,Completed_On__c = myDate));
        }
        if(lstOfUpdate != null && lstOfUpdate.size()>0)
        {
            System.debug('lstOfUpdate'+lstOfUpdate);
            Database.update(lstOfUpdate);
            return true;
        }
        return false;
    }

    @AuraEnabled
    public static Boolean deleteToDos(string todoId)
    {
        List<ToDoManager__c> lstOfUpdate = new List<ToDoManager__c>();
        lstOfUpdate.add(new ToDoManager__c(Id=todoId));
        if(lstOfUpdate != null && lstOfUpdate.size()>0)
        {
            System.debug('lstOfUpdate'+lstOfUpdate);
            Database.delete(lstOfUpdate);
            return true;
        }
        return false;
    }
    
    @AuraEnabled
    public static List<ToDoManager__c> getAllToDos()
    {
        List<ToDoManager__c> lstOfAllToDo = [Select CreatedDate,Done__c,Start_Date__c,Task_Name__c,Completed_On__c,Total_Days_Taken__c from ToDoManager__c where CreatedDate = LAST_N_DAYS:7 order by CreatedDate desc];
        return lstOfAllToDo;
    }

    @AuraEnabled
    public static Map<Date,List<ToDoManager__c>> getMapOfToDos()
    {
        Map<Date,List<ToDoManager__c>> mapOfStartDateAndToDos = new Map<Date,List<ToDoManager__c>>();
        for(ToDoManager__c objTo : [Select CreatedDate,Done__c,Start_Date__c,Task_Name__c,Completed_On__c,Total_Days_Taken__c from ToDoManager__c where CreatedDate = LAST_N_DAYS:7 order by CreatedDate desc])
        {
            DateTime dT = objTo.Start_Date__c;
            Date myDate = Date.newinstance(dT.year(), dT.month(), dT.day());
            System.debug('MY CHNAGED DATE'+myDate);
            if(objTo != null && myDate != null)
            {
                if(mapOfStartDateAndToDos.containsKey(myDate))
                {
                    mapOfStartDateAndToDos.get(myDate).add(objTo);
                }
                else 
                {
                    mapOfStartDateAndToDos.put(myDate,new List<ToDoManager__c>{objTo});
                }
            }
        } 
        System.debug('mapOfStartDateAndToDos'+mapOfStartDateAndToDos);
         return mapOfStartDateAndToDos;
    }

    @AuraEnabled
    public static List<ToDoWrapper> getTodayToDos()
    {
        List<SObject> lstOfTodaysToDo = [Select CreatedDate,Done__c,Start_Date__c,Task_Name__c,Completed_On__c,Total_Days_Taken__c from ToDoManager__c where CreatedDate = Today order by CreatedDate desc];
        return getToDoAsWrapper(lstOfTodaysToDo);
    }
    @AuraEnabled
    public static List<ToDoWrapper> getToDoAsWrapper(List<SObject> lstOfTodaysToDo)
    {
        try{
            List<ToDoWrapper> lstOfToDo = new List<ToDoWrapper>();
            if(lstOfTodaysToDo != null && lstOfTodaysToDo.size() > 0)
            {
                for(SObject obj: lstOfTodaysToDo)
                {
                    ToDoWrapper objWrap = new ToDoWrapper();
                    objWrap.todoId = obj.Id;
                    objWrap.done = (Boolean)obj.get('Done__c');
                    objWrap.toDoTaskName = (String)obj.get('Task_Name__c');
                    objWrap.completedDate = (Date)obj.get('Completed_On__c');
                    objWrap.taskStartDate = (DateTime)obj.get('CreatedDate');
                    lstOfToDo.add(objWrap);
                    
                }
            }
            System.debug('lstOfToDo'+lstOfToDo);
            return lstOfToDo;
        }
        catch(Exception e)
        {
            System.debug('Exception'+e+'Line'+e.getLineNumber());
        }
        return null;
    }
    
    
    public class ToDoWrapper
    {
        @AuraEnabled
        public string todoId;
        @AuraEnabled
        public boolean done;
        @AuraEnabled
        public string toDoTaskName;
        @AuraEnabled
        public DateTime completedDate;
        @AuraEnabled
        public DateTime taskStartDate;
    }
}