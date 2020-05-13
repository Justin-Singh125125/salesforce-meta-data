public class ComplaintNotificationEmail{ 
   
   
    public ComplaintNotificationEmail(){
        
    }
    
    @InvocableMethod
    public static void ProcessSendEmail(List<Id> complaintIds) 
    {
        //Define Text Template
        string english15Body = 'DO NOT REPLY TO THIS MESSAGE. \r\n\r\nDear <:COMPLAINANT:>,\r\n\r\nThis message relates to the environmental complaint number <:NUMBER:> you submitted to the California Environmental Protection Agency (CalEPA) on <:DATE:>. Your complaint is being handled by the following agencies: \r\n<:OWNER:> \r\n\r\nYour complaint is still being investigated. We will notify you once the complaint has been closed. \r\n\r\nThank you.';
        string english15Subject = 'Update regarding your environmental complaint';
        
        string spanish15Body = 'Su queja ambiental ha sido resuelta. \r\n\r\nEstimado(a) <:COMPLAINANT:>, \r\n\r\nEste mensaje es en relación a la queja ambiental número <:NUMBER:> que usted presentó ante la Agencia para la Protección Ambiental de California (California Environmental Protection Agency, o CalEPA) el día <:DATE:>. Su queja ha quedado resuelta. A continuación se encuentra una lista de las dependencias que se hicieron cargo de su queja. Si usted desea recibir más información, por favor comuníquese directamente con las dependencias en la lista. \r\n<:OWNER:> \r\n\r\nGracias.';
        string spanish15Subject = 'Actualización sobre su queja ambiental.';
        
        string englishClosedBody = 'DO NOT REPLY TO THIS MESSAGE.\r\n\r\nDear <:COMPLAINANT:>, \r\n\r\nThis message relates to the environmental complaint number <:NUMBER:> you submitted to the California Environmental Protection Agency (CalEPA) on <:DATE:>. Your complaint has been closed. Below is a list of agencies that handled your complaint. If you would like more information, please contact the listed agencies directly. \r\n<:OWNER:>\r\n\r\nThank you.';
        string englishClosedSubject = 'Your environmental complaint has been closed';
        
        string spanishClosedBody = 'NO ENVÍE RESPUESTA A ESTE MENSAJE. \r\n\r\nEstimado(a) <:COMPLAINANT:>, \r\n\r\nEste mensaje es en relación a la queja ambiental número <:NUMBER:> que usted presentó ante la Agencia para la Protección Ambiental de California (California Environmental Protection Agency, o CalEPA) el día <:DATE:>. Su queja ha sido turnada a las siguientes dependencias: \r\n<:OWNER:> \r\n\r\nAún estamos investigando su queja. Le informaremos cuando la queja haya quedado resuelta. \r\n\r\nGracias.';
        string spanishClosedSubject = 'Su queja del medio ambiente se ha cerrado';
        
        //Retrieve Complaint Data
        List<Complaints__c> complaints = [SELECT Id, Name, Complainant__r.Language__pc, Actual_Receive_Date__c, Status__c, Complainant__r.PersonContactId, Complainant__r.PersonHasOptedOutOfEmail, Complainant__r.PersonEmail, Complainant__r.FirstName, Complainant__r.LastName,  Toxic_Substances__c, Air__c, Water__c, Pesticides__c, Solid_Waste__c, Owner.Name, Owner.Email FROM Complaints__c WHERE Id in: complaintIds];
        //Retrieve Complaint Assignment Data
        List<Complaint_Assignment__c> assignments = [SELECT Id, Complaint__c, OwnerId, Owner.Name, Owner.Email, Status__c, Group__r.Name FROM Complaint_Assignment__c WHERE Complaint__c in: complaintIds];
        
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        //Loop Through Complaints
        for(Complaints__c complaint: complaints)
        {
            //Build Message
            Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
            message.setToAddresses(new String[] {complaint.Complainant__r.PersonEmail});
            message.setTargetObjectId(complaint.Complainant__r.PersonContactId);
            message.setWhatId(complaint.Id);
            message.setSenderDisplayName('CalEPA Complaints');
            message.setReplyTo('complaints@calepa.ca.gov');

            
            if(complaint.Complainant__r.Language__pc == 'Spanish')
            {
                if(complaint.Status__c <> 'Closed')
                {
                    message.setSubject(spanish15Subject);
                    message.setHtmlBody(GetBody(spanish15Body, complaint, assignments));
                }
                else
                {
                    message.setSubject(spanishClosedSubject);
                    message.setHtmlBody(GetBody(spanishClosedBody, complaint, assignments));
                }
            }
            else
            {
                if(complaint.Status__c <> 'Closed')
                {
                    message.setSubject(english15Subject);
                    message.setHtmlBody(GetBody(english15Body, complaint, assignments));
                }
                else
                {
                    message.setSubject(englishClosedSubject);
                    message.setHtmlBody(GetBody(englishClosedBody, complaint, assignments));
                }

            }
            message.setUseSignature(true);
            message.setSaveAsActivity(true);

            //Add Message to List
            messages.add(message);
        }
        //Send Messages
        if(!test.isRunningTest())
        {
            try 
            {
                List<Messaging.SendEmailResult> results = Messaging.sendEmail(messages);
            } 
            catch (EmailException e) 
            {
            }
        }
    }
        
    private static string GetBody(string template, Complaints__c complaint, List<Complaint_Assignment__c> assignments)
    {   
        string body = template;
        
        body = body.replace('<:COMPLAINANT:>', complaint.Complainant__r.FirstName + ' ' + complaint.Complainant__r.LastName);
        body = body.replace('<:NUMBER:>', complaint.Name);
        body = body.replace('<:DATE:>', complaint.Actual_Receive_Date__c.format('MM/dd/yyyy'));
        string owner = '\r\n';
        for(Complaint_Assignment__c assignment: assignments)
        {
            if(assignment.Complaint__c == complaint.Id)
            {
                owner = owner + assignment.Group__r.Name;
                owner = owner + '\r\n';
                owner = owner + assignment.Owner.Name;
                owner = owner + ' ';
                owner = owner + assignment.Owner.Email;
                owner = owner + '\r\n\r\n';
            }
        }
        body = body.replace('<:OWNER:>', owner);
        
        body = body.replace('\r\n','<br/>');
        return body;
    }
}