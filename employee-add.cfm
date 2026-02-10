<cfset employeeModel = new model.Employee()>

<cfif structKeyExists(form, "submit")>
    <cfset employeeModel.create(
        name = form.name,
        department = form.department,
        email = form.email
    )>
    <cflocation url="index.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Add Employee</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px;
            max-width: 600px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-secondary {
            background-color: #999;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Add New Employee</h1>
    
    <form method="post">
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>
        
        <div class="form-group">
            <label for="department">Department:</label>
            <input type="text" id="department" name="department" required>
        </div>
        
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        
        <button type="submit" name="submit" class="btn btn-primary">Add Employee</button>
        <a href="index.cfm" class="btn btn-secondary">Cancel</a>
    </form>
</body>
</html>