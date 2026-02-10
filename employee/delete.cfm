<cfset employeeModel = new model.Employee()>

<cfparam name="url.id" default="0">

<cfset employeeModel.delete(url.id)>

<cflocation url="/" addtoken="false">