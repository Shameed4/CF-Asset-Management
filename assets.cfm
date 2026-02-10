<!DOCTYPE html>
<html>
<head>
    <title>Asset Tracker</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Asset Tracker - All Assets</h1>
    
    <cfquery name="getAssets">
        SELECT 
            a.id,
            a.asset_name,
            a.serial_number,
            a.assigned_date,
            a.cost,
            e.name as employee_name,
            e.department
        FROM assets a
        LEFT JOIN employees e ON a.employee_id = e.id
        ORDER BY a.assigned_date DESC
    </cfquery>
    
    <cfoutput>
        <p>Total Assets: #getAssets.recordCount#</p>
    </cfoutput>
    
    <table>
        <thead>
            <tr>
                <th>Asset Name</th>
                <th>Serial Number</th>
                <th>Assigned To</th>
                <th>Department</th>
                <th>Assigned Date</th>
                <th>Cost</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput query="getAssets">
                <tr>
                    <td>#asset_name#</td>
                    <td>#serial_number#</td>
                    <td>#employee_name#</td>
                    <td>#department#</td>
                    <td>#dateFormat(assigned_date, "mm/dd/yyyy")#</td>
                    <td>$#numberFormat(cost, "9,999.99")#</td>
                </tr>
            </cfoutput>
        </tbody>
    </table>
    
    <h2>Assets by Employee</h2>
    
    <cfquery name="getEmployees">
        SELECT id, name, department, email
        FROM employees
        ORDER BY name
    </cfquery>
    
    <cfloop query="getEmployees">
        <cfquery name="employeeAssets">
            SELECT asset_name, serial_number, cost
            FROM assets
            WHERE employee_id = <cfqueryparam value="#id#" cfsqltype="cf_sql_integer">
        </cfquery>
        
        <cfoutput>
            <h3>#name# (#department#)</h3>
            <p>Email: #email#</p>
            
            <cfif employeeAssets.recordCount GT 0>
                <ul>
                    <cfloop query="employeeAssets">
                        <li>#asset_name# - #serial_number# ($#numberFormat(cost, "9,999.99")#)</li>
                    </cfloop>
                </ul>
            <cfelse>
                <p><em>No assets assigned</em></p>
            </cfif>
        </cfoutput>
    </cfloop>
    
</body>
</html>