public class NotifyUserAfterBestAnswerClass {
    
    public static void sendNotification(List<FeedComment> lstOfFeedComments){
        
        /*     List<CustomNotificationActionInput> notifyInputs ;
List<FeedComment> listFeedComment;
if(String.isNotBlank(inputs)){

notifyInputs = (List<CustomNotificationActionInput>)JSON.deserialize(inputs,List<CustomNotificationActionInput>.Class); 

if(notifyInputs!=null && !notifyInputs.IsEmpty()){

Http htp = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint(Url.getOrgDomainUrl().toExternalForm()+'/services/data/v48.0/actions/standard/customNotificationAction');
req.setMethod('POST');
req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
req.setHeader('Content-Type', 'application/json');
CustomNotificationAction action = new CustomNotificationAction();
action.inputs = notifyInputs;
req.setBody(JSON.serialize(action));
HttpResponse res = htp.send(req);
System.debug('==res=='+res);
System.debug(res.getBody()); 
}
} */
        
      /*  for(FeedComment cmt : lstOfFeedComments)
        {
            List<String> sendTo = new List<String>{'piojha@cisco.com'};
            List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>(); 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(sendTo);     
            mail.setBccSender(false);
            mail.setUseSignature(false);
            mail.setSubject('Congrats Your answer has selected as Best Answer');
            mail.setSenderDisplayName('Best Answer');
            mail.setSaveAsActivity(false); 
            mail.setPlainTextBody('Best Answer is this'+cmt);
            System.debug('mail format'+mail);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });                
        } */
        
        
        
        for(FeedComment cmt : lstOfFeedComments)
        {
            CustomeInputWrapper customWrap = new CustomeInputWrapper();
            customWrap.customNotifTypeId = '0ML7F000000CaY8WAK';
            customWrap.recipientIds = new List<Id>{cmt.CreatedById};
            customWrap.Title = 'Congratulations !';
            customWrap.Body = 'Your Answer is selected as Best Answer.';
            customWrap.targetId = cmt.FeedItemId;
            
            
        }
        
        
    }
    public class CustomeInputWrapper
    {
        public Id customNotifTypeId;
        public List<Id> recipientIds;
        public String Title;
        public String Body;
        public Id targetId;
        
    }
}