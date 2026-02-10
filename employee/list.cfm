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
                <div style="display: flex; gap: 10px;">
                    <input type="text" id="employeeSearchBox" placeholder="Search name or dept..." style="padding: 8px; width: 200px;">
                    <a href="add.cfm" class="btn btn-success">+ Add Employee</a>
                </div>
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
                <tbody id="employeeTableBody">
                    <cfoutput query="employees">
                        <tr>
                            <td>#id#</td>
                            <td>#name#</td>
                            <td>#department#</td>
                            <td>#email#</td>
                            <td>
                                <a href="edit.cfm?id=#id#" class="btn btn-primary btn-sm">Edit</a>
                                <a href="delete.cfm?id=#id#" class="btn btn-danger btn-sm" onclick="return confirm('Delete this employee?')">Delete</a>
                            </td>
                        </tr>
                    </cfoutput>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        const empSearchBox = document.getElementById('employeeSearchBox');
        const empTbody = document.getElementById('employeeTableBody');

        empSearchBox.addEventListener('keyup', (e) => {
            const query = e.target.value;

            fetch(`/api/employees.cfm?q=${query}`)
                .then(response => response.json())
                .then(data => {
                    empTbody.innerHTML = '';

                    if (data.length === 0) {
                        empTbody.innerHTML = '<tr><td colspan="5" style="text-align:center; color: #999;">No employees found</td></tr>';
                    } else {
                        data.forEach(emp => {
                            const row = `
                                <tr>
                                    <td>${emp.id}</td>
                                    <td>${emp.name}</td>
                                    <td>${emp.department}</td>
                                    <td>${emp.email}</td>
                                    <td>
                                        <a href="edit.cfm?id=${emp.id}" class="btn btn-primary btn-sm">Edit</a>
                                        <a href="delete.cfm?id=${emp.id}" class="btn btn-danger btn-sm" onclick="return confirm('Delete this employee?')">Delete</a>
                                    </td>
                                </tr>
                            `;
                            empTbody.innerHTML += row;
                        });
                    }
                })
                .catch(error => console.error('Error:', error));
        });
    </script>
</body>
</html>