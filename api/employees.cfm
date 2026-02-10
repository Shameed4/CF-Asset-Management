<cfcontent type="application/json">
<cfsetting showdebugoutput="false">

<cfset employeeModel = new model.Employee()>

<cfparam name="url.q" default="">

<cfif len(url.q)>
    <cfquery name="employees">
        SELECT id, name, department, email
        FROM employees
        WHERE name LIKE <cfqueryparam value="%#url.q#%" cfsqltype="cf_sql_varchar">
           OR department LIKE <cfqueryparam value="%#url.q#%" cfsqltype="cf_sql_varchar">
        ORDER BY name ASC
    </cfquery>
<cfelse>
    <cfset employees = employeeModel.getAll()>
</cfif>

<cfset dataArray = []>
<cfloop query="employees">
    <cfset arrayAppend(dataArray, {
        "id": employees.id,
        "name": employees.name,
        "department": employees.department,
        "email": employees.email
    })>
</cfloop>

<cfoutput>#serializeJSON(dataArray)#</cfoutput>