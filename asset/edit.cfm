<cfset assetModel = new model.Asset()>
<cfset employeeModel = new model.Employee()>

<cfparam name="url.id" default="0">
<cfset asset = assetModel.getById(url.id)>

<cfif asset.recordCount EQ 0>
    <cflocation url="list.cfm" addtoken="false">
</cfif>

<cfset employees = employeeModel.getAll()>

<cfif structKeyExists(form, "submit")>
    <cfset assetModel.update(
        id = url.id,
        asset_name = form.asset_name,
        serial_number = form.serial_number,
        assigned_date = form.assigned_date,
        cost = form.cost,
        employee_id = val(form.employee_id)
    )>
    <cflocation url="list.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Asset - AssetTracker</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>

    <div class="container">
        <div class="card" style="max-width: 600px; margin: 0 auto;">
            <div class="page-header">
                <h1>Edit Asset</h1>
                <span style="color: ##7f8c8d; font-size: 0.9rem;">ID: #url.id#</span>
            </div>
            
            <cfoutput query="asset">
                <form method="post">
                    <div class="form-group">
                        <label for="asset_name">Asset Name</label>
                        <input type="text" id="asset_name" name="asset_name" value="#asset_name#" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="serial_number">Serial Number</label>
                        <input type="text" id="serial_number" name="serial_number" value="#serial_number#" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="employee_id">Assigned To</label>
                        <select id="employee_id" name="employee_id">
                            <option value="0">-- Unassigned --</option>
                            <cfloop query="employees">
                                <option value="#employees.id#" <cfif employees.id EQ asset.employee_id>selected</cfif>>
                                    #employees.name# (#employees.department#)
                                </option>
                            </cfloop>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="assigned_date">Date Assigned</label>
                        <input type="date" id="assigned_date" name="assigned_date" value="#dateFormat(assigned_date, 'yyyy-mm-dd')#" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="cost">Cost ($)</label>
                        <input type="number" id="cost" name="cost" step="0.01" min="0" value="#cost#" required>
                    </div>
                    
                    <div style="margin-top: 30px;">
                        <button type="submit" name="submit" class="btn btn-primary">Update Asset</button>
                        <a href="list.cfm" class="btn btn-secondary">Cancel</a>
                    </div>
                </form>
            </cfoutput>
        </div>
    </div>
</body>
</html>