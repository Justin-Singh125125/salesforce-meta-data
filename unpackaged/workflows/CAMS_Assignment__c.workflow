<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CAMS_All_Task_Completed_For_Assignment</fullName>
        <description>CAMS All Task Completed For Assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_All_Task_Completed_For_Assignment</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Assignment_Overdue</fullName>
        <description>CAMS Assignment Overdue</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Assignment_Overdue</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Assignment_Reminder</fullName>
        <description>CAMS Assignment Reminder</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Assignment_Reminder</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Assignment_Withdrawn</fullName>
        <description>CAMS Assignment Withdrawn</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Assignment_Withdrawn</template>
    </alerts>
</Workflow>
