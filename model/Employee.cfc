component {
    public query function getAll() {
        var qry = queryExecute("
            SELECT id, name, department, email
            FROM employees
            ORDER BY name
        ");
        return qry;
    }
    
    public query function getById(required numeric id) {
        var qry = queryExecute("
            SELECT id, name, department, email
            FROM employees
            WHERE id = :id
        ", {
            id: {value: arguments.id, cfsqltype: "cf_sql_integer"}
        });
        return qry;
    }
    
    public numeric function create(required string name, required string department, required string email) {
        var result = queryExecute("
            INSERT INTO employees (name, department, email)
            VALUES (:name, :department, :email)
        ", {
            name: {value: arguments.name, cfsqltype: "cf_sql_varchar"},
            department: {value: arguments.department, cfsqltype: "cf_sql_varchar"},
            email: {value: arguments.email, cfsqltype: "cf_sql_varchar"}
        }, {
            result: "insertResult"
        });
        
        return insertResult.generatedKey;
    }
    
    public void function update(required numeric id, required string name, required string department, required string email) {
        queryExecute("
            UPDATE employees
            SET name = :name,
                department = :department,
                email = :email
            WHERE id = :id
        ", {
            id: {value: arguments.id, cfsqltype: "cf_sql_integer"},
            name: {value: arguments.name, cfsqltype: "cf_sql_varchar"},
            department: {value: arguments.department, cfsqltype: "cf_sql_varchar"},
            email: {value: arguments.email, cfsqltype: "cf_sql_varchar"}
        });
    }
    
    public void function delete(required numeric id) {
        queryExecute("
            DELETE FROM employees
            WHERE id = :id
        ", {
            id: {value: arguments.id, cfsqltype: "cf_sql_integer"}
        });
    }
}