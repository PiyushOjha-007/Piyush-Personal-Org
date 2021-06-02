trigger PlatformEventTrigger on ErrorWithDMLTest__e (after insert) 
{
    List<Task> lstTask = new List<Task>();
   for(ErrorWithDMLTest__e obj : Trigger.New)
   {
      Task t = new Task();
      t.whatId = obj.RelatedId__c;
      t.Subject = obj.TaskSubject__c;
      t.Priority = obj.TaskPriority__c;
      t.Status = obj.TaskStatus__c;
      lstTask.add(t);
   }
   System.debug('lstTask'+lstTask);
   if(lstTask != null)
   {
     insert lstTask;
   }
}