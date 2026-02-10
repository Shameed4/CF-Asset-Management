<cfset employeeModel = new model.Employee()>

<cfparam name="url.id" default="0">

<cfset employee = employeeModel.getById(url.id)>

<cfif employee.recordCount EQ 0>
    <cflocation url="index.cfm" addtoken="false">
</cfif>

<cfif structKeyExists(form, "submit")>
    <cfset employeeModel.update(
        id = url.id,
        name = form.name,
        department = form.department,
        email = form.email
    )>
    <cflocation url="list.cfm" addtoken="false">
</cfif>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Employee</title>
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
    <h1>Edit Employee</h1>
    
    <cfoutput query="employee">
        <form method="post">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="#name#" required>
            </div>
            
            <div class="form-group">
                <label for="department">Department:</label>
                <input type="text" id="department" name="department" value="#department#" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="#email#" required>
            </div>
            
            <button type="submit" name="submit" class="btn btn-primary">Update Employee</button>
            <a href="list.cfm" class="btn btn-secondary">Cancel</a>
        </form>
    </cfoutput>
</body>
</html>