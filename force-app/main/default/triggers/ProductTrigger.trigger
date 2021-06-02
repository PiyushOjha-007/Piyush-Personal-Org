trigger ProductTrigger on Product2 (after insert,after update , after delete) {

    if(Trigger.isInsert && Trigger.isAfter)
    {
        ProductTriggerSequenceController.ProductAfterInsertController(Trigger.newMap.keySet());
    }
    if(Trigger.isUpdate && Trigger.isAfter)
    {
        ProductTriggerSequenceController.ProductAfterUpdateController(Trigger.newMap.keyset());
    }
    if(Trigger.isDelete && Trigger.isAfter)
    {
        System.debug('After delete');
        ProductTriggerSequenceController.ProductAfterDeleteController(Trigger.oldMap.keyset());
    }
}