@isTest
public class ComplaintController_Test {
    public static testMethod void myUnitTest(){
        test.startTest();
        /*List<Custom_Links__c> links = new List<Custom_Links__c>();
        Custom_Links__c cl = new Custom_Links__c();
        cl.Name = 'Water Waste';
        cl.Web_Link__c = 'http://www.test.com';
        links.add(cl);
        cl = new Custom_Links__c();
        cl.Name = 'Prop65';
        cl.Web_Link__c = 'http://www.test.com';
        links.add(cl);
        cl = new Custom_Links__c();
        cl.Name = 'Pesticides - CAC Directory';
        cl.Web_Link__c = 'http://www.test.com';
        links.add(cl);
        insert links;
        */
               
        Complaints__c c = new Complaints__c();
        c.Air__c = true;
        c.Complaint_Location_Address__c = '1001 I Street';
        c.Complaint_Location_City__c = 'Sacramento'; 
        c.Complaint_Location_State__c = 'CA';
        c.Complaint_Location_Zip_Code__c = '95812';
        
        
        test.setCurrentPage(new PageReference('/apex/Complaint'));
        ApexPages.Standardcontroller sc = new ApexPages.StandardController(c);
        ComplaintController cc = new ComplaintController(sc);
        
        cc.getComplaint();
        cc.sameAddress = 'true';
        cc.complaint.Air__c = true;
        cc.complaint.Complaint_Location_Address__c = '1001 I Street';
        cc.complaint.Complaint_Location_City__c = 'Sacramento'; 
        cc.complaint.Complaint_Location_State__c = 'CA';
        cc.complaint.Complaint_Location_Zip_Code__c = '95812';
        cc.personContact.LastName = 'test';
        cc.complaint.Temp_Contact_Email__c = 'test@test.com';
        cc.getAccount();
        cc.submittedDate = '2016-02-28';
        cc.getStates();
        cc.pageCheck();
        cc.getContact();
        cc.getCustomLinks();
        cc.updateSameAddress();
        cc.updateAnonymous();
        cc.emeregency();
        cc.step1();
        cc.step2();

        cc.step2();
        cc.updateAttachmentMap();
        cc.step3();
        cc.complaint.Description__c = 'test description';
        cc.complaint.Unknown_Date_of_Occurrence__c = 'Exact Date';
        cc.occuranceDateTime = '2/1/2016 12:01:01 PM';
        cc.step3();
        
        cc.step4();
        cc.account.PersonEmail = 'test@test.com';
        cc.personContact.firstName = 'test';
        cc.step4();
        cc.complaint.Referring_Name__c = 'test';
        cc.complaint.Referring_Agency__c = 'test';
        cc.complaint.Referring_Email_Address__c = 'test@test.com';
        cc.step4();
        cc.complaint.Anonymous__c = true;
        
        Attachment att = new Attachment();
        att.Name = 'test.txt';
        att.Body = blob.valueOf('test test test');
        att.ContentType = 'txt';
        cc.attachment = att;
        cc.addAttachment();
        att = new Attachment();
        att.Name = 'test.txt';
        att.Body = blob.valueOf('test test test');
        att.ContentType = 'txt';
        cc.attachment = att;
        cc.addAttachment();
        Set<Id> aIds = new Set<Id>();
        for(string a : cc.attachmentMap.keySet()){
            aIds.add(a);
            cc.rAttachmentId = a;
        }
        
        cc.removeAttachment();
        cc.step4();
        
        cc.cancel();
        
        
        test.stopTest();
    }
}