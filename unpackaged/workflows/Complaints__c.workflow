<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Complaint_Submission_Received_Spanish</fullName>
        <description>Complaint Submission Received - Spanish</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Email_for_notifications__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Complaint_Management/Complaint_Received_Confirmation_Spanish</template>
    </alerts>
    <alerts>
        <fullName>Complaint_submission_received</fullName>
        <description>Complaint submission received</description>
        <protected>false</protected>
        <recipients>
            <field>Contact_Email_for_notifications__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Complaint_Management/Complaint_Received_Confirmation_English1</template>
    </alerts>
    <alerts>
        <fullName>EJ_complaint_notification</fullName>
        <description>EJ complaint notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>EJ_Notification_Recipients_Complaints</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Complaint_Management/EJ_Complaint</template>
    </alerts>
    <alerts>
        <fullName>Tribal_Complaint_notification</fullName>
        <description>Tribal Complaint notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>Tribal_Notification_Group_Complaints</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Complaint_Management/Tribal_Complaint</template>
    </alerts>
    <fieldUpdates>
        <fullName>Assign_Complaints_to_Agency_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Agency</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assign Complaints to Agency Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_to_Referred</fullName>
        <field>Status__c</field>
        <literalValue>Referred</literalValue>
        <name>Change Status to Referred</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Actual_Receive_Date</fullName>
        <field>Actual_Receive_Date__c</field>
        <formula>CreatedDate</formula>
        <name>Populate Actual Receive Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_on_the_Complaint</fullName>
        <field>Contact_Email_for_notifications__c</field>
        <formula>Complainant__r.PersonContact.Email</formula>
        <name>Update Email on the Complaint</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assign Complaints to Agency Queue</fullName>
        <actions>
            <name>Assign_Complaints_to_Agency_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Complaints__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Parent</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Complaint Received Confirmation English</fullName>
        <actions>
            <name>Complaint_submission_received</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT( $Setup.Disable_All_Workflows__c.Value__c ),NOT(ISBLANK( Contact_Email_for_notifications__c)), TEXT( Complainant__r.PersonContact.Language__c ) = &quot;English&quot;, RecordType.DeveloperName = &quot;Parent&quot;,  Complainant__r.PersonContact.HasOptedOutOfEmail = false )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Complaint Received Confirmation Spanish</fullName>
        <actions>
            <name>Complaint_Submission_Received_Spanish</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT( $Setup.Disable_All_Workflows__c.Value__c ),NOT(ISBLANK( Contact_Email_for_notifications__c)), TEXT(Complainant__r.PersonContact.Language__c ) = &quot;Spanish&quot;, RecordType.DeveloperName = &quot;Parent&quot;,  Complainant__r.PersonContact.HasOptedOutOfEmail = false )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EJ Complaint notification</fullName>
        <actions>
            <name>EJ_complaint_notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT( $Setup.Disable_All_Workflows__c.Value__c ),EJ_Complaint__c = true,  RecordType.DeveloperName = &quot;Parent&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Actual Receive Date</fullName>
        <actions>
            <name>Populate_Actual_Receive_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT( $Setup.Disable_All_Workflows__c.Value__c ),ISBLANK(Actual_Receive_Date__c), RecordType.DeveloperName = &quot;Parent&quot; )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Tribal Complaint notification</fullName>
        <actions>
            <name>Tribal_Complaint_notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT( $Setup.Disable_All_Workflows__c.Value__c ), Tribal_Complaint__c = true)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Email on the Complaint</fullName>
        <actions>
            <name>Update_Email_on_the_Complaint</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update Email on the Complaint record for email notifications.</description>
        <formula>AND(NOT( $Setup.Disable_All_Workflows__c.Value__c ),NOT(ISBLANK( Complainant__r.PersonContact.Email )))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
