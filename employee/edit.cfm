<cfset employeeModel = new model.Employee()>
<cfparam name="url.id" default="0">
<cfset employee = employeeModel.getById(url.id)>

<cfif structKeyExists(form, "submit")>
    <cfset employeeModel.update(url.id, form.name, form.department, form.email)>
    <cflocation url="list.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <div class="card" style="max-width: 600px; margin: 0 auto;">
            <h1>Edit Employee</h1>
            <cfoutput query="employee">
                <form method="post">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" name="name" value="#name#" required>
                    </div>
                    <div class="form-group">
                        <label>Department</label>
                        <input type="text" name="department" value="#department#" required>
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" value="#email#" required>
                    </div>
                    <button type="submit" name="submit" class="btn btn-primary">Update</button>
                    <a href="list.cfm" class="btn btn-secondary">Cancel</a>
                </form>
            </cfoutput>
        </div>
    </div>
</body>
</html>