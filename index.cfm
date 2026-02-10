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
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 0;
            background: #f5f5f5;
        }
        .header {
            background: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
        }
        .nav {
            background: #34495e;
            padding: 15px 20px;
            display: flex;
            gap: 20px;
        }
        .nav a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 8px 15px;
            border-radius: 4px;
            transition: background 0.3s;
        }
        .nav a:hover {
            background: #2c3e50;
        }
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-card h3 {
            font-size: 2.5rem;
            margin: 0 0 10px 0;
            color: #3498db;
        }
        .stat-card p {
            margin: 0;
            color: #7f8c8d;
            font-size: 1.1rem;
        }
        .stat-card.green h3 { color: #27ae60; }
        .stat-card.orange h3 { color: #e67e22; }
        .stat-card.purple h3 { color: #9b59b6; }
        .card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ecf0f1;
        }
        th {
            background: #3498db;
            color: white;
        }
        tr:hover {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>🏢 Asset Management System</h1>
    </div>
    
    <div class="nav">
        <a href="/">Dashboard</a>
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>
    
    <div class="container">
        <h2>Dashboard Overview</h2>
        
        <div class="stats">
            <cfoutput query="stats">
                <div class="stat-card">
                    <h3>#total_employees#</h3>
                    <p>Total Employees</p>
                </div>
                
                <div class="stat-card green">
                    <h3>#total_assets#</h3>
                    <p>Total Assets</p>
                </div>
                
                <div class="stat-card orange">
                    <h3>$#numberFormat(total_value, "999,999")#</h3>
                    <p>Total Asset Value</p>
                </div>
                
                <div class="stat-card purple">
                    <h3>#unassigned_assets#</h3>
                    <p>Unassigned Assets</p>
                </div>
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
                            <td>$#numberFormat(cost, "999,999.99")#</td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>