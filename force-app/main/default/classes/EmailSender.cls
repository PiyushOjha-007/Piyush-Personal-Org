public class EmailSender {

    public static void sendMail(String address,String subject,String Body,String cc)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] tomail = new String[]{address};
        String[] tocc = new String[]{cc};
        mail.setToAddresses(tomail);
        mail.setCcAddresses(tocc);
        mail.setSubject(subject);
        mail.setPlainTextBody(Body);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}