<?xml version="1.0" encoding="UTF-8"?>
<!--
  FOURJS_START_COPYRIGHT(P,2002)
  Property of Four Js*
  (c) Copyright Four Js 2002, 2016. All Rights Reserved.
  * Trademark of Four Js Development Tools Europe Ltd
    in the United States and elsewhere
  FOURJS_END_COPYRIGHT
-->
<Specification version="1.0" >
  <Identification label="Business Records" />  
  <PropertyInfoList>    
    <PropertyGroup name="identityGroup"     label="Object"          description="Object group"          properties="name;fileVersion;databaseName"/>
    <PropertyGroup name="modeling"          label="Modeling"        description="Modeling group"        properties="active;masterTable;uniqueKey;lookup;uid;targetRecordUid"/>
    <PropertyGroup name="query"             label="Query"           description="Query group"           properties="additionalTables;joinLeft;joinRight;joinOperator;order;query;where"/>
    
    <!-- Property info list (ordered on name attribute) -->    
    <PropertyInfo name="active"             type="BOOLEAN"  label="active"              initialValue="false"                            description="Active Record"                 editorInfo="alwaysUpdate:true"/>
    <PropertyInfo name="additionalTables"   type="TEXT"     label="additional tables"                                                   description="Query additional tables"       isHidden="true" />
    <PropertyInfo name="colName"            type="ENUM"     label="colName"                                                             description="column name"                   editorInfo="alwaysUpdate:true;isDynamic:true" formField="true" compute42f="true" perRendering="IGNORE" />
    <PropertyInfo name="databaseName"       type="ENUM"     label="databaseName"        initialValue=""                                 description="database name"                 editorInfo="alwaysUpdate:true;isDynamic:true" />
    <PropertyInfo name="defaultValue"       type="TEXT"     label="defaultValue"        initialValue=""         useInitializer="true"   description="defaultValue"  formField="true"        perRendering="TRANSLATE"/>
    <PropertyInfo name="fieldIdRef"         type="INTEGER"  label="fieldIdRef"                                                          description="fieldIdRef"        readOnly="true"     perRendering="IGNORE"/>    
    <PropertyInfo name="fieldType"          type="ENUM"     label="fieldType"           initialValue="NON_DATABASE"                     description="fieldType"                     editorInfo="alwaysUpdate:true;isDynamic:true" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="fileVersion"         type="TEXT"    label="fileVersion"                                                         description="File Version" readOnly="true" isHidden="true" />
    <PropertyInfo name="joinLeft"           type="TEXT"     label="joinLeft"                                                            description="Left Joins"                    isHidden="true"  />
    <PropertyInfo name="joinRight"          type="TEXT"     label="joinRight"                                                           description="Right Joins"                   isHidden="true"  />
    <PropertyInfo name="joinOperator"       type="TEXT"     label="joinOperator"                                                        description="Join operators"                isHidden="true" />  
    <PropertyInfo name="length"             type="INTEGER"  label="length"              initialValue="1"                                description="Length"                        editorInfo="range:1|65534" perRendering="IGNORE" compute42f="true" ignore42f="true" />
    <PropertyInfo name="lookup"             type="ENUM"     label="lookup"              initialValue=""         useInitializer="true"   description="Lookup name"                   editorInfo="alwaysUpdate:true;isDynamic:true;editMode:true"/>  
    <PropertyInfo name="masterTable"        type="ENUM"     label="masterTable"         initialValue=""         useInitializer="true"   description="Master Table Name"             editorInfo="alwaysUpdate:true;isDynamic:true"/>
    <PropertyInfo name="name"               type="TEXT"     label="name"                                                                description="name"              compute42f="true" formField="true" perRendering="IGNORE"/>
    <PropertyInfo name="order"              type="TEXT"     label="order"                                                               description="order in query"                isHidden="true" />
    <PropertyInfo name="precision"          type="INTEGER"  label="precision"           initialValue="4"                                description="precision"                     editorInfo="range:1|2147483647;isDynamic:true" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="precisionDecimal"   type="INTEGER"  label="precision"           initialValue="16"                               description="precision"                     editorInfo="range:1|2147483647" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="qual1"              type="ENUM"     label="qual1"               initialValue="YEAR"                             description="qualifier 1"                   editorInfo="contains:YEAR|MONTH|DAY|HOUR|MINUTE|SECOND|FRACTION" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="qual2"              type="ENUM"     label="qual2"               initialValue="YEAR"                             description="qualifier 2"                   editorInfo="contains:YEAR|MONTH|DAY|HOUR|MINUTE|SECOND|FRACTION" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="qualFraction"       type="ENUM"     label="qual fraction"       initialValue="YEAR"                             description="qualifier fraction"            editorInfo="contains:YEAR|MONTH|DAY|HOUR|MINUTE|SECOND|FRACTION|FRACTION(1)|FRACTION(2)|FRACTION(3)|FRACTION(4)|FRACTION(5)" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="query"              type="BRQUERY"  label="query"               initialValue=""                                 description="Query"  />
    <PropertyInfo name="scale"              type="INTEGER"  label="scale"               initialValue="3"                                description="scale"                         editorInfo="true;range:0|5;isDynamic:true" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="scaleDecimal"       type="FDSCALE"  label="scale"               initialValue="-1"                               description="scale"                         editorInfo="range:-1|30;specialText:undefined" perRendering="IGNORE" ignore42f="true"/>
    <PropertyInfo name="sqlTabName"         type="ENUM"     label="sqlTabName"                                                          description="SQL table name"                editorInfo="alwaysUpdate:true;isDynamic:true" formField="true" compute42f="true"  perRendering="IGNORE"/>
    <PropertyInfo name="sqlType"            type="ENUM"     label="dataType"            initialValue="CHAR"                             description="Defines what kind of data will be managed"  editorInfo="alwaysUpdate:true;contains:BIGINT|BOOLEAN|BYTE|CHAR|DATE|DATETIME|DECIMAL|FLOAT|INTEGER|INTERVAL|MONEY|SMALLFLOAT|SMALLINT|TEXT|VARCHAR" initializer="dbschema:$(sqlTabName).$(colName)/@sqlType" compute42f="true" formField="true" perRendering="IGNORE"/>
    <PropertyInfo name="table_alias_name"   type="TEXT"     label="tableAliasName"                                                      description="table alias"                           perRendering="IGNORE"   ignore42f="true"/>
    <PropertyInfo name="targetRecordUid"    type="TEXT"     label="targetRecordUid"     initialValue=""                                 description="Uid of target record"  readOnly="true" isHidden="true"/>
    <PropertyInfo name="uid"                type="TEXT"     label="UID"                                                                 description="Unique ID" readOnly="true" isHidden="true"/>
    <PropertyInfo name="uniqueKey"          type="FIELDS"   label="unique key"          initialValue=""         initializer="dbschema:$(masterTable)/@primaryKey" description="Unique key" editorInfo="isDynamic:true" dynamicContent="children" />
    <PropertyInfo name="where"              type="TEXT"     label="where"                                       useInitializer="true"   description="Where clause"                  isHidden="true" />    
  </PropertyInfoList>
  <NodeInfoList>
    <!-- Nodes (ordered on mime type attribute) -->        
    <NodeInfo mimeType="BR/Record"          properties="name;uid;active;masterTable;uniqueKey;additionalTables;query;where;joinLeft;joinRight;joinOperator;order"           icon="screenRecord"   acceptedMimes="BR/RecordField;BR/Relation"  actions="BRAddField;BREditQuery;BRAddRelationTo"/>    
    <NodeInfo mimeType="BR/RecordField"     properties="name;uid;fieldType;sqlTabName;colName;table_alias_name;sqlType;qual1;precision;precisionDecimal;qual2;scale;scaleDecimal;qualFraction;length;defaultValue;fieldIdRef;lookup"  icon="variable_local" acceptedMimes=" " actions="BRAddRelationTo"/>
    <NodeInfo mimeType="BR/Relation"        properties="uid;targetRecordUid" icon="ba_relation"  acceptedMimes=" " />    
    <NodeInfo mimeType="BR/Root"            properties="name;uid;databaseName;fileVersion"                       icon="document_4fdm" />
  </NodeInfoList>
</Specification>
