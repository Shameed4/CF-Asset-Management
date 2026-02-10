<cfset assetModel = new model.Asset()>
<cfset assets = assetModel.getAll()>

<!DOCTYPE html>
<html>
<head>
    <title>Asset List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #3498db; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        .btn {
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 3px;
            display: inline-block;
            margin-right: 5px;
            color: white;
        }
        .btn-edit { background: #3498db; }
        .btn-delete { background: #e74c3c; }
        .btn-add { 
            background: #27ae60; 
            padding: 10px 20px;
            font-size: 16px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
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
        .nav a:hover {
            color: #3498db;
        }
    </style>
</head>
<body>
    <div class="nav">
        <a href="/">Dashboard</a>
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>

    <div class="header">
        <h1>Asset List</h1>
        <a href="add.cfm" class="btn btn-add">+ Add Asset</a>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>Asset Name</th>
                <th>Serial Number</th>
                <th>Assigned To</th>
                <th>Department</th>
                <th>Assigned Date</th>
                <th>Cost</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput query="assets">
                <tr>
                    <td>#asset_name#</td>
                    <td>#serial_number#</td>
                    <td>#employee_name ?: 'Unassigned'#</td>
                    <td>#department ?: '-'#</td>
                    <td>#dateFormat(assigned_date, "mm/dd/yyyy")#</td>
                    <td>$#numberFormat(cost, "999,999.99")#</td>
                    <td>
                        <a href="edit.cfm?id=#id#" class="btn btn-edit">Edit</a>
                        <a href="delete.cfm?id=#id#" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this asset?')">Delete</a>
                    </td>
                </tr>
            </cfoutput>
        </tbody>
    </table>
    
    <cfif assets.recordCount EQ 0>
        <p style="text-align: center; padding: 40px; color: #999;">
            No assets found. <a href="add.cfm">Add your first asset</a>
        </p>
    </cfif>
</body>
</html>