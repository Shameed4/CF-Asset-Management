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
    <div style="display: flex; justify-content: space-between; align-items: center;">
        <h1>Employee List</h1>
        <a href="employee/add.cfm" style="background: #4CAF50; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px;">+ Add Employee</a>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Department</th>
                <th>Email</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <cfoutput query="employees">
                <tr>
                    <td>#id#</td>
                    <td>#name#</td>
                    <td>#department#</td>
                    <td>#email#</td>
                    <td>
                        <a href="employee/edit.cfm?id=#id#" style="background: ##3498db; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px; margin-right: 5px;">Edit</a>
                        <a href="employee/delete.cfm?id=#id#" style="background: ##e74c3c; color: white; padding: 5px 10px; text-decoration: none; border-radius: 3px;" onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a>
                    </td>
                </tr>
            </cfoutput>
        </tbody>
    </table>
</body>
</html>