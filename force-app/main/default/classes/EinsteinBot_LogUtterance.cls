public with sharing class EinsteinBot_LogUtterance
{
    public class LogInput
    {
        @InvocableVariable(required=false)
        public String sCurrentUtterance;
        @InvocableVariable(required=true)
        public String sLiveAgentTranscriptId;
        
    }
    
    
    @InvocableMethod(Label = 'Log Utterance')
    public static void logUtterance(List<LogInput> inputParams)
    {
        Utterance_Log__c logObj = new Utterance_Log__c();
        logObj.currentUtterance__c = inputParams[0].sCurrentUtterance;
        logObj.LiveChatTranscript__c = inputParams[0].sLiveAgentTranscriptId;
        insert logObj;
       
        
    }
}