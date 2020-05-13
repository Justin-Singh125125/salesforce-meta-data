<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_User_Department</fullName>
        <field>Department</field>
        <formula>IF(ISPICKVAL(BDO__c, &quot;ARB&quot;), &quot;Air Resources Board&quot;, 
IF(ISPICKVAL(BDO__c, &quot;DTSC&quot;), &quot;Department of Toxic Substances Control&quot;, 
IF(ISPICKVAL(BDO__c, &quot;DPR&quot;), &quot;Department of Pesticide Regulation&quot;, 
IF(ISPICKVAL(BDO__c, &quot;CalRecycle&quot;), &quot;CalRecycle&quot;, 
IF(ISPICKVAL(BDO__c, &quot;SWRCB&quot;), &quot;State Water Resources Control Board&quot;,
&quot;CalEPA&quot;)))))</formula>
        <name>Update User Department</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Department</fullName>
        <actions>
            <name>Update_User_Department</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.BDO__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Auto-update department based on BDO field</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
