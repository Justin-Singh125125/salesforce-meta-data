<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CAMS_All_Subtasks_Completed</fullName>
        <description>CAMS All Subtasks Completed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_All_SubTasks_Completed2</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Task_Back_to_Assigned</fullName>
        <description>CAMS Task Back to Assigned</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Task_Back_to_Assigned</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Task_Delegation_or_Assignment</fullName>
        <description>CAMS Task Delegation or Assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Task_Delegation_or_Assignment</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Task_Overdue</fullName>
        <description>CAMS Task Overdue</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Task_Overdue</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Task_Reminder</fullName>
        <description>CAMS Task Reminder</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Task_Reminder</template>
    </alerts>
    <alerts>
        <fullName>CAMS_Task_Withdrawn</fullName>
        <description>CAMS Task Withdrawn</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>CAMS/CAMS_Task_Withdrawn</template>
    </alerts>
</Workflow>
