<cfset employeeModel = new model.Employee()>

<cfif structKeyExists(form, "submit")>
    <cfset employeeModel.create(
        name = form.name,
        department = form.department,
        email = form.email
    )>
    <cflocation url="list.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Add Employee - AssetTracker</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/">Dashboard</a>
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>

    <div class="container">
        <div class="card" style="max-width: 600px; margin: 0 auto;">
            <div class="page-header">
                <h1>Add New Employee</h1>
            </div>
            
            <form method="post">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" placeholder="e.g. John Doe" required>
                </div>
                
                <div class="form-group">
                    <label for="department">Department</label>
                    <input type="text" id="department" name="department" placeholder="e.g. Engineering" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" placeholder="john.doe@company.com" required>
                </div>
                
                <div style="margin-top: 30px;">
                    <button type="submit" name="submit" class="btn btn-success">Create Employee</button>
                    <a href="list.cfm" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>