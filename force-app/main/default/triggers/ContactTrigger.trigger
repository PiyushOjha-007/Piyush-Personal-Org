trigger ContactTrigger on Contact (after insert,after update,after delete) {
/*
if(Trigger.isAfter)
{
  if(Trigger.isUpdate || Trigger.isInsert || Trigger.isDelete)
  {
    system.debug('In Trigger Update'+Trigger.isUpdate);
        system.debug('In Trigger Insert'+Trigger.isInsert);
            system.debug('In Trigger Delete'+Trigger.isDelete);
           //  ContactTriggerHandler.countTotalNoOfContact(Trigger.New,Trigger.Old);
           //  ContactTriggerHandler.calculateContactAmount(Trigger.New);
             ContactTriggerHandler.updateContactOnAccount(Trigger.New,Trigger.OldMap);
  }
}
    
    */
}