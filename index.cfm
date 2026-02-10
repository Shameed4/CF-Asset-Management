<cfset employeeModel = new model.Employee()>
<cfset assetModel = new model.Asset()>

<cfquery name="stats">
    SELECT 
        (SELECT COUNT(*) FROM employees) as total_employees,
        (SELECT COUNT(*) FROM assets) as total_assets,
        (SELECT COALESCE(SUM(cost), 0) FROM assets) as total_value,
        (SELECT COUNT(*) FROM assets WHERE employee_id IS NULL) as unassigned_assets
</cfquery>

<cfset recentAssets = assetModel.getAll()>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Asset Management</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="header"><h1>Asset Management System</h1></div>
    <div class="nav">
        <a href="/">Dashboard</a>
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>
    
    <div class="container">
        <h2>Dashboard Overview</h2>
        <div class="stats">
            <cfoutput query="stats">
                <div class="stat-card"><h3>#total_employees#</h3><p>Total Employees</p></div>
                <div class="stat-card green"><h3>#total_assets#</h3><p>Total Assets</p></div>
                <div class="stat-card orange"><h3>$#numberFormat(total_value, "999,999")#</h3><p>Total Value</p></div>
                <div class="stat-card purple"><h3>#unassigned_assets#</h3><p>Unassigned</p></div>
            </cfoutput>
        </div>
        
        <div class="card">
            <h3>Recent Assets</h3>
            <table>
                <thead>
                    <tr>
                        <th>Asset Name</th>
                        <th>Serial Number</th>
                        <th>Assigned To</th>
                        <th>Date</th>
                        <th>Cost</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query="recentAssets" maxrows="5">
                        <tr>
                            <td>#asset_name#</td>
                            <td>#serial_number#</td>
                            <td>#employee_name ?: 'Unassigned'#</td>
                            <td>#dateFormat(assigned_date, "mm/dd/yyyy")#</td>
                            <td>$#numberFormat(cost, "9,999.99")#</td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>