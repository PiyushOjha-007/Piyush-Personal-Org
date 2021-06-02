/**
 * @name product2Trigger
 * @description Trigger to notify staff of low levels of inventory
**/
trigger product2Trigger on Product2 (after update) {
    try {
        Product2Helper.AfterUpdate(Trigger.New);
    } catch ( Exception e ){
        System.debug('Exception in Product Trigger '+e+'Line'+e.getLineNumber());
    }
}