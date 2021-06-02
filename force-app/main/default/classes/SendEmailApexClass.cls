public class SendEmailApexClass {
    public static String verifyUserEmailWithOTP(String Emailvalue) 
    {
        try
        {
            String rand = string.valueof(Math.abs(Crypto.getRandomInteger()));
            String otpNumber = rand.substring(0,6); 
            System.debug('OTP Generated'+otpNumber);
            System.debug('Emailvalue'+Emailvalue);
            
            List<String> sendTo = new List<String>();
            sendTo.add(Emailvalue);
          //  EmailTemplate et=[SELECT Id,name,body FROM EmailTemplate WHERE developername = 'User_Email_OTP_Template'];
            
            List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>(); 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         //   mail.setTemplateId(et.Id);
            mail.setToAddresses(sendTo);     
            mail.setBccSender(false);
            mail.setSubject('Congrats Your answer has selected as Best Answer');
            mail.setSenderDisplayName('Best Answer');
            mail.setUseSignature(false);
            mail.setSaveAsActivity(false); 
          /*  if(et.Body != null )
            {
                
                String htmlBody = et.Body;
                htmlBody = htmlBody.replace('Username', Username );
                htmlBody = htmlBody.replace('otpnumber' , otpNumber);
                mail.setPlainTextBody(htmlBody);
                
            } 
            */
            mail.setPlainTextBody('Hi Guys Lets test something !!');
            System.debug('mail format'+mail);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            if (results[0].success) 
            {
                System.debug('The email was sent successfully.');
            } else 
            {
                System.debug('The email failed to send: ' + results[0].errors[0].message);
            }
            return otpNumber;
        }
        catch(Exception e)
        {
            System.debug('Exception'+e+'Line'+e.getLineNumber());
        }
        return null;
    }

}