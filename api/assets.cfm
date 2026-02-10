<cfcontent type="application/json">

<cfsetting showdebugoutput="false">

<cfset assetModel = new model.Asset()>

<cfparam name="url.q" default="">

<cfset assets = assetModel.getAll()>

<cfif len(url.q)>
    <cfquery name="assets" dbtype="query">
        SELECT * FROM assets 
        WHERE asset_name LIKE <cfqueryparam value="%#url.q#%" cfsqltype="cf_sql_varchar">
        OR serial_number LIKE <cfqueryparam value="%#url.q#%" cfsqltype="cf_sql_varchar">
    </cfquery>
</cfif>

<cfset dataArray = []>
<cfloop query="assets">
    <cfset arrayAppend(dataArray, {
        "id": assets.id,
        "name": assets.asset_name,
        "serial": assets.serial_number,
        "assigned_to": assets.employee_name ?: "Unassigned",
        "cost": assets.cost
    })>
</cfloop>

<cfoutput>#serializeJSON(dataArray)#</cfoutput>