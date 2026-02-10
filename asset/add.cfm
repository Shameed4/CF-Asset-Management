<cfset assetModel = new model.Asset()>
<cfset employeeModel = new model.Employee()>

<cfset employees = employeeModel.getAll()>

<cfif structKeyExists(form, "submit")>
    <cfset assetModel.create(
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
    <title>Add Asset</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px;
            max-width: 600px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input, select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #27ae60;
            color: white;
        }
        .btn-secondary {
            background-color: #999;
            color: white;
        }
        .nav {
            margin-bottom: 20px;
            padding: 10px;
            background: #ecf0f1;
            border-radius: 4px;
        }
        .nav a {
            margin-right: 15px;
            text-decoration: none;
            color: #2c3e50;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="nav">
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>

    <h1>Add New Asset</h1>
    
    <form method="post">
        <div class="form-group">
            <label for="asset_name">Asset Name:</label>
            <input type="text" id="asset_name" name="asset_name" required>
        </div>
        
        <div class="form-group">
            <label for="serial_number">Serial Number:</label>
            <input type="text" id="serial_number" name="serial_number" required>
        </div>
        
        <div class="form-group">
            <label for="employee_id">Assign To Employee:</label>
            <select id="employee_id" name="employee_id">
                <option value="0">-- Unassigned --</option>
                <cfoutput query="employees">
                    <option value="#id#">#name# (#department#)</option>
                </cfoutput>
            </select>
        </div>
        
        <div class="form-group">
            <label for="assigned_date">Assigned Date:</label>
            <input type="date" id="assigned_date" name="assigned_date" value="<cfoutput>#dateFormat(now(), 'yyyy-mm-dd')#</cfoutput>" required>
        </div>
        
        <div class="form-group">
            <label for="cost">Cost ($):</label>
            <input type="number" id="cost" name="cost" step="0.01" min="0" required>
        </div>
        
        <button type="submit" name="submit" class="btn btn-primary">Add Asset</button>
        <a href="list.cfm" class="btn btn-secondary">Cancel</a>
    </form>
</body>
</html>