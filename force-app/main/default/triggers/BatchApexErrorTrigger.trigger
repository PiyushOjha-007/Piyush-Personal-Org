trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {

    List<BatchLeadConvertErrors__c> lstToInsert = new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent obj : Trigger.New)
    {
        BatchLeadConvertErrors__c batchObj = new BatchLeadConvertErrors__c();
        batchObj.AsyncApexJobId__c = obj.AsyncApexJobId;
        batchObj.Records__c = obj.JobScope;
        batchObj.StackTrace__c = obj.StackTrace;
        lstToInsert.add(batchObj);
    }
    Database.insert(lstToInsert);
}