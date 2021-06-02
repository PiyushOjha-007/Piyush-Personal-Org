/**
* @name orderTrigger
* @description
**/
trigger orderTrigger on Order (before update, after update) 
{
    if(Trigger.isUpdate && Trigger.isAfter )
    {
        OrderHelper.AfterUpdate(Trigger.New, Trigger.Old);
    }
}