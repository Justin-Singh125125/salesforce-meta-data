<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Complaint_Assignment_Group_Has_Changed</fullName>
        <description>Complaint Assignment Group Has Changed</description>
        <protected>false</protected>
        <recipients>
            <recipient>matthew.buffleben@waterboards.ca.gov</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Complaint_Management/Complaint_Assignment_Group_Change</template>
    </alerts>
    <rules>
        <fullName>Notify Matthew Buffleben When Owner Changes</fullName>
        <actions>
            <name>Complaint_Assignment_Group_Has_Changed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Complaint_Assignment_Group__c.Type__c</field>
            <operation>equals</operation>
            <value>Water</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
