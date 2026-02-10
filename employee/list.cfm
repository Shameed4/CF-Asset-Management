<cfset employeeModel = new model.Employee()>

<cfset employees = employeeModel.getAll()>

<!DOCTYPE html>
<html>
<head>
    <title>Employee List</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 0;
            background: #f5f5f5;
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
        .card {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        table { 
            border-collapse: collapse; 
            width: 100%; 
        }
        th, td { 
            border: 1px solid #ddd; 
            padding: 12px; 
            text-align: left; 
        }
        th { 
            background-color: #4CAF50; 
            color: white; 
        }
        tr:nth-child(even) { 
            background-color: #f2f2f2; 
        }
        .btn {
            padding: 8px 15px;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
            color: white;
            margin-right: 5px;
        }
        .btn-add { background: #4CAF50; padding: 10px 20px; }
        .btn-edit { background: #3498db; }
        .btn-delete { background: #e74c3c; }
    </style>
</head>
<body>
    <div class="nav">
        <a href="/">Dashboard</a>
        <a href="/employee/list.cfm">Employees</a>
        <a href="/asset/list.cfm">Assets</a>
    </div>

    <div class="container">
        <div class="card">
            <div class="header">
                <h1>Employee List</h1>
                <a href="add.cfm" class="btn btn-add">+ Add Employee</a>
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
                                <a href="edit.cfm?id=#id#" class="btn btn-edit">Edit</a>
                                <a href="delete.cfm?id=#id#" class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this employee?')">Delete</a>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
            
            <cfif employees.recordCount EQ 0>
                <p style="text-align: center; padding: 40px; color: #999;">
                    No employees found. <a href="add.cfm">Add your first employee</a>
                </p>
            </cfif>
        </div>
    </div>
</body>
</html>