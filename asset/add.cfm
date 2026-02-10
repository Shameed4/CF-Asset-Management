<cfset assetModel = new model.Asset()>
<cfset employeeModel = new model.Employee()>
<cfset employees = employeeModel.getAll()>

<cfif structKeyExists(form, "submit")>
    <cfset assetModel.create(form.asset_name, form.serial_number, form.assigned_date, form.cost, val(form.employee_id))>
    <cflocation url="list.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Add Asset</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav"><a href="/employee/list.cfm">Employees</a><a href="/asset/list.cfm">Assets</a></div>
    <div class="container">
        <div class="card" style="max-width: 600px; margin: 0 auto;">
            <h1>Add New Asset</h1>
            <form method="post">
                <div class="form-group">
                    <label>Asset Name</label>
                    <input type="text" name="asset_name" required>
                </div>
                <div class="form-group">
                    <label>Serial Number</label>
                    <input type="text" name="serial_number" required>
                </div>
                <div class="form-group">
                    <label>Assign To</label>
                    <select name="employee_id">
                        <option value="0">-- Unassigned --</option>
                        <cfoutput query="employees"><option value="#id#">#name#</option></cfoutput>
                    </select>
                </div>
                <div class="form-group">
                    <label>Cost</label>
                    <input type="number" name="cost" step="0.01" required>
                </div>
                <button type="submit" name="submit" class="btn btn-success">Save Asset</button>
                <a href="list.cfm" class="btn btn-secondary">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>