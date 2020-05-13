global class EmailServiceExample implements Messaging.InboundEmailHandler 
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email,Messaging.InboundEnvelope envelop)
    {
        System.Debug('Inbound');
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        String accname = email.fromName;
        String accdes = email.plainTextBody;
        String accIndus = email.Subject;
        Account ac = new Account(Name = accname, description = accdes, Industry = accIndus);
        insert ac;
        return null;
    }
}