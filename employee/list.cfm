<cfset employeeModel = new model.Employee()>
<cfset employees = employeeModel.getAll()>

<!DOCTYPE html>
<html>
<head>
    <title>Employee List</title>
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
                <h1>Employee List</h1>
                <a href="add.cfm" class="btn btn-success">+ Add Employee</a>
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