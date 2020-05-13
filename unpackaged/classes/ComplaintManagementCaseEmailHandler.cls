global class ComplaintManagementCaseEmailHandler implements Messaging.InboundEmailHandler 
{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope)
    {
            return new Messaging.InboundEmailResult(); 
    }
}