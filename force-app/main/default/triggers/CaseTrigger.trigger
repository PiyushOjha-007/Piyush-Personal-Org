trigger CaseTrigger on Case (before insert,after update) {

    if(Trigger.isInsert && Trigger.isBefore)
    {
         CaseTriggerHandler.testErrorAndDML(Trigger.new);
    }
}