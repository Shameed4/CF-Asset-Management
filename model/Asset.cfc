component {
    public query function getAll() {
        var qry = queryExecute("
            SELECT 
                a.id,
                a.asset_name,
                a.serial_number,
                a.assigned_date,
                a.cost,
                a.employee_id,
                e.name as employee_name,
                e.department
            FROM assets a
            LEFT JOIN employees e ON a.employee_id = e.id
            ORDER BY a.assigned_date DESC
        ");
        return qry;
    }
    
    public query function getById(required numeric id) {
        var qry = queryExecute("
            SELECT 
                a.id,
                a.asset_name,
                a.serial_number,
                a.assigned_date,
                a.cost,
                a.employee_id,
                e.name as employee_name
            FROM assets a
            LEFT JOIN employees e ON a.employee_id = e.id
            WHERE a.id = :id
        ", {
            id: {value: arguments.id, cfsqltype: "cf_sql_integer"}
        });
        return qry;
    }
    
    public numeric function create(
        required string asset_name,
        required string serial_number,
        required date assigned_date,
        required numeric cost,
        numeric employee_id = 0
    ) {
        var empId = (arguments.employee_id EQ 0) ? javaCast("null", "") : arguments.employee_id;
        
        var result = queryExecute("
            INSERT INTO assets (employee_id, asset_name, serial_number, assigned_date, cost)
            VALUES (:employee_id, :asset_name, :serial_number, :assigned_date, :cost)
        ", {
            employee_id: {value: empId, cfsqltype: "cf_sql_integer", null: (arguments.employee_id EQ 0)},
            asset_name: {value: arguments.asset_name, cfsqltype: "cf_sql_varchar"},
            serial_number: {value: arguments.serial_number, cfsqltype: "cf_sql_varchar"},
            assigned_date: {value: arguments.assigned_date, cfsqltype: "cf_sql_date"},
            cost: {value: arguments.cost, cfsqltype: "cf_sql_decimal"}
        }, {
            result: "insertResult"
        });
        
        return insertResult.generatedKey;
    }
    
    public void function update(
        required numeric id,
        required string asset_name,
        required string serial_number,
        required date assigned_date,
        required numeric cost,
        numeric employee_id = 0
    ) {
        var empId = (arguments.employee_id EQ 0) ? javaCast("null", "") : arguments.employee_id;
        
        queryExecute("
            UPDATE assets
            SET employee_id = :employee_id,
                asset_name = :asset_name,
                serial_number = :serial_number,
                assigned_date = :assigned_date,
                cost = :cost
            WHERE id = :id
        ", {
            id: {value: arguments.id, cfsqltype: "cf_sql_integer"},
            employee_id: {value: empId, cfsqltype: "cf_sql_integer", null: (arguments.employee_id EQ 0)},
            asset_name: {value: arguments.asset_name, cfsqltype: "cf_sql_varchar"},
            serial_number: {value: arguments.serial_number, cfsqltype: "cf_sql_varchar"},
            assigned_date: {value: arguments.assigned_date, cfsqltype: "cf_sql_date"},
            cost: {value: arguments.cost, cfsqltype: "cf_sql_decimal"}
        });
    }
    
    public void function delete(required numeric id) {
        queryExecute("
            DELETE FROM assets
            WHERE id = :id
        ", {
            id: {value: arguments.id, cfsqltype: "cf_sql_integer"}
        });
    }
}