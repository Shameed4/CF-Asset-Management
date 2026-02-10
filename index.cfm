<cfset employeeModel = new model.Employee()>
<cfset employees = employeeModel.getAll()>

<!DOCTYPE html>
<html>
<head>
    <title>Employee List</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Employee List</h1>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Department</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput query="employees">
                <tr>
                    <td>#id#</td>
                    <td>#name#</td>
                    <td>#department#</td>
                    <td>#email#</td>
                </tr>
            </cfoutput>
        </tbody>
    </table>
</body>
</html>