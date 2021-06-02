global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {

    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String queryStr = 'Select id,LeadSource from Lead ';
        return Database.getQueryLocator(queryStr);
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> lstLead){
  
        List<Lead> leadList = new List<Lead>();
        for(Lead objLead : lstLead)
        {
            Lead obj = new Lead(id=objLead.id);
            obj.LeadSource = 'Dreamforce';
            leadList.add(obj);
        }
        Database.update(leadList);
    }  
    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Piyush!');
 
}
}