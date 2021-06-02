public with sharing class CookbookBot_HandleIntentDetectFailure {

   public class HandleInput {
       @InvocableVariable(required=false)
       public String sCurrentUtterance;
       @InvocableVariable(required=false)
       public String sLiveChatTranscriptId;
   }

   public class HandleOutput {
       @InvocableVariable(required=true)
       public String sTransferMessage;
       @InvocableVariable(required=true)
       public String bTransferRequired;
   }

   @InvocableMethod(label='Handle Intent Detection Failure')
   public static List<handleOutput> handleIntentDetectionFailure(List<HandleInput> inputParameters) {
       String sCurrentUtterance = inputParameters[0].sCurrentUtterance;
       String sLiveChatTranscriptId = inputParameters[0].sLiveChatTranscriptId;

       // Create default output values
       List<HandleOutput> outputParameters = new List<HandleOutput>();
       HandleOutput outputParameter = new HandleOutput();
       outputParameter.bTransferRequired = '';
       outputParameter.sTransferMessage = '';
       
       // Find undetected utterances from this session
       List<Utterance_Log__c> undetectedUtterances = [SELECT CurrentUtterance__c, CreatedDate 
                                                      FROM Utterance_Log__c
                                                      WHERE LiveChatTranscript__c = :sLiveChatTranscriptId
                                                      ORDER BY CreatedDate Desc];

       // Have we had more than two undetected utterances?
       if (undetectedUtterances.size() >= 2)
       {
           // Have we had more than five?
           if (undetectedUtterances.size() > 5)
           {
               // If so, then automatically suggest a transfer...
               outputParameter.bTransferRequired = 'Transfer';
               outputParameter.sTransferMessage = 'Let me find one of our Agent/Specialists to help you.';
           }
           // If less than five...
           else
           {
               // Grab the most recent two utterances
               Utterance_Log__c thisUtterance = undetectedUtterances[0];
               Utterance_Log__c lastUtterance = undetectedUtterances[1];

               // If they happened within the past 20 seconds...
               if (thisUtterance.CreatedDate < lastUtterance.CreatedDate.addSeconds(20))
               {
                   // Then suggest a transfer...
                outputParameter.bTransferRequired = 'Case';
                outputParameter.sTransferMessage = 'Let me Create a Log an Issue/Case for you !';
               }
           }
       }
       outputParameters.add(outputParameter);       
       return outputParameters;
   }
}