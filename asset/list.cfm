<cfset assetModel = new model.Asset()>
<cfset assets = assetModel.getAll()>

<!DOCTYPE html>
<html>
<head>
    <title>Asset List</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="nav">
        <a href="/">Dashboard</a>
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>
    <div class="container">
        <div class="card">
            <div class="page-header">
                <h1>Asset List</h1>
                <a href="add.cfm" class="btn btn-success">+ Add Asset</a>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Asset Name</th>
                        <th>Serial</th>
                        <th>Assigned To</th>
                        <th>Dept</th>
                        <th>Date</th>
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
                            <td>$#numberFormat(cost, "9,999.99")#</td>
                            <td>
                                <a href="edit.cfm?id=#id#" class="btn btn-primary btn-sm">Edit</a>
                                <a href="delete.cfm?id=#id#" class="btn btn-danger btn-sm" onclick="return confirm('Delete?')">Delete</a>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>